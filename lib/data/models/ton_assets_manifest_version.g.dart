// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ton_assets_manifest_version.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TonAssetsManifestVersionImpl _$$TonAssetsManifestVersionImplFromJson(
        Map<String, dynamic> json) =>
    _$TonAssetsManifestVersionImpl(
      major: (json['major'] as num).toInt(),
      minor: (json['minor'] as num).toInt(),
      patch: (json['patch'] as num).toInt(),
    );

Map<String, dynamic> _$$TonAssetsManifestVersionImplToJson(
        _$TonAssetsManifestVersionImpl instance) =>
    <String, dynamic>{
      'major': instance.major,
      'minor': instance.minor,
      'patch': instance.patch,
    };
