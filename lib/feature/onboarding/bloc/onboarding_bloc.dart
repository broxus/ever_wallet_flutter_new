import 'dart:async';

import 'package:app/di/di.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(OnboardingInitial()) {
    on<OnboardingAddAccount>(_onAddAccount);
    on<OnboardingDeleteAccount>(_onDeleteAccount);
  }

  // TODO(nesquikm): absolutely shitty naming, just for demo purposes
  FutureOr<void> _onAddAccount(
    OnboardingEvent event,
    Emitter<OnboardingState> emit,
  ) {
    inject<NekotonRepository>().addAccount();
  }

  // TODO(nesquikm): absolutely shitty naming, just for demo purposes
  FutureOr<void> _onDeleteAccount(
    OnboardingDeleteAccount event,
    Emitter<OnboardingState> emit,
  ) {
    inject<NekotonRepository>().deleteAccount();
  }
}
