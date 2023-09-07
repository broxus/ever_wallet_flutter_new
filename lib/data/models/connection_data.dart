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
    required int networkId,
    required String group,
    required List<String> endpoints,
    required Duration timeout,
    required NetworkType networkType,
    required bool isPreset,
  }) = _ConnectionDataGql;

  factory ConnectionData.gqlCustom({
    required String name,
    required int networkId,
    required String group,
    required List<String> endpoints,
    required Duration timeout,
    required NetworkType networkType,
  }) =>
      ConnectionData.gql(
        id: const Uuid().v4(),
        name: name,
        networkId: networkId,
        group: group,
        endpoints: endpoints,
        timeout: timeout,
        networkType: networkType,
        isPreset: false,
      );

  factory ConnectionData.gqlPreset({
    required String id,
    required String name,
    required int networkId,
    required String group,
    required List<String> endpoints,
    required Duration timeout,
    required NetworkType networkType,
  }) =>
      ConnectionData.gql(
        id: id,
        name: name,
        networkId: networkId,
        group: group,
        endpoints: endpoints,
        timeout: timeout,
        networkType: networkType,
        isPreset: true,
      );

  const factory ConnectionData.proto({
    required String id,
    required String name,
    required int networkId,
    required String group,
    required String endpoint,
    required NetworkType networkType,
    required bool isPreset,
  }) = _ConnectionDataProto;

  factory ConnectionData.protoCustom({
    required String name,
    required int networkId,
    required String group,
    required String endpoint,
    required NetworkType networkType,
  }) =>
      ConnectionData.proto(
        id: const Uuid().v4(),
        name: name,
        networkId: networkId,
        group: group,
        endpoint: endpoint,
        networkType: networkType,
        isPreset: false,
      );

  factory ConnectionData.protoPreset({
    required String id,
    required String name,
    required int networkId,
    required String group,
    required String endpoint,
    required NetworkType networkType,
  }) =>
      ConnectionData.proto(
        id: id,
        name: name,
        networkId: networkId,
        group: group,
        endpoint: endpoint,
        networkType: networkType,
        isPreset: true,
      );

  factory ConnectionData.fromJson(Map<String, dynamic> json) =>
      _$ConnectionDataFromJson(json);
}
