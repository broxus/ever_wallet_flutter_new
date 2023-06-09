part of 'navigation_bloc.dart';

@freezed
class NavigationState with _$NavigationState {
  const factory NavigationState({
    String? location,
    String? oldLocation,
  }) = _NavigationState;
}
