import 'package:app/app/service/bootstrap/bootstrap_steps.dart';
import 'package:app/app/service/presets_connection/presets_connection_service.dart';
import 'package:app/bootstrap/bootstrap.dart';
import 'package:app/core/app_build_type.dart';
import 'package:app/event_bus/events/bootstrap/bootstrap_event.dart';
import 'package:app/event_bus/primary_bus.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

typedef AsyncFunc = Future<void> Function();

/// Service that allows initialize app step by step and re-run some operations
/// if they failed.
@singleton
class BootstrapService {
  BootstrapService(
    this._presetsConnectionService,
  );

  final PresetsConnectionService _presetsConnectionService;

  final _log = Logger('bootstrap');

  final _bootstrapStepSubject =
      BehaviorSubject<BootstrapSteps>.seeded(BootstrapSteps.empty);

  Stream<BootstrapSteps> get bootstrapStepStream => _bootstrapStepSubject;

  BootstrapSteps get bootstrapStep => _bootstrapStepSubject.value;

  bool get isConfigured => bootstrapStep == BootstrapSteps.completed;

  // TODO(knightforce): refactoring
  Future<void> init(AppBuildType appBuildType) async {
    try {
      await _coreStep(appBuildType);

      _bootstrapStepSubject.add(BootstrapSteps.remoteNetworks);
      await _remoteNetworksStep();

      _bootstrapStepSubject.add(BootstrapSteps.storage);
      await _storageStep();

      _bootstrapStepSubject.add(BootstrapSteps.connection);
      await _connectionStep();

      _bootstrapStepSubject.add(BootstrapSteps.features);
      await _featureStep();

      _bootstrapStepSubject.add(BootstrapSteps.completed);
      primaryBus.fire(BootstrapCompleteEvent());
    } catch (e, t) {
      _log.severe('init', e, t);
      primaryBus.fire(BootstrapErrorEvent());
    }
  }

  Future<void> rerunFailedSteps() async {
    var failedStep = bootstrapStep;
    final failedStepIndex = failedStep.index;

    if (failedStep == BootstrapSteps.completed) return;

    // ignore: avoid-missing-enum-constant-in-map
    final steps = <BootstrapSteps, AsyncFunc>{
      BootstrapSteps.remoteNetworks: _remoteNetworksStep,
      BootstrapSteps.storage: _storageStep,
      BootstrapSteps.connection: _connectionStep,
      BootstrapSteps.features: _featureStep,
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
      _log.severe('rerunFailedSteps:${failedStep.name}', e, t);
      // update ui
      _bootstrapStepSubject.add(failedStep);

      // allow cubit catch this error
      rethrow;
    }
  }

  /// This step can not be failed during initialization, so we do not let
  /// it to be re-runed (if failed - that's gg).
  Future<void> _coreStep(AppBuildType appBuildType) async {
    await configureEncryptedStorage();
  }

  Future<void> _remoteNetworksStep() async {
    await _presetsConnectionService.fetchConnectionsList();
  }

  Future<void> _storageStep() async {
    await configureNavigationService();
    await migrateStorage();
    await configureStorageServices();
    await configureNtpService();
    // SetUp nekoton after storage migrations
    await configureNekoton();
    await configureBiometry();
  }

  Future<void> _connectionStep() async {
    await configureConnectionService();
  }

  Future<void> _featureStep() async {
    await configureFeatureServices();
  }
}
