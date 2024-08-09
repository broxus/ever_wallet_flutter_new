part of 'ton_confirm_transaction_bloc.dart';

@freezed
class TonConfirmTransactionState with _$TonConfirmTransactionState {
  const factory TonConfirmTransactionState.prepare() = _PrepareState;

  const factory TonConfirmTransactionState.loading(
    PublicKey custodian,
  ) = _LoadingState;

  const factory TonConfirmTransactionState.subscribeError(Object error) =
      _SubscribeError;

  /// Error during prepare process
  const factory TonConfirmTransactionState.calculatingError(
    String error,
    PublicKey custodian, [
    BigInt? fee,
  ]) = _CalculatingError;

  /// Blockchain fee loaded, allow user send transaction
  const factory TonConfirmTransactionState.readyToSend(
    BigInt fee,
    PublicKey custodian,
  ) = _Ready;

  /// Transaction is sending.
  /// [canClose] needs to allow user close transaction right after it was sent
  /// to blockchain but not completed.
  const factory TonConfirmTransactionState.sending({required bool canClose}) =
      _Sending;

  /// Transaction sent successfully
  const factory TonConfirmTransactionState.sent(
    BigInt fee,
    Transaction transaction,
    PublicKey custodian,
  ) = _Sent;
}
