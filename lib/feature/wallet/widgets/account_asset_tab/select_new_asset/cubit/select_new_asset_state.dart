part of 'select_new_asset_cubit.dart';

@freezed
class SelectNewAssetState with _$SelectNewAssetState {
  const factory SelectNewAssetState.data({
    required SelectNewAssetTabs tab,
    KeyAccount? account,
    (List<TokenContractAsset>, List<TokenContractAsset>)? contracts,
  }) = _Data;
}
