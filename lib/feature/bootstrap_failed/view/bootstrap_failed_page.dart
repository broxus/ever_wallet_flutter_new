import 'package:app/app/service/service.dart';
import 'package:app/feature/bootstrap_failed/bootstrap_failed.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Page that displays allows user to make some single operation, that user
/// can interact with to solve the problem if possible.
///
/// If [step] was solved and the next step failed, then other page should be
/// displayed.
class BootstrapFailedPage extends StatelessWidget {
  const BootstrapFailedPage({
    required this.step,
    super.key,
  });

  /// Step that was handling when process failed
  final BootstrapSteps step;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(),
      body: switch (step) {
        BootstrapSteps.error => const BootstrapFailedRerunView(),
        BootstrapSteps.connection => const BootstrapRetryConnectionView(),

        // should not be there
        _ => const SizedBox.shrink(),
      },
    );
  }
}
