// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_token_balances_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchTokenBalancesRequestDto _$SearchTokenBalancesRequestDtoFromJson(
        Map<String, dynamic> json) =>
    SearchTokenBalancesRequestDto(
      limit: (json['limit'] as num).toInt(),
      ownerAddress: Address.fromJson(json['ownerAddress'] as String),
      rootAddresses: (json['rootAddresses'] as List<dynamic>?)
          ?.map((e) => Address.fromJson(e as String))
          .toList(),
    );

Map<String, dynamic> _$SearchTokenBalancesRequestDtoToJson(
        SearchTokenBalancesRequestDto instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'ownerAddress': instance.ownerAddress.toJson(),
      'rootAddresses': instance.rootAddresses?.map((e) => e.toJson()).toList(),
    };
