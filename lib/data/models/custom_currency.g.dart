// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_currency.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CustomCurrencyImpl _$$CustomCurrencyImplFromJson(Map<String, dynamic> json) =>
    _$CustomCurrencyImpl(
      currency: json['currency'] as String,
      address: Address.fromJson(json['address'] as String),
      price: json['price'] as String,
      networkType: $enumDecode(_$NetworkTypeEnumMap, json['networkType']),
    );

Map<String, dynamic> _$$CustomCurrencyImplToJson(
        _$CustomCurrencyImpl instance) =>
    <String, dynamic>{
      'currency': instance.currency,
      'address': instance.address.toJson(),
      'price': instance.price,
      'networkType': _$NetworkTypeEnumMap[instance.networkType]!,
    };

const _$NetworkTypeEnumMap = {
  NetworkType.ever: 'ever',
  NetworkType.venom: 'venom',
  NetworkType.tycho: 'tycho',
  NetworkType.ton: 'ton',
  NetworkType.custom: 'custom',
};
