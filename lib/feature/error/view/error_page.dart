import 'package:app/feature/error/view/error_view.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage(this.error, {super.key});

  final Exception? error;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: DefaultAppBar(),
      body: ErrorView(),
    );
  }
}
