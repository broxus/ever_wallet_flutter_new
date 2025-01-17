// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gas_price_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GasPriceParamsImpl _$$GasPriceParamsImplFromJson(Map<String, dynamic> json) =>
    _$GasPriceParamsImpl(
      tag1: json['tag1'] as String,
      tag2: json['tag2'] as String,
      gasPrice: amountJsonConverter.fromJson(json['gasPrice'] as String),
      gasLimit: amountJsonConverter.fromJson(json['gasLimit'] as String),
      specialGasLimit:
          amountJsonConverter.fromJson(json['specialGasLimit'] as String),
      gasCredit: amountJsonConverter.fromJson(json['gasCredit'] as String),
      blockGasLimit:
          amountJsonConverter.fromJson(json['blockGasLimit'] as String),
      freezeDueLimit:
          amountJsonConverter.fromJson(json['freezeDueLimit'] as String),
      deleteDueLimit:
          amountJsonConverter.fromJson(json['deleteDueLimit'] as String),
      flatGasLimit:
          amountJsonConverter.fromJson(json['flatGasLimit'] as String),
      flatGasPrice:
          amountJsonConverter.fromJson(json['flatGasPrice'] as String),
    );

Map<String, dynamic> _$$GasPriceParamsImplToJson(
        _$GasPriceParamsImpl instance) =>
    <String, dynamic>{
      'tag1': instance.tag1,
      'tag2': instance.tag2,
      'gasPrice': amountJsonConverter.toJson(instance.gasPrice),
      'gasLimit': amountJsonConverter.toJson(instance.gasLimit),
      'specialGasLimit': amountJsonConverter.toJson(instance.specialGasLimit),
      'gasCredit': amountJsonConverter.toJson(instance.gasCredit),
      'blockGasLimit': amountJsonConverter.toJson(instance.blockGasLimit),
      'freezeDueLimit': amountJsonConverter.toJson(instance.freezeDueLimit),
      'deleteDueLimit': amountJsonConverter.toJson(instance.deleteDueLimit),
      'flatGasLimit': amountJsonConverter.toJson(instance.flatGasLimit),
      'flatGasPrice': amountJsonConverter.toJson(instance.flatGasPrice),
    };
