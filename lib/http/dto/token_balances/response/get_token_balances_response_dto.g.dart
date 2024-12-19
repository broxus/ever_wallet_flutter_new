// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_token_balances_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTokenBalancesResponseDto _$GetTokenBalancesResponseDtoFromJson(
        Map<String, dynamic> json) =>
    GetTokenBalancesResponseDto(
      balances: (json['balances'] as List<dynamic>)
          .map((e) => TokenBalanceDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetTokenBalancesResponseDtoToJson(
        GetTokenBalancesResponseDto instance) =>
    <String, dynamic>{
      'balances': instance.balances.map((e) => e.toJson()).toList(),
    };
