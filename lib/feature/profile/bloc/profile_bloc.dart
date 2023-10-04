import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

part 'profile_bloc.freezed.dart';

part 'profile_event.dart';

part 'profile_state.dart';

/// Bloc for profile page that stores current key in state and some settings.
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required this.nekotonRepository,
    required this.currentSeedService,
    required this.biometryService,
    required this.versionService,
  }) : super(const ProfileState.initial()) {
    on<_Initialize>(_initialize);
    on<_LogOut>(_logOut);
    on<_UpdateData>(_updateData);
  }

  final NekotonRepository nekotonRepository;
  final CurrentSeedService currentSeedService;
  final BiometryService biometryService;
  final AppVersionService versionService;

  late StreamSubscription<Seed?> _currentSeedSubscription;
  late StreamSubscription<bool> _biometryAvailableSubscription;

  @override
  Future<void> close() {
    _currentSeedSubscription.cancel();
    _biometryAvailableSubscription.cancel();

    return super.close();
  }

  Future<void> _initialize(
    _Initialize _,
    Emitter<ProfileState> __,
  ) async {
    // skip 1 to avoid duplicate init
    _currentSeedSubscription =
        currentSeedService.currentSeedStream.skip(1).listen(
              (seed) => add(
                ProfileEvent.updateData(
                  currentSeed: seed,
                  isBiometryAvailable: biometryService.available,
                ),
              ),
            );
    _biometryAvailableSubscription =
        biometryService.availabilityStream.skip(1).listen(
              (isAvailable) => add(
                ProfileEvent.updateData(
                  currentSeed: currentSeedService.currentSeed,
                  isBiometryAvailable: isAvailable,
                ),
              ),
            );

    add(
      ProfileEvent.updateData(
        currentSeed: currentSeedService.currentSeed,
        isBiometryAvailable: biometryService.available,
      ),
    );
  }

  Future<void> _updateData(
    _UpdateData event,
    Emitter<ProfileState> emit,
  ) async {
    final seed = event.currentSeed;
    if (seed != null) {
      emit(
        ProfileState.data(
          currentSeed: seed,
          isBiometryAvailable: event.isBiometryAvailable,
          appVersion:
              '${versionService.appVersion}.${versionService.buildNumber}',
        ),
      );
    }
  }

  Future<void> _logOut(
    _LogOut _,
    Emitter<ProfileState> __,
  ) async {
    await inject<StorageManagerService>().clearSensitiveData();
    await nekotonRepository.keyStore.reloadKeystore();
  }
}
