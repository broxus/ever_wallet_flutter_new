import 'dart:async';
import 'dart:convert';

import 'package:app/app/service/navigation/service/service.dart';
import 'package:app/di/di.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@singleton
class NavigationService {
  static const _domain = 'NavigationService';
  static const _stateKey = 'state';

  // ignore: avoid-global-state
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final _stateSubject = BehaviorSubject<NavigationServiceState>.seeded(
    const NavigationServiceState(
      location: '',
      fullPath: '',
    ),
  );

  NavigationServiceState get state => _stateSubject.value;

  ValueStream<NavigationServiceState> get stateStream => _stateSubject.stream;

  // TODO(knightforce): DI
  late final _encryptedStorage = inject<EncryptedStorage>();

  Future<void> init(String initialLocation) async {
    // Get location from storage
    final encoded = await _encryptedStorage.get(
      _stateKey,
      domain: _domain,
    );

    // Get location and full path from storage
    final saved = encoded != null
        ? NavigationServiceState.fromJson(
            jsonDecode(encoded) as Map<String, dynamic>,
          )
        : NavigationServiceState(
            location: initialLocation,
            fullPath: initialLocation,
          );

    _stateSubject.add(saved);
  }

  Future<void> setState({
    required NavigationServiceState state,
    required bool save,
  }) async {
    _stateSubject.add(state);

    // If it is supposed to be saved, save it to storage
    if (save) {
      await _encryptedStorage.set(
        _stateKey,
        jsonEncode(state.toJson()),
        domain: _domain,
      );
    }
  }
}
