part of 'select_network_bloc.dart';

@freezed
class SelectNetworkState with _$SelectNetworkState {
  const factory SelectNetworkState({
    required String currentConnectionId,
    required List<ConnectionData> connections,
  }) = _SelectNetworkState;
}
