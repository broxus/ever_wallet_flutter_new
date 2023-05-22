import 'dart:async';
import 'dart:math';

import 'package:flutter_nekoton_bridge/flutter_nekoton_bridge.dart' as fnb;
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

/// {@template nekoton_repository}
/// Nekoton repository package.
///
/// To look through different modules logic, see [TransportRepository],
/// [SeedKeyRepository], [AccountRepository].
///
/// To full initialization of repository, use [setupLogger] -> [setupNekoton] ->
/// [updateTransport].
///
/// {@endtemplate}
@singleton
class NekotonRepository
    with TransportRepositoryImpl, SeedKeyRepositoryImpl, AccountRepositoryImpl {
  /// {@macro nekoton_repository}
  NekotonRepository();

  final _log = Logger('NekotonRepository');

  /// Nekoton's keystore and its getter
  late final fnb.KeyStore _keyStore;

  /// KeyStore must be initialized with [setupNekoton] before usage
  @override
  fnb.KeyStore get keyStore => _keyStore;

  /// Nekoton's accounts storage and its getter
  late final fnb.AccountsStorage _accountsStorage;

  /// AccountsStorage must be initialized with [setupNekoton] before usage
  @override
  fnb.AccountsStorage get accountsStorage => _accountsStorage;

  /// Nekoton's storage aka middleware between nekoton's users and app
  late final fnb.Storage _nekotonStorage;

  // late final fnb.LedgerConnection _ledgerConnection;

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

  /// Setup nekoton storages
  Future<void> setupNekoton({
    required fnb.StorageGet get,
    required fnb.StorageSet set,
    required fnb.StorageSetUnchecked setUnchecked,
    required fnb.StorageRemove remove,
    required fnb.StorageRemoveUnchecked removeUnchecked,
  }) async {
    await fnb.initRustToDartCaller();
    _nekotonStorage = await Storage.create(
      get: get,
      set: set,
      setUnchecked: setUnchecked,
      remove: remove,
      removeUnchecked: removeUnchecked,
    );
    // TODO(alex-a4): uncomment ledger when it will be implemented
    // _ledgerConnection = await LedgerConnection.create(
    //   getPublicKey: (_) => Future.value(''),
    //   connectionSign: ({
    //     required int account,
    //     required List<int> message,
    //     Object? context,
    //   }) =>
    //       Future.value(''),
    // );
    _keyStore = await KeyStore.create(
      storage: _nekotonStorage,
      signers: [
        const KeySigner.encrypted(),
        const KeySigner.derived(),
        // const KeySigner.ledger(),
      ],
    );
    _accountsStorage = await AccountsStorage.create(storage: _nekotonStorage);

    _initHasAnySeeds();
    _initSeedsSubject();
  }

  /// Clear used memory
  Future<void> dispose() async {
    _keyStore.dispose();
    _accountsStorage.dispose();
    _nekotonStorage.dispose();
    await _hasSeeds.close();
  }

  /// List of all keys mapped into seeds
  final _seedsSubject = BehaviorSubject<SeedsList>();

  /// List of all seeds (and keys) of application.
  /// Every time when keys are changed, this stream will emit new value.
  Stream<SeedsList> get seedsStream => _seedsSubject.stream;

  /// Start listening list of keys and map them to [SeedsList]
  void _initSeedsSubject() {
    _keyStore.keysStream
        .listen((keys) => _seedsSubject.add(SeedsList(allKeys: keys)));
  }

  /// Subject that allows subscribe to seeds existing. This is used by
  /// router guard.
  final _hasSeeds = BehaviorSubject<bool>();

  /// Stream for external usages
  BehaviorSubject<bool> get hasSeeds => _hasSeeds;

  /// Init stream of existed seeds by mapping its values.
  /// This must be called after creating [_keyStore].
  void _initHasAnySeeds() {
    _keyStore.keysStream.listen((keys) => _hasSeeds.add(keys.isNotEmpty));
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

  /// -------------------------------------
  /// -------------------------------------
  /// ---- Things below only for tests ----
  /// -------------------------------------
  /// -------------------------------------

  /// Create a new example thing
  ExampleModel getNewModel() => ExampleModel(id: Random().nextInt(1 << 16));

  /// Call something from nekoton
  int getFromNekotonRust() => fnb.simpleAdderSync(1, 2);

  /// Some logs from rust
  void someLogs() => fnb.simpleLog();

  /// Panic from rust
  void somePanic() => fnb.simplePanic();
}
