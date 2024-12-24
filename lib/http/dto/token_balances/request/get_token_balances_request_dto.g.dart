// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_token_balances_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTokenBalancesRequestDto _$GetTokenBalancesRequestDtoFromJson(
        Map<String, dynamic> json) =>
    GetTokenBalancesRequestDto(
      limit: (json['limit'] as num).toInt(),
      offset: (json['offset'] as num).toInt(),
      ownerAddress: Address.fromJson(json['ownerAddress'] as String),
      rootAddresses: (json['rootAddresses'] as List<dynamic>?)
          ?.map((e) => Address.fromJson(e as String))
          .toList(),
      balanceGt: json['balanceGt'] as String?,
    );

Map<String, dynamic> _$GetTokenBalancesRequestDtoToJson(
        GetTokenBalancesRequestDto instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'offset': instance.offset,
      'ownerAddress': instance.ownerAddress.toJson(),
      'rootAddresses': instance.rootAddresses?.map((e) => e.toJson()).toList(),
      'balanceGt': instance.balanceGt,
    };
