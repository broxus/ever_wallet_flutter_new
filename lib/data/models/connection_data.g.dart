// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConnectionDataGqlImpl _$$ConnectionDataGqlImplFromJson(
        Map<String, dynamic> json) =>
    _$ConnectionDataGqlImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      group: json['group'] as String,
      endpoints:
          (json['endpoints'] as List<dynamic>).map((e) => e as String).toList(),
      timeout: Duration(microseconds: (json['timeout'] as num).toInt()),
      networkType: $enumDecode(_$NetworkTypeEnumMap, json['networkType']),
      isLocal: json['isLocal'] as bool,
      blockExplorerUrl: json['blockExplorerUrl'] as String,
      manifestUrl: json['manifestUrl'] as String,
      nativeTokenTicker: json['nativeTokenTicker'] as String,
      isPreset: json['isPreset'] as bool,
      canBeEdited: json['canBeEdited'] as bool,
      sortingOrder: (json['sortingOrder'] as num).toDouble(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ConnectionDataGqlImplToJson(
        _$ConnectionDataGqlImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'group': instance.group,
      'endpoints': instance.endpoints,
      'timeout': instance.timeout.inMicroseconds,
      'networkType': _$NetworkTypeEnumMap[instance.networkType]!,
      'isLocal': instance.isLocal,
      'blockExplorerUrl': instance.blockExplorerUrl,
      'manifestUrl': instance.manifestUrl,
      'nativeTokenTicker': instance.nativeTokenTicker,
      'isPreset': instance.isPreset,
      'canBeEdited': instance.canBeEdited,
      'sortingOrder': instance.sortingOrder,
      'runtimeType': instance.$type,
    };

const _$NetworkTypeEnumMap = {
  NetworkType.ever: 'ever',
  NetworkType.venom: 'venom',
  NetworkType.custom: 'custom',
};

_$ConnectionDataProtoImpl _$$ConnectionDataProtoImplFromJson(
        Map<String, dynamic> json) =>
    _$ConnectionDataProtoImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      group: json['group'] as String,
      endpoint: json['endpoint'] as String,
      networkType: $enumDecode(_$NetworkTypeEnumMap, json['networkType']),
      blockExplorerUrl: json['blockExplorerUrl'] as String,
      manifestUrl: json['manifestUrl'] as String,
      nativeTokenTicker: json['nativeTokenTicker'] as String,
      isPreset: json['isPreset'] as bool,
      canBeEdited: json['canBeEdited'] as bool,
      sortingOrder: (json['sortingOrder'] as num).toDouble(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ConnectionDataProtoImplToJson(
        _$ConnectionDataProtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'group': instance.group,
      'endpoint': instance.endpoint,
      'networkType': _$NetworkTypeEnumMap[instance.networkType]!,
      'blockExplorerUrl': instance.blockExplorerUrl,
      'manifestUrl': instance.manifestUrl,
      'nativeTokenTicker': instance.nativeTokenTicker,
      'isPreset': instance.isPreset,
      'canBeEdited': instance.canBeEdited,
      'sortingOrder': instance.sortingOrder,
      'runtimeType': instance.$type,
    };

_$ConnectionDataJrpcImpl _$$ConnectionDataJrpcImplFromJson(
        Map<String, dynamic> json) =>
    _$ConnectionDataJrpcImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      group: json['group'] as String,
      endpoint: json['endpoint'] as String,
      networkType: $enumDecode(_$NetworkTypeEnumMap, json['networkType']),
      blockExplorerUrl: json['blockExplorerUrl'] as String,
      manifestUrl: json['manifestUrl'] as String,
      nativeTokenTicker: json['nativeTokenTicker'] as String,
      isPreset: json['isPreset'] as bool,
      canBeEdited: json['canBeEdited'] as bool,
      sortingOrder: (json['sortingOrder'] as num).toDouble(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ConnectionDataJrpcImplToJson(
        _$ConnectionDataJrpcImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'group': instance.group,
      'endpoint': instance.endpoint,
      'networkType': _$NetworkTypeEnumMap[instance.networkType]!,
      'blockExplorerUrl': instance.blockExplorerUrl,
      'manifestUrl': instance.manifestUrl,
      'nativeTokenTicker': instance.nativeTokenTicker,
      'isPreset': instance.isPreset,
      'canBeEdited': instance.canBeEdited,
      'sortingOrder': instance.sortingOrder,
      'runtimeType': instance.$type,
    };
