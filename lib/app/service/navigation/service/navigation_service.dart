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

  var _savedState = const NavigationServiceState(location: '', fullPath: '');

  Future<void> init(String initialLocation) async {
    // Get location from storage
    final encoded = await inject<EncryptedStorage>().get(
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

    // Set it as saved state and add it to the stream
    _savedState = saved;
    _stateSubject.add(saved);
  }

  final _stateSubject = BehaviorSubject<NavigationServiceState>();

  NavigationServiceState get state => _stateSubject.valueOrNull ?? _savedState;

  ValueStream<NavigationServiceState> get stateStream => _stateSubject.stream;

  NavigationServiceState get savedState => _savedState;

  Future<void> setState({
    required NavigationServiceState state,
    required bool save,
  }) async {
    _stateSubject.add(state);

    // If it is supposed to be saved, save it to storage
    if (save) {
      _savedState = state;
      await inject<EncryptedStorage>().set(
        _stateKey,
        jsonEncode(state.toJson()),
        domain: _domain,
      );
    }
  }
}
