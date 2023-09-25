import 'package:app/data/models/network_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'connection_data.freezed.dart';
part 'connection_data.g.dart';

@freezed
sealed class ConnectionData with _$ConnectionData {
  const factory ConnectionData.gql({
    required String id,
    required String name,
    required String group,
    required List<String> endpoints,
    required Duration timeout,
    required NetworkType networkType,
    required bool isLocal,
    required String blockExplorerUrl,
    required String manifestUrl,
    required String nativeTokenTicker,
    required bool isPreset,
    required bool canBeEdited,
  }) = _ConnectionDataGql;

  factory ConnectionData.gqlCustom({
    required String name,
    required String group,
    required List<String> endpoints,
    required Duration timeout,
    required NetworkType networkType,
    required bool isLocal,
    required String blockExplorerUrl,
    required String manifestUrl,
    required String nativeTokenTicker,
  }) =>
      ConnectionData.gql(
        id: const Uuid().v4(),
        name: name,
        group: group,
        endpoints: endpoints,
        timeout: timeout,
        networkType: networkType,
        isLocal: isLocal,
        blockExplorerUrl: blockExplorerUrl,
        manifestUrl: manifestUrl,
        nativeTokenTicker: nativeTokenTicker,
        isPreset: false,
        canBeEdited: true,
      );

  factory ConnectionData.gqlPreset({
    required String id,
    required String name,
    required String group,
    required List<String> endpoints,
    required Duration timeout,
    required NetworkType networkType,
    required String blockExplorerUrl,
    required String manifestUrl,
    required bool canBeEdited,
  }) =>
      ConnectionData.gql(
        id: id,
        name: name,
        group: group,
        endpoints: endpoints,
        timeout: timeout,
        networkType: networkType,
        isLocal: false,
        blockExplorerUrl: blockExplorerUrl,
        manifestUrl: manifestUrl,
        nativeTokenTicker: '',
        isPreset: true,
        canBeEdited: canBeEdited,
      );

  const factory ConnectionData.proto({
    required String id,
    required String name,
    required String group,
    required String endpoint,
    required NetworkType networkType,
    required String blockExplorerUrl,
    required String manifestUrl,
    required String nativeTokenTicker,
    required bool isPreset,
    required bool canBeEdited,
  }) = _ConnectionDataProto;

  factory ConnectionData.protoCustom({
    required String name,
    required String group,
    required String endpoint,
    required NetworkType networkType,
    required String blockExplorerUrl,
    required String manifestUrl,
    required String nativeTokenTicker,
  }) =>
      ConnectionData.proto(
        id: const Uuid().v4(),
        name: name,
        group: group,
        endpoint: endpoint,
        networkType: networkType,
        blockExplorerUrl: blockExplorerUrl,
        manifestUrl: manifestUrl,
        nativeTokenTicker: nativeTokenTicker,
        isPreset: false,
        canBeEdited: true,
      );

  factory ConnectionData.protoPreset({
    required String id,
    required String name,
    required String group,
    required String endpoint,
    required NetworkType networkType,
    required String blockExplorerUrl,
    required String manifestUrl,
    required bool canBeEdited,
  }) =>
      ConnectionData.proto(
        id: id,
        name: name,
        group: group,
        endpoint: endpoint,
        networkType: networkType,
        blockExplorerUrl: blockExplorerUrl,
        manifestUrl: manifestUrl,
        nativeTokenTicker: '',
        isPreset: true,
        canBeEdited: canBeEdited,
      );

  const factory ConnectionData.jrpc({
    required String id,
    required String name,
    required String group,
    required String endpoint,
    required NetworkType networkType,
    required String blockExplorerUrl,
    required String manifestUrl,
    required String nativeTokenTicker,
    required bool isPreset,
    required bool canBeEdited,
  }) = _ConnectionDataJrpc;

  factory ConnectionData.jrpcCustom({
    required String name,
    required String group,
    required String endpoint,
    required NetworkType networkType,
    required String blockExplorerUrl,
    required String manifestUrl,
    required String nativeTokenTicker,
  }) =>
      ConnectionData.jrpc(
        id: const Uuid().v4(),
        name: name,
        group: group,
        endpoint: endpoint,
        networkType: networkType,
        blockExplorerUrl: blockExplorerUrl,
        manifestUrl: manifestUrl,
        nativeTokenTicker: nativeTokenTicker,
        isPreset: false,
        canBeEdited: true,
      );

  factory ConnectionData.jrpcPreset({
    required String id,
    required String name,
    required String group,
    required String endpoint,
    required NetworkType networkType,
    required String blockExplorerUrl,
    required String manifestUrl,
    required bool canBeEdited,
  }) =>
      ConnectionData.jrpc(
        id: id,
        name: name,
        group: group,
        endpoint: endpoint,
        networkType: networkType,
        blockExplorerUrl: blockExplorerUrl,
        manifestUrl: manifestUrl,
        nativeTokenTicker: '',
        isPreset: true,
        canBeEdited: canBeEdited,
      );

  factory ConnectionData.fromJson(Map<String, dynamic> json) =>
      _$ConnectionDataFromJson(json);
}
