import 'package:app/app/service/nekoton_related/connection_service/network_presets.dart';
import 'package:app/data/models/network_type.dart';
import 'package:app/utils/utils.dart';
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
    required double sortingOrder,
  }) = _ConnectionDataGql;

  factory ConnectionData.gqlCustom({
    required String name,
    required List<String> endpoints,
    required bool isLocal,
    required String blockExplorerUrl,
    required String manifestUrl,
    required String nativeTokenTicker,
    Duration? timeout,
    String? id,
    String? group,
    NetworkType networkType = NetworkType.custom,
  }) =>
      ConnectionData.gql(
        id: id ?? const Uuid().v4(),
        name: name,
        group: group ?? const Uuid().v4(),
        endpoints: endpoints,
        timeout: timeout ?? defaultNetworkTimeout,
        networkType: networkType,
        isLocal: isLocal,
        blockExplorerUrl: blockExplorerUrl,
        manifestUrl: manifestUrl,
        nativeTokenTicker: nativeTokenTicker,
        isPreset: false,
        canBeEdited: true,
        sortingOrder: NtpTime.now().millisecondsSinceEpoch.toDouble(),
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
    required double sortingOrder,
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
        sortingOrder: sortingOrder,
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
    required double sortingOrder,
  }) = _ConnectionDataProto;

  factory ConnectionData.protoCustom({
    required String name,
    required String endpoint,
    required String blockExplorerUrl,
    required String manifestUrl,
    required String nativeTokenTicker,
    String? id,
    String? group,
    NetworkType networkType = NetworkType.custom,
  }) =>
      ConnectionData.proto(
        id: id ?? const Uuid().v4(),
        name: name,
        group: group ?? const Uuid().v4(),
        endpoint: endpoint,
        networkType: networkType,
        blockExplorerUrl: blockExplorerUrl,
        manifestUrl: manifestUrl,
        nativeTokenTicker: nativeTokenTicker,
        isPreset: false,
        canBeEdited: true,
        sortingOrder: NtpTime.now().millisecondsSinceEpoch.toDouble(),
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
    required double sortingOrder,
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
        sortingOrder: sortingOrder,
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
    required double sortingOrder,
  }) = _ConnectionDataJrpc;

  factory ConnectionData.jrpcCustom({
    required String name,
    required String endpoint,
    required String blockExplorerUrl,
    required String manifestUrl,
    required String nativeTokenTicker,
    String? id,
    String? group,
    NetworkType networkType = NetworkType.custom,
  }) =>
      ConnectionData.jrpc(
        id: id ?? const Uuid().v4(),
        name: name,
        group: group ?? const Uuid().v4(),
        endpoint: endpoint,
        networkType: networkType,
        blockExplorerUrl: blockExplorerUrl,
        manifestUrl: manifestUrl,
        nativeTokenTicker: nativeTokenTicker,
        isPreset: false,
        canBeEdited: true,
        sortingOrder: NtpTime.now().millisecondsSinceEpoch.toDouble(),
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
    required double sortingOrder,
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
        sortingOrder: sortingOrder,
      );

  factory ConnectionData.fromJson(Map<String, dynamic> json) =>
      _$ConnectionDataFromJson(json);
}
