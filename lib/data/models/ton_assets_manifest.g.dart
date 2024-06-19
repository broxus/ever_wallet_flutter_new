// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ton_assets_manifest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TonAssetsManifestImpl _$$TonAssetsManifestImplFromJson(
        Map<String, dynamic> json) =>
    _$TonAssetsManifestImpl(
      schema: json[r'$schema'] as String,
      name: json['name'] as String,
      version: TonAssetsManifestVersion.fromJson(
          json['version'] as Map<String, dynamic>),
      keywords:
          (json['keywords'] as List<dynamic>).map((e) => e as String).toList(),
      timestamp: json['timestamp'] as String,
      tokens: (json['tokens'] as List<dynamic>)
          .map((e) => TokenContractAsset.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$TonAssetsManifestImplToJson(
        _$TonAssetsManifestImpl instance) =>
    <String, dynamic>{
      r'$schema': instance.schema,
      'name': instance.name,
      'version': instance.version.toJson(),
      'keywords': instance.keywords,
      'timestamp': instance.timestamp,
      'tokens': instance.tokens.map((e) => e.toJson()).toList(),
    };
