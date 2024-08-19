import 'package:app/app/router/app_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({
    required this.isOnboarding,
    super.key,
  });

  final bool isOnboarding;

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.goNamed(
        widget.isOnboarding ? AppRoute.onboarding.name : AppRoute.wallet.name,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.themeStyleV2.colors.background0,
      ),
    );
  }
}
