import 'package:app/app/service/connection/group.dart';
import 'package:app/app/service/connection/network_type.dart';
import 'package:app/utils/common_utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'token_contract_asset.freezed.dart';

part 'token_contract_asset.g.dart';

@freezed
class TokenContractAsset with _$TokenContractAsset {
  const factory TokenContractAsset({
    required String name,
    required String symbol,
    required int decimals,
    // address of rootTokenContract
    required Address address,
    required NetworkType networkType,
    required NetworkGroup networkGroup,
    // true if custom, false if system
    required bool isCustom,
    TokenWalletVersion? version,
    int? chainId,
    // address of owner that could be set when loaded in
    // <TonWallet.getTokenRootDetailsFromTokenWallet>, may be optional
    @JsonKey(includeToJson: false, includeFromJson: false)
    Address? ownerAddress,
    @JsonKey(includeToJson: false, includeFromJson: false) String? totalSupply,
    String? logoURI,
  }) = _TokenContractAsset;

  factory TokenContractAsset.fromJson(Map<String, dynamic> json) =>
      _$TokenContractAssetFromJson(_update(json));
}

Map<String, dynamic> _update(Map<String, dynamic> json) {
  json['networkGroup'] ??= getNetworkGroupByNetworkType(json['networkType']);

  return json;
}

TokenWalletVersion intToWalletContractConvert(int version) {
  // ignore: no-magic-number
  if (version == 4) {
    return TokenWalletVersion.oldTip3v4;
  }

  return TokenWalletVersion.tip3;
}
