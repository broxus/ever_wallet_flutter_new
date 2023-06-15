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
    this.currentKeyService,
  ) : super(const ProfileState.initial()) {
    on<_Initialize>(_initialize);
    on<_LogOut>(_logOut);
    on<_ExportSeed>(_exportSeed);
    on<_UpdateData>(_updateData);
  }

  final NekotonRepository nekotonRepository;
  final CurrentKeyService currentKeyService;

  late StreamSubscription<SeedList> _seedSubscription;
  late StreamSubscription<String?> _currentKeySubscription;

  @override
  Future<void> close() {
    _seedSubscription.cancel();
    _currentKeySubscription.cancel();
    return super.close();
  }

  Future<void> _initialize(
    _Initialize _,
    Emitter<ProfileState> __,
  ) async {
    // skip 1 to avoid duplicate init
    _currentKeySubscription = currentKeyService.currentKeyStream.skip(1).listen(
          (current) => add(
            ProfileEvent.updateData(current, nekotonRepository.seedList),
          ),
        );
    _seedSubscription = nekotonRepository.seedListStream.skip(1).listen(
          (list) => add(
            ProfileEvent.updateData(currentKeyService.currentKey, list),
          ),
        );


    add(
      ProfileEvent.updateData(
        currentKeyService.currentKey,
        nekotonRepository.seedList,
      ),
    );
  }

  Future<void> _updateData(
    _UpdateData event,
    Emitter<ProfileState> emit,
  ) async {
    final (currentKey, list) = (event.currentKey, event.list);

    final seed = await _tryUpdateCurrentKey(currentKey, list);
    if (seed != null) {
      emit(ProfileState.data(currentSeed: seed));
    }
  }

  /// Checks that [currentKey] has seed instance or try update currentKey in
  /// storage.
  /// Returns current seed instance or null if no seed found.
  /// If no seed found, some wrong happened (app should be logged out).
  Future<Seed?> _tryUpdateCurrentKey(
    String? currentKey,
    SeedList list,
  ) async {
    final seed = _getCurrentSeed(currentKey, list);
    if (seed != null &&
        currentKey != null &&
        seed.getKeyByPublicKey(currentKey)?.key.publicKey == currentKey) {
      return seed;
    } else if (seed != null) {
      // returned seed is not same as [currentKey], update it
      await currentKeyService.changeCurrentKey(seed.masterKey.key.publicKey);
      return seed;
    }
    return null;
  }

  /// Get instance of seed by its public key.
  /// Or get any first available seed if [currentKey] is null.
  Seed? _getCurrentSeed(String? currentKey, SeedList list) {
    if (currentKey == null) {
      // if no current key, try to find any available
      final foundKey = list.seeds.firstOrNull?.masterKey.key.publicKey;
      if (foundKey != null) {
        return list.getSeedByAnyPublicKey(foundKey);
      }
      // no any key in list
      return null;
    }

    return list.getSeedByAnyPublicKey(currentKey);
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
    final seed = await _tryUpdateCurrentKey(
      currentKeyService.currentKey,
      nekotonRepository.seedList,
    );
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
