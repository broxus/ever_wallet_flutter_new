// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ton_manifest_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenManifestDto _$TokenManifestDtoFromJson(Map<String, dynamic> json) =>
    TokenManifestDto(
      name: json['name'] as String,
      url: json['url'] as String,
      iconUrl: json['iconUrl'] as String,
    );

Map<String, dynamic> _$TokenManifestDtoToJson(TokenManifestDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
      'iconUrl': instance.iconUrl,
    };
