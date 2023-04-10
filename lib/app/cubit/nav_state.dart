part of 'nav_cubit.dart';

@immutable
abstract class NavState extends Equatable {
  const NavState(this.location);

  final String location;

  @override
  List<Object> get props => [location];
}

class NavInitial extends NavState {
  NavInitial() : super(AppRoute.onboarding.path);
}

class NavRoute extends NavState {
  const NavRoute(super.location);
}
