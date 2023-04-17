import 'package:app/data/models/token_contract_asset.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'token_contract_asset_dto.freezed.dart';
part 'token_contract_asset_dto.g.dart';

@freezed
class TokenContractAssetDto with _$TokenContractAssetDto {
  @HiveType(typeId: 1)
  const factory TokenContractAssetDto({
    @HiveField(0) required String name,
    @HiveField(1) int? chainId,
    @HiveField(2) required String symbol,
    @HiveField(3) required int decimals,
    @HiveField(4) required String address,
    @HiveField(5) String? logoURI,
    @HiveField(6) required int version,
  }) = _TokenContractAssetDto;
}

extension TokenContractAssetX on TokenContractAsset {
  TokenContractAssetDto toDto() => TokenContractAssetDto(
        name: name,
        chainId: chainId,
        symbol: symbol,
        decimals: decimals,
        address: address,
        logoURI: logoURI,
        version: version,
      );
}

extension TokenContractAssetDtoX on TokenContractAssetDto {
  TokenContractAsset toModel() => TokenContractAsset(
        name: name,
        chainId: chainId,
        symbol: symbol,
        decimals: decimals,
        address: address,
        logoURI: logoURI,
        version: version,
      );
}
