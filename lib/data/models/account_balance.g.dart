// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_balance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AccountBalanceModelImpl _$$AccountBalanceModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AccountBalanceModelImpl(
      rootTokenContract: Address.fromJson(json['rootTokenContract'] as String),
      fiatBalance: moneyFromStringJsonConverter
          .fromJson(json['fiatBalance'] as Map<String, dynamic>),
      tokenBalance: moneyFromStringJsonConverter
          .fromJson(json['tokenBalance'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AccountBalanceModelImplToJson(
        _$AccountBalanceModelImpl instance) =>
    <String, dynamic>{
      'rootTokenContract': instance.rootTokenContract.toJson(),
      'fiatBalance': moneyFromStringJsonConverter.toJson(instance.fiatBalance),
      'tokenBalance':
          moneyFromStringJsonConverter.toJson(instance.tokenBalance),
    };
