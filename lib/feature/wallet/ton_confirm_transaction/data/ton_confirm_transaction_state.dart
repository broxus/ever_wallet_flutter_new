import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'ton_confirm_transaction_state.freezed.dart';

@freezed
class TonConfirmTransactionState with _$TonConfirmTransactionState {
  const factory TonConfirmTransactionState.prepare() = PrepareState;

  const factory TonConfirmTransactionState.loading(
    PublicKey custodian,
  ) = LoadingState;

  const factory TonConfirmTransactionState.subscribeError(Object error) =
      SubscribeError;

  /// Error during prepare process
  const factory TonConfirmTransactionState.calculatingError(
    String error,
    PublicKey custodian, [
    BigInt? fee,
  ]) = CalculatingError;

  /// Blockchain fee loaded, allow user send transaction
  const factory TonConfirmTransactionState.readyToSend(
    BigInt fee,
    PublicKey custodian,
  ) = Ready;

  /// Transaction is sending.
  /// [canClose] needs to allow user close transaction right after it was sent
  /// to blockchain but not completed.
  const factory TonConfirmTransactionState.sending({required bool canClose}) =
      Sending;

  /// Transaction sent successfully
  const factory TonConfirmTransactionState.sent(
    BigInt fee,
    Transaction transaction,
    PublicKey custodian,
  ) = Sent;
}
