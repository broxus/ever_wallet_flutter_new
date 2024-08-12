import 'package:app/data/models/network_type.dart';
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
    required TokenWalletVersion version,
    // true if custom, false if system
    required bool isCustom,
    int? chainId,
    // address of owner that could be set when loaded in
    // <TonWallet.getTokenRootDetailsFromTokenWallet>, may be optional
    @JsonKey(includeToJson: false, includeFromJson: false)
    Address? ownerAddress,
    @JsonKey(includeToJson: false, includeFromJson: false) String? totalSupply,
    String? logoURI,
  }) = _TokenContractAsset;

  factory TokenContractAsset.fromJson(Map<String, dynamic> json) =>
      _$TokenContractAssetFromJson(json);
}

TokenWalletVersion intToWalletContractConvert(int version) {
  // ignore: no-magic-number
  if (version == 4) {
    return TokenWalletVersion.oldTip3v4;
  }

  return TokenWalletVersion.tip3;
}
