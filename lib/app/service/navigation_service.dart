import 'dart:async';

import 'package:app/di/di.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:injectable/injectable.dart';

@singleton
class NavigationService {
  Future<void> init(String initialLocation) async {
    _location = (await inject<EncryptedStorage>().get(
      _locationKey,
      domain: _domain,
      defaultValue: initialLocation,
    ))!;
  }

  static const _domain = 'NavigationService';
  static const _locationKey = 'location';

  late String _location;
  String get location => _location;

  Future<void> setLocation(String location) async {
    _location = location;

    return inject<EncryptedStorage>().set(
      _locationKey,
      location,
      domain: _domain,
    );
  }
}
