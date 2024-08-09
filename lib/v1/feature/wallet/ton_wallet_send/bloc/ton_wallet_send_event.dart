part of 'ton_wallet_send_bloc.dart';

@freezed
class TonWalletSendEvent with _$TonWalletSendEvent {
  /// Initial event to prepare data
  const factory TonWalletSendEvent.prepare() = _Prepare;

  /// Password entered, when ready to send
  const factory TonWalletSendEvent.send(String password) = _Send;

  /// Allow user to close send page
  const factory TonWalletSendEvent.allowCloseSend() = _AllowCloseSend;

  /// Complete sending transaction with result.
  const factory TonWalletSendEvent.completeSend(Transaction transaction) =
      _CompleteSend;
}
