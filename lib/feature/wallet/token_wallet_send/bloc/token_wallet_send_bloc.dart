// ignore_for_file: use_build_context_synchronously

import 'package:app/app/service/service.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/constants.dart';
import 'package:app/utils/utils.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

part 'token_wallet_send_bloc.freezed.dart';

part 'token_wallet_send_event.dart';

part 'token_wallet_send_state.dart';

/// Bloc that allows to prepare not native token from [TokenWallet] for
/// confirmation and sending transaction.
class TokenWalletSendBloc
    extends Bloc<TokenWalletSendEvent, TokenWalletSendState> {
  TokenWalletSendBloc({
    required this.context,
    required this.nekotonRepository,
    required this.messengerService,
    required this.owner,
    required this.rootTokenContract,
    required this.publicKey,
    required this.destination,
    required this.tokenAmount,
    required this.attachedAmount,
    required this.comment,
    required this.resultMessage,
  }) : super(const TokenWalletSendState.init()) {
    _registerHandlers();
  }

  final _logger = Logger('TokenWalletSendBloc');
  final BuildContext context;
  final NekotonRepository nekotonRepository;
  final MessengerService messengerService;

  /// Address of account for token.
  final Address owner;

  /// Address of contract for token
  final Address rootTokenContract;

  /// Local custodian of account, that will be initiator of transaction (for not
  /// multisig this is main key).
  final PublicKey publicKey;

  /// Address where tokens must be sent
  final Address destination;
  late Address repackedDestination;

  /// How many tokens must be sent, to convert Fixed to BigInt, use
  /// [Fixed.minorUnits].
  final BigInt tokenAmount;
  late BigInt sendAmount;

  /// Attached amount in native tokens, that should be added to transaction.
  final BigInt? attachedAmount;

  /// Comment for transaction
  final String? comment;

  /// Message that will be shown when transaction completed
  final String resultMessage;

  /// Fee for transaction after calculating it in [_handlePrepare]
  BigInt? fees;

  late Currency tokenCurrency;

  KeyAccount? account;

  UnsignedMessage? unsignedMessage;
  UnsignedMessage? _unsignedMessage;

  List<TxTreeSimulationErrorItem>? txErrors;

  TransportStrategy get transport => nekotonRepository.currentTransport;

  Currency get currency => Currencies()[transport.nativeTokenTicker]!;

  void _registerHandlers() {
    on<_Prepare>((event, emit) => _handlePrepare(emit));
    on<_Send>((event, emit) => _handleSend(emit, event.password));
    on<_CompleteSend>(
      (event, emit) => emit(
        TokenWalletSendState.sent(fees!, event.transaction),
      ),
    );
    on<_AllowCloseSend>(
      (event, emit) => emit(const TokenWalletSendState.sending(canClose: true)),
    );
  }

  // ignore: long-method
  Future<void> _handlePrepare(Emitter<TokenWalletSendState> emit) async {
    try {
      account = nekotonRepository.seedList.findAccountByAddress(owner);

      final (tokenWalletState, walletState) = await FutureExt.wait2(
        nekotonRepository.tokenWalletsStream.expand((e) => e).firstWhere(
              (wallet) =>
                  wallet.owner == owner &&
                  wallet.rootTokenContract == rootTokenContract,
            ),
        nekotonRepository.walletsStream
            .expand((e) => e)
            .firstWhere((wallets) => wallets.address == owner),
      );

      if (tokenWalletState.hasError) {
        emit(TokenWalletSendState.subscribeError(tokenWalletState.error!));
        return;
      }
      if (walletState.hasError) {
        emit(TokenWalletSendState.subscribeError(walletState.error!));
        return;
      }

      final tokenWallet = tokenWalletState.wallet!;
      final wallet = walletState.wallet!;

      tokenCurrency = tokenWallet.currency;
      emit(const TokenWalletSendState.loading());

      final internalMessage = await nekotonRepository.prepareTokenTransfer(
        owner: owner,
        rootTokenContract: rootTokenContract,
        destination: await repackAddress(destination),
        amount: tokenAmount,
        payload: comment,
        attachedAmount: attachedAmount,
        notifyReceiver: true,
      );

      repackedDestination = internalMessage.destination;
      sendAmount = internalMessage.amount;

      try {
        unsignedMessage = await nekotonRepository.prepareTransfer(
          address: owner,
          publicKey: publicKey,
          destination: repackedDestination,
          amount: sendAmount,
          body: internalMessage.body,
          bounce: defaultMessageBounce,
          expiration: defaultSendTimeout,
        );
      } finally {
        _unsignedMessage = unsignedMessage;
      }

      final msg = unsignedMessage;

      if (msg == null) {
        return;
      }

      final result = await FutureExt.wait2(
        nekotonRepository.estimateFees(
          address: owner,
          message: msg,
        ),
        nekotonRepository.simulateTransactionTree(
          address: owner,
          message: msg,
        ),
      );
      fees = result.$1;
      txErrors = result.$2;

      final balance = wallet.contractState.balance;
      final isPossibleToSendMessage =
          balance > (fees! + internalMessage.amount);

      if (!isPossibleToSendMessage) {
        emit(
          TokenWalletSendState.calculatingError(
            LocaleKeys.insufficientFunds.tr(),
            fees,
          ),
        );
        return;
      }

      emit(TokenWalletSendState.readyToSend(fees!, sendAmount, txErrors));
    } on FfiException catch (e, t) {
      _logger.severe('_handleSend', e, t);
      emit(TokenWalletSendState.calculatingError(e.message));
    } on Exception catch (e, t) {
      _logger.severe('_handleSend', e, t);
      emit(TokenWalletSendState.calculatingError(e.toString()));
    }
  }

  Future<void> _handleSend(
    Emitter<TokenWalletSendState> emit,
    String password,
  ) async {
    try {
      final msg = unsignedMessage;

      if (msg == null) {
        return;
      }

      emit(const TokenWalletSendState.sending(canClose: false));
      await msg.refreshTimeout();

      final hash = msg.hash;
      final transport = nekotonRepository.currentTransport.transport;

      final signature = await nekotonRepository.seedList.sign(
        data: hash,
        publicKey: publicKey,
        password: password,
        signatureId: await transport.getSignatureId(),
      );

      final signedMessage = await msg.sign(signature: signature);

      emit(const TokenWalletSendState.sending(canClose: true));

      final transaction = await nekotonRepository.send(
        address: owner,
        signedMessage: signedMessage,
        amount: sendAmount,
        destination: repackedDestination,
      );

      messengerService.show(
        Message.successful(
          context: context,
          message: resultMessage,
        ),
      );
      if (!isClosed) {
        add(TokenWalletSendEvent.completeSend(transaction));
      }
    } on FfiException catch (e, t) {
      _logger.severe('_handleSend', e, t);
      messengerService.show(
        Message.error(
          context: context,
          message: e.message,
        ),
      );
      emit(TokenWalletSendState.readyToSend(fees!, sendAmount, txErrors));
    } on Exception catch (e, t) {
      _logger.severe('_handleSend', e, t);
      messengerService
          .show(Message.error(context: context, message: e.toString()));
      emit(TokenWalletSendState.readyToSend(fees!, sendAmount, txErrors));
    }
  }

  @override
  Future<void> close() {
    unsignedMessage?.dispose();
    _unsignedMessage?.dispose();

    return super.close();
  }
}
