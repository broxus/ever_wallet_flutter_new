import 'dart:async';

import 'package:app/di/di.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileDeleteAccount>(_onDeleteAccount);
  }

  // TODO(nesquikm): absolutely shitty naming, just for demo purposes
  FutureOr<void> _onDeleteAccount(
    ProfileDeleteAccount event,
    Emitter<ProfileState> emit,
  ) {
    inject<NekotonRepository>().deleteAccount();
  }
}
