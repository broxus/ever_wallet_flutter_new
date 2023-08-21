part of 'token_wallet_send_bloc.dart';

@freezed
class TokenWalletSendEvent with _$TokenWalletSendEvent {
  /// Initial event to prepare data
  const factory TokenWalletSendEvent.prepare() = _Prepare;

  /// Password entered, when ready to send
  const factory TokenWalletSendEvent.send(String password) = _Send;

  /// Allow user to close send page
  const factory TokenWalletSendEvent.allowCloseSend() = _AllowCloseSend;

  /// Complete sending transaction with result.
  const factory TokenWalletSendEvent.completeSend(Transaction transaction) =
      _CompleteSend;
}
