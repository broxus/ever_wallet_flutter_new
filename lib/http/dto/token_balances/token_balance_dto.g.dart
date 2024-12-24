// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_balance_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenBalanceDto _$TokenBalanceDtoFromJson(Map<String, dynamic> json) =>
    TokenBalanceDto(
      amount: json['amount'] as String,
      ownerAddress: Address.fromJson(json['ownerAddress'] as String),
      rootAddress: Address.fromJson(json['rootAddress'] as String),
      tokenWalletAddress:
          Address.fromJson(json['tokenWalletAddress'] as String),
      token: json['token'] as String,
    );

Map<String, dynamic> _$TokenBalanceDtoToJson(TokenBalanceDto instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'ownerAddress': instance.ownerAddress.toJson(),
      'rootAddress': instance.rootAddress.toJson(),
      'tokenWalletAddress': instance.tokenWalletAddress.toJson(),
      'token': instance.token,
    };
