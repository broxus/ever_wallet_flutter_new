part of 'ton_wallet_asset_cubit.dart';

@freezed
class TonWalletAssetState with _$TonWalletAssetState {
  const factory TonWalletAssetState.data({
    required String iconPath,
    Money? fiatBalance,
    Money? tokenBalance,
  }) = _Data;
}
