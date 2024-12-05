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

part 'ton_wallet_send_bloc.freezed.dart';

part 'ton_wallet_send_event.dart';

part 'ton_wallet_send_state.dart';

/// Bloc that allows prepare transaction to send native funds from [TonWallet]
/// for confirmation and send transaction.
class TonWalletSendBloc extends Bloc<TonWalletSendEvent, TonWalletSendState> {
  TonWalletSendBloc({
    required this.context,
    required this.nekotonRepository,
    required this.messengerService,
    required this.address,
    required this.publicKey,
    required this.destination,
    required this.amount,
    required this.comment,
    required this.resultMessage,
    this.needRepack = true,
  }) : super(const TonWalletSendState.loading()) {
    _registerHandlers();
  }

  final _logger = Logger('TonWalletSendBloc');
  final BuildContext context;
  final NekotonRepository nekotonRepository;
  final MessengerService messengerService;

  /// Address of TonWallet that will be used to send funds
  final Address address;

  /// Custodian of [address] that will be initiator of transaction (for not
  /// multisig this is main key).
  final PublicKey publicKey;

  /// Address where funds should be sent
  final Address destination;
  late Address repackedDestination;

  /// if true, then [repackedDestination] will be calculated during
  /// [_handlePrepare], if false, then it must be set manually during creation
  /// of bloc.
  final bool needRepack;

  /// Amount of tokens that should be sent
  final BigInt amount;

  /// Comment for transaction
  final String? comment;

  /// Message that will be shown when transaction sending completed
  final String resultMessage;

  /// Fee for transaction after calculating it in [_handlePrepare]
  BigInt? fees;

  KeyAccount? account;

  late UnsignedMessage unsignedMessage;
  UnsignedMessage? _unsignedMessage;

  List<TxTreeSimulationErrorItem>? txErrors;

  TransportStrategy get transport => nekotonRepository.currentTransport;

  Currency get currency => Currencies()[transport.nativeTokenTicker]!;

  void _registerHandlers() {
    on<_Prepare>((event, emit) => _handlePrepare(emit));
    on<_Send>((event, emit) => _handleSend(emit, event.password));
    on<_CompleteSend>(
      (event, emit) {
        if (fees != null) {
          emit(TonWalletSendState.sent(fees!, event.transaction));
        }
      },
    );
    on<_AllowCloseSend>(
      (event, emit) => emit(const TonWalletSendState.sending(canClose: true)),
    );
  }

  Future<void> _handlePrepare(Emitter<TonWalletSendState> emit) async {
    try {
      account = nekotonRepository.seedList.findAccountByAddress(address);

      if (needRepack) {
        repackedDestination = await repackAddress(destination);
      }

      unsignedMessage = await nekotonRepository.prepareTransfer(
        address: address,
        publicKey: publicKey,
        destination: repackedDestination,
        amount: amount,
        body: comment,
        bounce: defaultMessageBounce,
        expiration: defaultSendTimeout,
      );
      _unsignedMessage = unsignedMessage;

      final result = await FutureExt.wait2(
        nekotonRepository.estimateFees(
          address: address,
          message: unsignedMessage,
        ),
        nekotonRepository.simulateTransactionTree(
          address: address,
          message: unsignedMessage,
        ),
      );
      fees = result.$1;
      txErrors = result.$2;

      final walletState = await nekotonRepository.walletsStream
          .expand((e) => e)
          .firstWhere((wallets) => wallets.address == address);

      if (walletState.hasError) {
        emit(TonWalletSendState.subscribeError(walletState.error!));
        return;
      }

      final wallet = walletState.wallet!;
      final balance = wallet.contractState.balance;

      final isPossibleToSendMessage =
          fees != null && balance > (fees! + amount);

      if (!isPossibleToSendMessage) {
        emit(
          TonWalletSendState.calculatingError(
            LocaleKeys.insufficientFunds.tr(),
            fees,
          ),
        );

        return;
      }

      if (fees != null) {
        emit(TonWalletSendState.readyToSend(fees!, txErrors));
      }
    } on FfiException catch (e, t) {
      _logger.severe('_handleSend', e, t);
      emit(TonWalletSendState.calculatingError(e.message));
    } on Exception catch (e, t) {
      _logger.severe('_handleSend', e, t);
      emit(TonWalletSendState.calculatingError(e.toString()));
    }
  }

  Future<void> _handleSend(
    Emitter<TonWalletSendState> emit,
    String password,
  ) async {
    try {
      emit(const TonWalletSendState.sending(canClose: false));
      await unsignedMessage.refreshTimeout();

      final hash = unsignedMessage.hash;
      final transport = nekotonRepository.currentTransport.transport;

      final signature = await nekotonRepository.seedList.sign(
        data: hash,
        publicKey: publicKey,
        password: password,
        signatureId: await transport.getSignatureId(),
      );

      final signedMessage = await unsignedMessage.sign(signature: signature);

      emit(const TonWalletSendState.sending(canClose: true));

      final transaction = await nekotonRepository.send(
        address: address,
        signedMessage: signedMessage,
        amount: amount,
        destination: repackedDestination,
      );

      messengerService
          .show(Message.successful(context: context, message: resultMessage));
      if (!isClosed) {
        add(TonWalletSendEvent.completeSend(transaction));
      }
    } on FfiException catch (e, t) {
      _logger.severe('_handleSend', e, t);
      messengerService
          .show(Message.error(context: context, message: e.message));
      if (fees != null) {
        emit(TonWalletSendState.readyToSend(fees!, txErrors));
      }
    } on Exception catch (e, t) {
      _logger.severe('_handleSend', e, t);
      messengerService
          .show(Message.error(context: context, message: e.toString()));

      if (fees != null) {
        emit(TonWalletSendState.readyToSend(fees!, txErrors));
      }
    }
  }

  @override
  Future<void> close() {
    _unsignedMessage?.dispose();

    return super.close();
  }
}
