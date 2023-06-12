import 'dart:async';

import 'package:app/di/di.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@singleton
class NavigationService {
  // ignore: avoid-global-state
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<void> init(String initialLocation) async {
    final location = await inject<EncryptedStorage>().get(
      _locationKey,
      domain: _domain,
      defaultValue: initialLocation,
    );

    if (location != null) {
      _locationSubject.add(location);
    }
  }

  static const _domain = 'NavigationService';
  static const _locationKey = 'location';

  final _locationSubject = BehaviorSubject<String>();

  String get location => _locationSubject.valueOrNull ?? '';

  ValueStream<String> get locationStream => _locationSubject.stream;

  Future<void> setLocation(String location) async {
    _locationSubject.add(location);

    return inject<EncryptedStorage>().set(
      _locationKey,
      location,
      domain: _domain,
    );
  }
}
