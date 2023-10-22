import 'package:app/bootstrap.dart';
import 'package:app/bootstrap/bootstrap.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

typedef AsyncFunc = Future<void> Function();

/// Steps that will be handled during bootstrap process.
/// If app fails during some step, then it will be easy to rerun this process.
/// [storage] - failed at storage step initialization
/// [connection] - failed during creating connection
/// [features] - failed during creating features
/// [completed] - everything is ok, app works normally
enum BootstrapSteps {
  storage,
  connection,
  features,
  completed,
}

/// Service that allows initialize app step by step and re-run some operations
/// if they failed.
@singleton
class BootstrapService {
  final _log = Logger('bootstrap');

  final _bootstrapStepSubject = BehaviorSubject<BootstrapSteps>();

  Stream<BootstrapSteps> get bootstrapStepStream => _bootstrapStepSubject;

  BootstrapSteps get bootstrapStep => _bootstrapStepSubject.value;

  Future<void> init(AppBuildType appBuildType) async {
    try {
      await coreStep(appBuildType);

      _bootstrapStepSubject.add(BootstrapSteps.storage);
      await storageStep();

      _bootstrapStepSubject.add(BootstrapSteps.connection);
      await connectionStep();

      _bootstrapStepSubject.add(BootstrapSteps.features);
      await featureStep();

      _bootstrapStepSubject.add(BootstrapSteps.completed);
    } catch (e, t) {
      _log.severe('init', e, t);
    }
  }

  Future<void> rerunFailedSteps() async {
    var failedStep = bootstrapStep;
    final failedStepIndex = failedStep.index;

    if (failedStep == BootstrapSteps.completed) return;

    final steps = <BootstrapSteps, AsyncFunc>{
      BootstrapSteps.storage: storageStep,
      BootstrapSteps.connection: connectionStep,
      BootstrapSteps.features: featureStep,
    };

    try {
      for (var index = failedStepIndex;
          index < BootstrapSteps.completed.index;
          index++) {
        final currentStep = BootstrapSteps.values[index];
        // we do not update step during initialization to avoid changing page
        // in ui
        failedStep = currentStep;
        await steps[currentStep]!();
      }

      _bootstrapStepSubject.add(BootstrapSteps.completed);
    } catch (e, t) {
      _log.severe('rerunFailedSteps', e, t);
      // update ui
      _bootstrapStepSubject.add(failedStep);

      // allow cubit catch this error
      rethrow;
    }
  }

  /// This step can not be failed during initialization, so we do not let
  /// it to be re-runed (if failed - that's gg).
  Future<void> coreStep(AppBuildType appBuildType) async {
    await configureAppVersion();
    await configureLogger(appBuildType);
  }

  Future<void> storageStep() async {
    await configureEncryptedStorage();
    await configureNavigationService();
    await migrateStorage();
    await configureStorageServices();
    await configureNtpService();
    // SetUp nekoton after storage migrations
    await configureNekoton();
    await configureLocalization();
    await configureBiometry();
  }

  Future<void> connectionStep() async {
    await configureConnectionService();
  }

  Future<void> featureStep() async {
    await configureFeatureServices();
  }
}
