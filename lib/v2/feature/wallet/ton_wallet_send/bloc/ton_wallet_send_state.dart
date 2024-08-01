part of 'ton_wallet_send_bloc.dart';

@freezed
class TonWalletSendState with _$TonWalletSendState {
  const factory TonWalletSendState.loading() = _Loading;

  /// Error during prepare process
  const factory TonWalletSendState.calculatingError(
    String error, [
    BigInt? fee,
  ]) = _CalculatingError;

  const factory TonWalletSendState.subscribeError(Object error) =
      _SubscribeError;

  /// Blockchain fee loaded, allow user send transaction
  const factory TonWalletSendState.readyToSend(BigInt fee) = _Ready;

  /// Transaction is sending.
  /// [canClose] needs to allow user close transaction right after it was sent
  /// to blockchain but not completed.
  const factory TonWalletSendState.sending({required bool canClose}) = _Sending;

  /// Transaction sent successfully
  const factory TonWalletSendState.sent(BigInt fee, Transaction transaction) =
      _Sent;
}
