part of 'ton_confirm_transaction_bloc.dart';

@freezed
class TonConfirmTransactionEvent with _$TonConfirmTransactionEvent {
  const factory TonConfirmTransactionEvent.prepare(PublicKey custodian) =
      _Prepare;

  /// Password entered, when ready to send
  const factory TonConfirmTransactionEvent.send(String password) = _Send;

  /// Allow user to close send page
  const factory TonConfirmTransactionEvent.allowCloseSend() = _AllowCloseSend;

  /// Complete sending transaction with result.
  const factory TonConfirmTransactionEvent.completeSend(
    Transaction transaction,
  ) = _CompleteSend;
}
