part of 'onboarding_bloc.dart';

@immutable
abstract class OnboardingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnboardingAddAccount extends OnboardingEvent {}

class OnboardingDeleteAccount extends OnboardingEvent {}
