part of 'select_network_bloc.dart';

@freezed
class SelectNetworkEvent with _$SelectNetworkEvent {
  const factory SelectNetworkEvent.setCurrentConnectionId({
    required String id,
  }) = _setCurrentConnectionId;

  const factory SelectNetworkEvent.setConnections({
    required List<ConnectionData> connections,
  }) = _setConnections;
}
