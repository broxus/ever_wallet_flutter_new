// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_contract_asset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TokenContractAssetImpl _$$TokenContractAssetImplFromJson(
        Map<String, dynamic> json) =>
    _$TokenContractAssetImpl(
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      decimals: (json['decimals'] as num).toInt(),
      address: Address.fromJson(json['address'] as String),
      networkType: json['networkType'] as String,
      networkGroup: json['networkGroup'] as String,
      isCustom: json['isCustom'] as bool,
      version:
          $enumDecodeNullable(_$TokenWalletVersionEnumMap, json['version']),
      chainId: (json['chainId'] as num?)?.toInt(),
      logoURI: json['logoURI'] as String?,
    );

Map<String, dynamic> _$$TokenContractAssetImplToJson(
        _$TokenContractAssetImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'symbol': instance.symbol,
      'decimals': instance.decimals,
      'address': instance.address.toJson(),
      'networkType': instance.networkType,
      'networkGroup': instance.networkGroup,
      'isCustom': instance.isCustom,
      'version': _$TokenWalletVersionEnumMap[instance.version],
      'chainId': instance.chainId,
      'logoURI': instance.logoURI,
    };

const _$TokenWalletVersionEnumMap = {
  TokenWalletVersion.oldTip3v4: 'OldTip3v4',
  TokenWalletVersion.tip3: 'Tip3',
};
