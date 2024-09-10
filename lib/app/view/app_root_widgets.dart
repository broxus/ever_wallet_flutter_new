import 'package:app/app/service/service.dart';
import 'package:flutter/widgets.dart';
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
