import 'dart:async';

import 'package:app/di/di.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@singleton
class NavigationService {
  static const _domain = 'NavigationService';
  static const _locationKey = 'location';
  // ignore: avoid-global-state
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  String _savedLocation = '';

  Future<void> init(String initialLocation) async {
    // Get location from storage
    final location = await inject<EncryptedStorage>().get(
      _locationKey,
      domain: _domain,
      defaultValue: initialLocation,
    );

    // If location is not null, set it as saved location and add it to the
    // stream
    if (location != null) {
      _savedLocation = location;
      _locationSubject.add(location);
    }
  }

  final _locationSubject = BehaviorSubject<String>();

  String get location => _locationSubject.valueOrNull ?? '';

  ValueStream<String> get locationStream => _locationSubject.stream;

  String get savedLocation => _savedLocation;

  Future<void> setLocation({
    required String location,
    required bool save,
  }) async {
    _locationSubject.add(location);

    // If it is supposed to be saved, save it to storage
    if (save) {
      _savedLocation = location;
      await inject<EncryptedStorage>().set(
        _locationKey,
        location,
        domain: _domain,
      );
    }
  }
}
