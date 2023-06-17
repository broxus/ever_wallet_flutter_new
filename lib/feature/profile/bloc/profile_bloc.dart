import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/locale_keys.g.dart';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

part 'profile_bloc.freezed.dart';

part 'profile_event.dart';

part 'profile_state.dart';

/// Bloc for profile page that stores current key in state and some settings.
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(
    this.nekotonRepository,
    this.currentSeedService,
  ) : super(const ProfileState.initial()) {
    on<_Initialize>(_initialize);
    on<_LogOut>(_logOut);
    on<_ExportSeed>(_exportSeed);
    on<_UpdateData>(_updateData);
  }

  final NekotonRepository nekotonRepository;
  final CurrentSeedService currentSeedService;
  late StreamSubscription<Seed?> _currentSeedSubscription;

  @override
  Future<void> close() {
    _currentSeedSubscription.cancel();

    return super.close();
  }

  Future<void> _initialize(
    _Initialize _,
    Emitter<ProfileState> __,
  ) async {
    _currentSeedSubscription = currentSeedService.currentSeedStream
        .listen((seed) => add(ProfileEvent.updateData(seed)));
  }

  Future<void> _updateData(
    _UpdateData event,
    Emitter<ProfileState> emit,
  ) async {
    final seed = event.currentSeed;
    if (seed != null) {
      emit(ProfileState.data(currentSeed: seed));
    }
  }

  Future<void> _logOut(
    _LogOut _,
    Emitter<ProfileState> __,
  ) async {
    await inject<StorageManagerService>().clearSensitiveData();
    await nekotonRepository.keyStore.reloadKeystore();
  }

  Future<void> _exportSeed(
    _ExportSeed event,
    Emitter<ProfileState> emit,
  ) async {
    final seed = currentSeedService.currentSeed;
    if (seed != null) {
      try {
        final exported = await seed.exportKey(event.password);
        emit(ProfileState.data(currentSeed: seed, exportedSeed: exported));
      } catch (e) {
        inject<MessengerService>().show(
          Message.error(message: LocaleKeys.passwordIsWrong.tr()),
        );
      }
    }
  }
}
