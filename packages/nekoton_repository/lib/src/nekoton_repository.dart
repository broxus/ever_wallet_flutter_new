import 'dart:math';

import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:flutter_nekoton_bridge/flutter_nekoton_bridge.dart' as fnb;
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

/// {@template nekoton_repository}
/// Nekoton repository package
/// {@endtemplate}
@singleton
class NekotonRepository {
  /// {@macro nekoton_repository}
  NekotonRepository();

  final _log = Logger('NekotonRepository');

  late final AbstractStorage _storage;

  /// Setup nekoton bridge logger
  Future<void> setupLogger({
    required Level level,
    required bool mobileLogger,
  }) async {
    final logLevel = _logMap[level];
    if (logLevel != null) {
      await fnb.setupLogger(
        level: logLevel,
        mobileLogger: mobileLogger,
        logHandler: _logHandler,
      );
    }
  }

  /// Setup storage
  Future<void> setupStorage({
    required AbstractStorage storage,
  }) async {
    _storage = storage;
    await _readAccount();
  }

  void _logHandler(fnb.LogEntry logEntry) {
    final logLevel = _toLogLevel(logEntry.level);

    _log.log(logLevel, '${logEntry.tag}: ${logEntry.msg}');
  }

  /// The main log level map
  static final Map<Level, fnb.LogLevel?> _logMap = {
    Level.ALL: fnb.LogLevel.Trace,
    Level.FINEST: fnb.LogLevel.Trace,
    Level.FINER: fnb.LogLevel.Trace,
    Level.FINE: fnb.LogLevel.Debug,
    Level.CONFIG: fnb.LogLevel.Debug,
    Level.INFO: fnb.LogLevel.Info,
    Level.WARNING: fnb.LogLevel.Warn,
    Level.SEVERE: fnb.LogLevel.Error,
    Level.SHOUT: fnb.LogLevel.Error,
    Level.OFF: null,
  };

  Level _toLogLevel(fnb.LogLevel level) {
    return _logMap.keys.firstWhere((key) => _logMap[key] == level);
  }

  /// Things below only for tests

  final _hasAccount = BehaviorSubject<bool>();

  Future<void> _readAccount() async {
    final hasAccount = await _storage.get('account');
    _hasAccount.add(hasAccount != null);
  }

  /// Add account to storage
  Future<void> addAccount() async {
    await _storage.set('account', 'true');
    _hasAccount.add(true);
  }

  /// Delete account from storage
  Future<void> deleteAccount() async {
    await _storage.delete('account');
    _hasAccount.add(false);
  }

  /// Stream of account
  BehaviorSubject<bool> get accountsStream => _hasAccount;

  /// Create a new example thing
  ExampleModel getNewModel() => ExampleModel(id: Random().nextInt(1 << 16));

  /// Call something from nekoton
  int getFromNekotonRust() => fnb.simpleAdderSync(1, 2);

  /// Some logs from rust
  void someLogs() => fnb.simpleLog();

  /// Panic from rust
  void somePanic() => fnb.simplePanic();
}
