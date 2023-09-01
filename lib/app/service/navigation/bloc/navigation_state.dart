part of 'navigation_bloc.dart';

@freezed
class NavigationState with _$NavigationState {
  const factory NavigationState({
    NavigationServiceState? state,
    NavigationServiceState? oldState,
  }) = _NavigationState;
}
