import 'dart:async';

import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/profile/view/profile_page_model.dart';
import 'package:app/feature/profile/view/profile_page_widget.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

ProfilePageWidgetModel defaultProfilePageWidgetModelFactory(
  BuildContext context,
) =>
    ProfilePageWidgetModel(
      ProfilePageModel(
        createPrimaryErrorHandler(context),
        inject(),
        inject(),
        inject(),
      ),
    );

class ProfilePageWidgetModel
    extends CustomWidgetModel<ProfilePageWidget, ProfilePageModel> {
  ProfilePageWidgetModel(super.model);

  late final _seed = createNotifierFromStream(model.currentSeedStream);
  late final _biometryAvailability =
      createNotifierFromStream(model.biometryAvailabilityStream);
  late final _biometryEnabled =
      createNotifierFromStream(model.biometryEnabledStream);
  late final _appVersionState = createNotifier('');

  ListenableState<Seed?> get seed => _seed;

  ListenableState<bool> get isBiometryAvailable => _biometryAvailability;

  ListenableState<bool> get isBiometryEnabled => _biometryEnabled;

  ListenableState<String> get appVersionState => _appVersionState;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _init();
  }

  Future<void> onLogout() => model.logout();

  // ignore: avoid_positional_boolean_parameters
  Future<void> onBiomentryChanged(bool enabled) async {
    await model.setBiometryEnabled(enabled: enabled);
  }

  Future<void> _init() async {
    _appVersionState.accept(await model.appVersion);
  }
}
