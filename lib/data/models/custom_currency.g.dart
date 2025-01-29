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
      networkType: json['networkType'] as String,
      networkGroup: json['networkGroup'] as String,
    );

Map<String, dynamic> _$$CustomCurrencyImplToJson(
        _$CustomCurrencyImpl instance) =>
    <String, dynamic>{
      'currency': instance.currency,
      'address': instance.address.toJson(),
      'price': instance.price,
      'networkType': instance.networkType,
      'networkGroup': instance.networkGroup,
    };
