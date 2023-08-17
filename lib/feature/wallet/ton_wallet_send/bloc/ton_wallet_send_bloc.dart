import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

part 'ton_wallet_send_state.dart';

part 'ton_wallet_send_event.dart';

part 'ton_wallet_send_bloc.freezed.dart';

const messageBounce = false;
const defaultSendTimeout = Expiration.timeout(60);

/// Bloc that allows prepare transaction to send native funds from TonWallet
/// for confirmation and send transaction.
class TonWalletSendBloc extends Bloc<TonWalletSendEvent, TonWalletSendState> {
  TonWalletSendBloc({
    required this.nekotonRepository,
    required this.address,
    required this.publicKey,
    required this.destination,
    required this.amount,
    required this.comment,
  }) : super(const TonWalletSendState.loading()) {
    _registerHandlers();
  }

  final _logger = Logger('TonWalletSendBloc');
  final NekotonRepository nekotonRepository;

  /// Address of TonWallet that will be used to send funds
  final Address address;

  /// Custodian of [address] that will be initiator of transaction (for not
  /// multisig this is main key).
  final PublicKey publicKey;

  /// Address where funds should be sent
  final Address destination;
  late Address repackedDestination;

  /// Amount of tokens that should be sent
  final BigInt amount;

  /// Comment for transaction
  final String? comment;

  /// Fee for transaction after calculating it in [_handlePrepare]
  BigInt? fees;

  late UnsignedMessage unsignedMessage;

  void _registerHandlers() {
    on<_Prepare>((event, emit) => _handlePrepare(emit));
    on<_Send>((event, emit) => _handleSend(emit, event.password));
    on<_CompleteSend>(
      (event, emit) => emit(TonWalletSendState.sent(fees!, event.transaction)),
    );
    on<_AllowCloseSend>(
      (event, emit) => emit(const TonWalletSendState.sending(canClose: true)),
    );
  }

  Future<void> _handlePrepare(Emitter<TonWalletSendState> emit) async {
    try {
      repackedDestination = await repackAddress(destination);

      unsignedMessage = await nekotonRepository.prepareTransfer(
        address: address,
        publicKey: publicKey,
        destination: repackedDestination,
        amount: amount,
        body: comment,
        bounce: messageBounce,
        expiration: defaultSendTimeout,
      );

      fees = await nekotonRepository.estimateFees(
        address: address,
        message: unsignedMessage,
      );

      final wallet = await nekotonRepository.walletsStream
          .expand((e) => e)
          .firstWhere((wallets) => wallets.address == address);

      final balance = wallet.contractState.balance;

      final isPossibleToSendMessage = balance > (fees! + amount);

      if (!isPossibleToSendMessage) {
        emit(
          TonWalletSendState.calculatingError(
            LocaleKeys.insufficientFunds.tr(),
            fees,
          ),
        );
        return;
      }

      emit(TonWalletSendState.readyToSend(fees!));
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

      inject<MessengerService>().show(
        Message.successful(
          message: LocaleKeys.transactionSentSuccessfully.tr(),
        ),
      );
      if (!isClosed) {
        add(TonWalletSendEvent.completeSend(transaction));
      }
    } on FfiException catch (e, t) {
      _logger.severe('_handleSend', e, t);
      inject<MessengerService>().show(Message.error(message: e.message));
      emit(TonWalletSendState.readyToSend(fees!));
    } on Exception catch (e, t) {
      _logger.severe('_handleSend', e, t);
      inject<MessengerService>().show(Message.error(message: e.toString()));
      emit(TonWalletSendState.readyToSend(fees!));
    }
  }
}
