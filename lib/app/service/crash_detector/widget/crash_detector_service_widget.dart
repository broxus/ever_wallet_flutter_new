import 'package:app/app/service/navigation/service/service.dart';
import 'package:app/bootstrap/bootstrap.dart';
import 'package:app/feature/contact_support/contact_support.dart';
import 'package:flutter/widgets.dart';

// Delay after app start to show contact support sheet
const _showContactSupportSheetDelay = Duration(seconds: 5);

class CrashDetectorServiceWidget extends StatefulWidget {
  const CrashDetectorServiceWidget({required this.child, super.key});

  final Widget child;

  @override
  State<CrashDetectorServiceWidget> createState() =>
      _CrashDetectorServiceWidgetState();
}

class _CrashDetectorServiceWidgetState
    extends State<CrashDetectorServiceWidget> {
  bool crashDetected = false;

  @override
  void initState() {
    super.initState();

    detectCrash();
  }

  Future<void> detectCrash() async {
    super.initState();

    Future.delayed(_showContactSupportSheetDelay, () async {
      crashDetected = await appGetCrashDetected();

      if (crashDetected) {
        setState(() {
          crashDetected = false;
        });

        // We can't use current context here because it's not contains Navigator
        final ctx = NavigationService.navigatorKey.currentState?.context;
        if (ctx == null) {
          return;
        }

        // ignore: use_build_context_synchronously
        await showContactSupportSheet(
          context: ctx,
          mode: ContactSupportMode.initiatedByCrash,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
