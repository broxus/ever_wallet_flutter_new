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
      networkType: $enumDecode(_$NetworkTypeEnumMap, json['networkType']),
      version: $enumDecode(_$TokenWalletVersionEnumMap, json['version']),
      isCustom: json['isCustom'] as bool,
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
      'networkType': _$NetworkTypeEnumMap[instance.networkType]!,
      'version': _$TokenWalletVersionEnumMap[instance.version]!,
      'isCustom': instance.isCustom,
      'chainId': instance.chainId,
      'logoURI': instance.logoURI,
    };

const _$NetworkTypeEnumMap = {
  NetworkType.ever: 'ever',
  NetworkType.venom: 'venom',
  NetworkType.tycho: 'tycho',
  NetworkType.custom: 'custom',
};

const _$TokenWalletVersionEnumMap = {
  TokenWalletVersion.oldTip3v4: 'OldTip3v4',
  TokenWalletVersion.tip3: 'Tip3',
};
