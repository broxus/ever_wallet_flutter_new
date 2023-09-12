import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/constants.dart';
import 'package:bloc/bloc.dart';
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
    required this.nekotonRepository,
    required this.owner,
    required this.rootTokenContract,
    required this.publicKey,
    required this.destination,
    required this.tokenAmount,
    required BigInt? attachedAmount,
    required this.comment,
  })  : attachedAmount = attachedAmount ?? defaultAttachAmount,
        super(const TokenWalletSendState.init()) {
    _registerHandlers();
  }

  final _logger = Logger('TokenWalletSendBloc');
  final NekotonRepository nekotonRepository;

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
  final BigInt attachedAmount;

  /// Comment for transaction
  final String? comment;

  /// Fee for transaction after calculating it in [_handlePrepare]
  BigInt? fees;

  late Currency tokenCurrency;

  late UnsignedMessage unsignedMessage;
  UnsignedMessage? _unsignedMessage;

  void _registerHandlers() {
    on<_Prepare>((event, emit) => _handlePrepare(emit));
    on<_Send>((event, emit) => _handleSend(emit, event.password));
    on<_CompleteSend>(
      (event, emit) => emit(
        TokenWalletSendState.sent(fees!, tokenCurrency, event.transaction),
      ),
    );
    on<_AllowCloseSend>(
      (event, emit) => emit(const TokenWalletSendState.sending(canClose: true)),
    );
  }

  // ignore: long-method
  Future<void> _handlePrepare(Emitter<TokenWalletSendState> emit) async {
    try {
      final tokenWallet = await nekotonRepository.tokenWalletsStream
          .expand((e) => e)
          .firstWhere(
            (wallet) =>
                wallet.owner == owner &&
                wallet.rootTokenContract == rootTokenContract,
          );
      tokenCurrency = tokenWallet.currency;
      emit(TokenWalletSendState.loading(tokenCurrency));

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
      unsignedMessage = await nekotonRepository.prepareTransfer(
        address: owner,
        publicKey: publicKey,
        destination: repackedDestination,
        amount: sendAmount,
        body: internalMessage.body,
        bounce: defaultMessageBounce,
        expiration: defaultSendTimeout,
      );
      _unsignedMessage = unsignedMessage;

      fees = await nekotonRepository.estimateFees(
        address: owner,
        message: unsignedMessage,
      );

      final wallet = await nekotonRepository.walletsStream
          .expand((e) => e)
          .firstWhere((wallets) => wallets.address == owner);

      final balance = wallet.contractState.balance;

      final isPossibleToSendMessage =
          balance > (fees! + internalMessage.amount);

      if (!isPossibleToSendMessage) {
        emit(
          TokenWalletSendState.calculatingError(
            LocaleKeys.insufficientFunds.tr(),
            tokenCurrency,
            fees,
          ),
        );

        return;
      }

      emit(TokenWalletSendState.readyToSend(fees!, tokenCurrency));
    } on FfiException catch (e, t) {
      _logger.severe('_handleSend', e, t);
      emit(TokenWalletSendState.calculatingError(e.message, tokenCurrency));
    } on Exception catch (e, t) {
      _logger.severe('_handleSend', e, t);
      emit(TokenWalletSendState.calculatingError(e.toString(), tokenCurrency));
    }
  }

  Future<void> _handleSend(
    Emitter<TokenWalletSendState> emit,
    String password,
  ) async {
    try {
      emit(const TokenWalletSendState.sending(canClose: false));
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

      emit(const TokenWalletSendState.sending(canClose: true));

      final transaction = await nekotonRepository.send(
        address: owner,
        signedMessage: signedMessage,
        amount: sendAmount,
        destination: repackedDestination,
      );

      inject<MessengerService>().show(
        Message.successful(
          message: LocaleKeys.transactionSentSuccessfully.tr(),
        ),
      );
      if (!isClosed) {
        add(TokenWalletSendEvent.completeSend(transaction));
      }
    } on FfiException catch (e, t) {
      _logger.severe('_handleSend', e, t);
      inject<MessengerService>().show(Message.error(message: e.message));
      emit(TokenWalletSendState.readyToSend(fees!, tokenCurrency));
    } on Exception catch (e, t) {
      _logger.severe('_handleSend', e, t);
      inject<MessengerService>().show(Message.error(message: e.toString()));
      emit(TokenWalletSendState.readyToSend(fees!, tokenCurrency));
    }
  }

  @override
  Future<void> close() {
    _unsignedMessage?.dispose();
    return super.close();
  }
}
