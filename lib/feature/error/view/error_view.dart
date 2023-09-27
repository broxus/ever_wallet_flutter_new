import 'package:app/app/router/app_route.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({
    required this.isOnboarding,
    super.key,
  });

  final bool isOnboarding;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ContainerColumn(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Error'),
          CommonButton(
            text: isOnboarding
                ? LocaleKeys.goToOnboarding.tr()
                : LocaleKeys.goToWallet.tr(),
            onPressed: () => context.goNamed(
              isOnboarding ? AppRoute.onboarding.name : AppRoute.wallet.name,
            ),
          ),
        ],
      ),
    );
  }
}
