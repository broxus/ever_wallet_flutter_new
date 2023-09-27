import 'package:app/feature/error/view/error_view.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({
    required this.error,
    required this.isOnboarding,
    super.key,
  });

  final Exception? error;
  final bool isOnboarding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(),
      body: ErrorView(isOnboarding: isOnboarding),
    );
  }
}
