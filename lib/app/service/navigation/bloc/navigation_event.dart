part of 'navigation_bloc.dart';

@freezed
class NavigationEvent with _$NavigationEvent {
  const factory NavigationEvent.navigatedTo(NavigationServiceState state) =
      _NavigatedTo;
}
