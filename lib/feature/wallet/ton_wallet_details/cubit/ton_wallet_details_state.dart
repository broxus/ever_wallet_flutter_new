part of 'ton_wallet_details_cubit.dart';

@freezed
class TonWalletDetailsState with _$TonWalletDetailsState {
  const factory TonWalletDetailsState.initial() = _Initial;

  const factory TonWalletDetailsState.empty() = _Empty;

  const factory TonWalletDetailsState.data({
    required String walletName,
    required KeyAccount account,
    required Money tokenBalance,
    required Money fiatBalance,
  }) = _Data;
}
