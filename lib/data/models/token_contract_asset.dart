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
    required Address address,
    required NetworkType networkType,
    required int version,
    int? chainId,
    String? logoURI,
  }) = _TokenContractAsset;

  factory TokenContractAsset.fromJson(Map<String, dynamic> json) =>
      _$TokenContractAssetFromJson(json);
}
