import 'package:app/feature/profile/view/profile_page_wm.dart';
import 'package:app/feature/profile/view/profile_view.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

class ProfilePageWidget extends ElementaryWidget<ProfilePageWidgetModel> {
  const ProfilePageWidget({
    Key? key,
    WidgetModelFactory wmFactory = defaultProfilePageWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(ProfilePageWidgetModel wm) => ProfileView(
        appVersion: wm.appVersion,
        currentSeed: wm.seed,
        isBiometryAvailable: wm.isBiometryAvailable,
        isBiometryEnabled: wm.isBiometryEnabled,
        onLogout: wm.onLogout,
        onBiomentryChanged: wm.onBiomentryChanged,
      );
}
