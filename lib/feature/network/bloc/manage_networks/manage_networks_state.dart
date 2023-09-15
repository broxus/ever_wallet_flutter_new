part of 'manage_networks_bloc.dart';

@freezed
class ManageNetworksState with _$ManageNetworksState {
  const factory ManageNetworksState({
    required String currentConnectionId,
    required List<ConnectionData> connections,
  }) = _ManageNetworksState;
}
