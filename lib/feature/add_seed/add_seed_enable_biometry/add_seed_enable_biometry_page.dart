import 'package:app/app/router/app_route.dart';
import 'package:app/feature/biometry/view/biometry_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// This is a helper page that allows enable biometry after adding seed from
/// onboarding page.
///
/// Displaying this page means, that biometry is available on device and NOT
/// ENABLED.
///
/// This is a fake enabling biometry for seed, because it's difficult to provide
/// it here, so password should be stored after creating, here we just enable it
class AddSeedEnableBiometryPage extends StatelessWidget {
  const AddSeedEnableBiometryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BiometryScreen(
      onCompleted: () => _next(context),
      onClose: () => _next(context),
    );
  }

  void _next(BuildContext context) => context.goNamed(AppRoute.wallet.name);
}
