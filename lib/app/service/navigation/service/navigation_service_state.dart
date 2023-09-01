import 'package:freezed_annotation/freezed_annotation.dart';

part 'navigation_service_state.freezed.dart';
part 'navigation_service_state.g.dart';

@freezed
class NavigationServiceState with _$NavigationServiceState {
  const factory NavigationServiceState({
    required String location,
    required String fullPath,
  }) = _NavigationServiceState;

  factory NavigationServiceState.fromJson(Map<String, dynamic> json) =>
      _$NavigationServiceStateFromJson(json);
}
