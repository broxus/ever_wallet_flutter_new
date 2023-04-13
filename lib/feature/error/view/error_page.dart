import 'package:app/feature/error/view/error_view.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage(this.error, {super.key});
  final Exception? error;

  @override
  Widget build(BuildContext context) {
    return const ErrorView();
  }
}
