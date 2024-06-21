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

Map<String, dynamic> _$$PermissionsImplToJson(_$PermissionsImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('basic', instance.basic);
  writeNotNull('accountInteraction', instance.accountInteraction?.toJson());
  return val;
}
