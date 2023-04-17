import 'package:freezed_annotation/freezed_annotation.dart';

part 'connection_data.freezed.dart';

@freezed
class ConnectionData with _$ConnectionData {
  const factory ConnectionData.gql({
    required String name,
    required int networkId,
    required String group,
    required List<String> endpoints,
    required int timeout,
    required bool local,
  }) = _ConnectionDataGql;

  const factory ConnectionData.jrpc({
    required String name,
    required int networkId,
    required String group,
    required String endpoint,
  }) = _ConnectionDataJrpc;
}
