// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ton_token_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TonTokenInfoDto _$TonTokenInfoDtoFromJson(Map<String, dynamic> json) =>
    TonTokenInfoDto(
      address: Address.fromJson(json['address'] as String),
      name: json['name'] as String?,
      symbol: json['symbol'] as String?,
      decimals: (json['decimals'] as num?)?.toInt(),
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$TonTokenInfoDtoToJson(TonTokenInfoDto instance) =>
    <String, dynamic>{
      'address': instance.address.toJson(),
      'name': instance.name,
      'symbol': instance.symbol,
      'decimals': instance.decimals,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
    };
