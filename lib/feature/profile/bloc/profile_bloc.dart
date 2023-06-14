import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'profile_bloc.freezed.dart';

part 'profile_event.dart';

part 'profile_state.dart';

/// Bloc for profile page that stores current key in state and some settings.
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState.initial()) {
    on<_Initialize>(_initialize);
    on<_LogOut>(_initialize);
    on<_ChangeBiometry>(_initialize);
    on<_ExportSeed>(_initialize);
  }

  Future<void> _initialize(event, Emitter<ProfileState> emit) async {}
}
