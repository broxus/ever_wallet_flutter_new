part of 'token_wallet_asset_cubit.dart';

@freezed
class TokenWalletAssetState with _$TokenWalletAssetState {
  const factory TokenWalletAssetState.data({
    Money? fiatBalance,
    Money? tokenBalance,
  }) = _Data;
}
