part of 'ton_wallet_asset_cubit.dart';

@freezed
class TonWalletAssetState with _$TonWalletAssetState {
  const factory TonWalletAssetState.data({
    required String tokenName,
    required String iconPath,
    Money? fiatBalance,
    Money? tokenBalance,
  }) = _Data;

  const factory TonWalletAssetState.subscribeError({
    required String tokenName,
    required String iconPath,
    required Object error,
    required bool isLoading,
  }) = _SubscribeError;
}
