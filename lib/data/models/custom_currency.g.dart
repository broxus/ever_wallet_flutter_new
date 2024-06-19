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
      priceChange: json['priceChange'] as String,
      tvl: json['tvl'] as String,
      tvlChange: json['tvlChange'] as String,
      volume24h: json['volume24h'] as String,
      volumeChange24h: json['volumeChange24h'] as String,
      volume7d: json['volume7d'] as String,
      fee24h: json['fee24h'] as String,
      transactionsCount24h: (json['transactionsCount24h'] as num).toInt(),
      networkType: $enumDecode(_$NetworkTypeEnumMap, json['networkType']),
    );

Map<String, dynamic> _$$CustomCurrencyImplToJson(
        _$CustomCurrencyImpl instance) =>
    <String, dynamic>{
      'currency': instance.currency,
      'address': instance.address.toJson(),
      'price': instance.price,
      'priceChange': instance.priceChange,
      'tvl': instance.tvl,
      'tvlChange': instance.tvlChange,
      'volume24h': instance.volume24h,
      'volumeChange24h': instance.volumeChange24h,
      'volume7d': instance.volume7d,
      'fee24h': instance.fee24h,
      'transactionsCount24h': instance.transactionsCount24h,
      'networkType': _$NetworkTypeEnumMap[instance.networkType]!,
    };

const _$NetworkTypeEnumMap = {
  NetworkType.ever: 'ever',
  NetworkType.venom: 'venom',
  NetworkType.custom: 'custom',
};
