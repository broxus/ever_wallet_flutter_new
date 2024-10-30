// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_balance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TokenBalanceModelImpl _$$TokenBalanceModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TokenBalanceModelImpl(
      amount: json['amount'] as String,
      ownerAddress: Address.fromJson(json['ownerAddress'] as String),
      rootAddress: Address.fromJson(json['rootAddress'] as String),
      tokenWalletAddress:
          Address.fromJson(json['tokenWalletAddress'] as String),
      token: json['token'] as String,
    );

Map<String, dynamic> _$$TokenBalanceModelImplToJson(
        _$TokenBalanceModelImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'ownerAddress': instance.ownerAddress.toJson(),
      'rootAddress': instance.rootAddress.toJson(),
      'tokenWalletAddress': instance.tokenWalletAddress.toJson(),
      'token': instance.token,
    };
