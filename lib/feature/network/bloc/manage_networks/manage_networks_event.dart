part of 'manage_networks_bloc.dart';

@freezed
class ManageNetworksEvent with _$ManageNetworksEvent {
  const factory ManageNetworksEvent.setCurrentConnectionId({
    required String id,
  }) = _setCurrentConnectionId;

  const factory ManageNetworksEvent.setConnections({
    required List<ConnectionData> connections,
  }) = _setConnections;
}
