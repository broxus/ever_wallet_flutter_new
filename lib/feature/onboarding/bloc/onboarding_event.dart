part of 'onboarding_bloc.dart';

abstract class OnboardingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnboardingAddAccount extends OnboardingEvent {}

class OnboardingDeleteAccount extends OnboardingEvent {}
