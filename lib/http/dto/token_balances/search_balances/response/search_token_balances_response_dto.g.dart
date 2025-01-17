// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_token_balances_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchTokenBalancesResponseDto _$SearchTokenBalancesResponseDtoFromJson(
        Map<String, dynamic> json) =>
    SearchTokenBalancesResponseDto(
      balances: (json['balances'] as List<dynamic>)
          .map((e) => TokenBalanceDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchTokenBalancesResponseDtoToJson(
        SearchTokenBalancesResponseDto instance) =>
    <String, dynamic>{
      'balances': instance.balances.map((e) => e.toJson()).toList(),
    };
