part of 'manage_networks_bloc.dart';

@freezed
class ManageNetworksEvent with _$ManageNetworksEvent {
  const factory ManageNetworksEvent.setCurrentConnectionId({
    required String id,
  }) = _setCurrentConnectionId;

  const factory ManageNetworksEvent.setConnections({
    required List<ConnectionData> connections,
  }) = _setConnections;

  const factory ManageNetworksEvent.updateCurrentConnectionId({
    required String id,
  }) = _updateCurrentConnectionId;

  const factory ManageNetworksEvent.addConnection({
    required ConnectionData connection,
  }) = _addConnection;

  const factory ManageNetworksEvent.updateConnection({
    required ConnectionData connection,
  }) = _updateConnection;

  const factory ManageNetworksEvent.removeConnection({
    required String id,
  }) = _removeConnection;

  const factory ManageNetworksEvent.revertConnection({
    required String id,
  }) = _revertConnection;
}
