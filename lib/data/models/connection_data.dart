import 'package:app/data/models/network_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'connection_data.freezed.dart';

@freezed
class ConnectionData with _$ConnectionData {
  const factory ConnectionData.gql({
    required String name,
    required int networkId,
    required String group,
    required List<String> endpoints,
    required Duration timeout,
    required bool local,
    required NetworkType networkType,
  }) = _ConnectionDataGql;

  const factory ConnectionData.jrpc({
    required String name,
    required int networkId,
    required String group,
    required String endpoint,
    required NetworkType networkType,
  }) = _ConnectionDataJrpc;
}
