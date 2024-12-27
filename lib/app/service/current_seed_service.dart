import 'dart:async';

import 'package:app/app/service/nekoton_related/nekoton_related.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

/// This is a support service for profile section that allows getting and
/// listening for current seed based on seed list and current key.
///
/// This service supports auto-updating of current key if seed is changed.
@singleton
class CurrentSeedService {
  CurrentSeedService(this.nekotonRepository, this.currentKeyService);

  final NekotonRepository nekotonRepository;
  final CurrentKeyService currentKeyService;

  /// Subject of current seed
  final _currentSeedSubject = BehaviorSubject<Seed?>();

  /// Subscriptions
  late StreamSubscription<SeedList> _seedSubscription;
  late StreamSubscription<PublicKey?> _currentKeySubscription;

  /// Stream of current seed.
  /// If stream do not contains any seed, this means that there are no seeds
  /// in app and it is logged out.
  Stream<Seed?> get currentSeedStream => _currentSeedSubject;

  /// If seed is null, this means that there are no seeds in app and it is
  /// logged out.
  Seed? get currentSeed => _currentSeedSubject.valueOrNull;

  /// Initialization of this service must be called only after initializing of
  /// [NekotonRepository] and [CurrentKeyService] which initialized by storage.
  Future<void> init() {
    // skip 1 to avoid duplicate init
    _currentKeySubscription = currentKeyService.currentKeyStream
        .skip(1)
        .listen((current) => _updateData(current, nekotonRepository.seedList));
    _seedSubscription = nekotonRepository.seedListStream
        .skip(1)
        .listen((list) => _updateData(currentKeyService.currentKey, list));

    return _updateData(
      currentKeyService.currentKey,
      nekotonRepository.seedList,
    );
  }

  /// Closes all subscriptions and streams.
  void dispose() {
    _seedSubscription.cancel();
    _currentKeySubscription.cancel();
    _currentSeedSubject.close();
  }

  Future<void> _updateData(
    PublicKey? currentKey,
    SeedList list,
  ) async {
    final seed = await _tryUpdateCurrentKey(currentKey, list);
    if (seed != null) {
      _currentSeedSubject.add(seed);
    }
  }

  /// Checks that [currentKey] has seed instance or try update currentKey in
  /// storage.
  /// Returns current seed instance or null if no seed found.
  /// If no seed found, some wrong happened (app should be logged out).
  Future<Seed?> _tryUpdateCurrentKey(
    PublicKey? currentKey,
    SeedList list,
  ) async {
    final seed = _getCurrentSeed(currentKey, list);
    if (seed != null &&
        currentKey != null &&
        seed.findKeyByPublicKey(currentKey)?.publicKey == currentKey) {
      return seed;
    } else if (seed != null) {
      // returned seed is not same as [currentKey], update it
      currentKeyService.changeCurrentKey(seed.publicKey);

      return seed;
    }

    return null;
  }

  /// Get instance of seed by its public key.
  /// Or get any first available seed if [currentKey] is null.
  Seed? _getCurrentSeed(PublicKey? currentKey, SeedList list) {
    if (currentKey == null) {
      // if no current key, try to find any available
      final foundKey = list.seeds.firstOrNull?.publicKey;
      if (foundKey != null) {
        return list.findSeedByAnyPublicKey(foundKey);
      }

      // no any key in list
      return null;
    }

    return list.findSeedByAnyPublicKey(currentKey);
  }
}
