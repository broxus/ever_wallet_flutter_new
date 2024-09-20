// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stever_withdraw_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StEverWithdrawRequestImpl _$$StEverWithdrawRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$StEverWithdrawRequestImpl(
      nonce: json['nonce'] as String,
      data: StEverWithdrawRequestData.fromJson(
          json['data'] as Map<String, dynamic>),
      accountAddress: const NekotonAddressConverter()
          .fromJson(json['accountAddress'] as String),
    );

Map<String, dynamic> _$$StEverWithdrawRequestImplToJson(
        _$StEverWithdrawRequestImpl instance) =>
    <String, dynamic>{
      'nonce': instance.nonce,
      'data': instance.data.toJson(),
      'accountAddress':
          const NekotonAddressConverter().toJson(instance.accountAddress),
    };

_$StEverWithdrawRequestDataImpl _$$StEverWithdrawRequestDataImplFromJson(
        Map<String, dynamic> json) =>
    _$StEverWithdrawRequestDataImpl(
      amount: amountJsonConverter.fromJson(json['amount'] as String),
      timestamp: timestampFromStringJsonConverter
          .fromJson(json['timestamp'] as String),
    );

Map<String, dynamic> _$$StEverWithdrawRequestDataImplToJson(
        _$StEverWithdrawRequestDataImpl instance) =>
    <String, dynamic>{
      'amount': amountJsonConverter.toJson(instance.amount),
      'timestamp': timestampFromStringJsonConverter.toJson(instance.timestamp),
    };
