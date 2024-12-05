// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permissions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PermissionsImpl _$$PermissionsImplFromJson(Map<String, dynamic> json) =>
    _$PermissionsImpl(
      basic: json['basic'] as bool?,
      accountInteraction: json['accountInteraction'] == null
          ? null
          : AccountInteraction.fromJson(
              json['accountInteraction'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PermissionsImplToJson(_$PermissionsImpl instance) =>
    <String, dynamic>{
      if (instance.basic case final value?) 'basic': value,
      if (instance.accountInteraction?.toJson() case final value?)
        'accountInteraction': value,
    };
