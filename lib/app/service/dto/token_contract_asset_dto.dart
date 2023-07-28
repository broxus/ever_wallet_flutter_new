// ignore_for_file: no-magic-number

import 'package:app/data/models/network_type.dart';
import 'package:app/data/models/token_contract_asset.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'token_contract_asset_dto.freezed.dart';

part 'token_contract_asset_dto.g.dart';

@freezed
class TokenContractAssetDto with _$TokenContractAssetDto {
  @HiveType(typeId: 1)
  const factory TokenContractAssetDto({
    @HiveField(0) required String name,
    @HiveField(2) required String symbol,
    @HiveField(3) required int decimals,
    @HiveField(4) required String address,
    @HiveField(6) required int version,
    @HiveField(1) int? chainId,
    @HiveField(5) String? logoURI,
  }) = _TokenContractAssetDto;
}

extension TokenContractAssetX on TokenContractAsset {
  TokenContractAssetDto toDto() => TokenContractAssetDto(
        name: name,
        chainId: chainId,
        symbol: symbol,
        decimals: decimals,
        address: address.address,
        logoURI: logoURI,
        version: version.toInt(),
      );
}

extension TokenContractAssetDtoX on TokenContractAssetDto {
  TokenContractAsset toModel(NetworkType type) => TokenContractAsset(
        name: name,
        chainId: chainId,
        symbol: symbol,
        decimals: decimals,
        address: Address(address: address),
        logoURI: logoURI,
        version: intToWalletContractConvert(version),
        networkType: type,
      );
}

extension on TokenWalletVersion {
  int toInt() => switch (this) {
        TokenWalletVersion.oldTip3v4 => 4,
        TokenWalletVersion.tip3 => 5,
      };
}
