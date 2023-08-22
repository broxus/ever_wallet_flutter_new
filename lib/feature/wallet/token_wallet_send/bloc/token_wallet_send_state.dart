part of 'token_wallet_send_bloc.dart';

@freezed
class TokenWalletSendState with _$TokenWalletSendState {
  const factory TokenWalletSendState.init() = _Init;

  const factory TokenWalletSendState.loading(Currency tokenCurrency) = _Loading;

  /// Error during prepare process
  const factory TokenWalletSendState.calculatingError(
    String error,
    Currency tokenCurrency, [
    BigInt? fee,
  ]) = _CalculatingError;

  /// Blockchain fee loaded, allow user send transaction
  const factory TokenWalletSendState.readyToSend(
    BigInt fee,
    Currency tokenCurrency,
  ) = _Ready;

  /// Transaction is sending.
  /// [canClose] needs to allow user close transaction right after it was sent
  /// to blockchain but not completed.
  const factory TokenWalletSendState.sending({required bool canClose}) =
      _Sending;

  /// Transaction sent successfully
  const factory TokenWalletSendState.sent(
    BigInt fee,
    Currency tokenCurrency,
    Transaction transaction,
  ) = _Sent;
}
