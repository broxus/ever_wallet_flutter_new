import 'package:app/app/router/app_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ContainerColumn(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Error'),
          CommonButton(
            text: 'Go to wallet',
            onPressed: () => context.goNamed(AppRoute.wallet.name),
          ),
        ],
      ),
    );
  }
}
