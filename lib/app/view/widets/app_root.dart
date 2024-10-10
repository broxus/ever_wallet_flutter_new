import 'package:app/app/service/crash_detector/widget/crash_detector_service_widget.dart';
import 'package:app/app/service/localization/widget/localization_service_widget.dart';
import 'package:app/app/service/messenger/widget/messenger_service_widget.dart';
import 'package:app/app/service/navigation/widget/navigation_service_widget.dart';
import 'package:flutter/material.dart';
import 'package:in_app_notification/in_app_notification.dart';

/// Widget that should be placed at the root of the app
/// This is a good place to put services that should be available
/// throughout the app
class AppRootWidgets extends StatelessWidget {
  const AppRootWidgets({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InAppNotification(
      child: CrashDetectorServiceWidget(
        child: LocalizationServiceWidget(
          child: MessengerServiceWidget(
            child: NavigationServiceWidget(child: child),
          ),
        ),
      ),
    );
  }
}
