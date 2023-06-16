import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

/// Service that helps watching app lifecycle state.
@singleton
class AppLifecycleService {
  final _appLifecycleStateSubject = BehaviorSubject<AppLifecycleState>();

  /// Stream of app lifecycle state
  Stream<AppLifecycleState> get appLifecycleStateStream =>
      _appLifecycleStateSubject;

  /// Current app lifecycle state
  AppLifecycleState get appLifecycleState => _appLifecycleStateSubject.value;

  /// Set new app lifecycle state
  void updateState(AppLifecycleState state) =>
      _appLifecycleStateSubject.add(state);
}
