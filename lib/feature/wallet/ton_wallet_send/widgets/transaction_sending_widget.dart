import 'package:app/app/router/router.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Widget that allows display process of sending transaction to blockchain.
/// If [canClose] is true, then 'Okay' button will be visible and user will be
/// able to navigate to wallet root page.
class TransactionSendingWidget extends StatelessWidget {
  const TransactionSendingWidget({
    required this.canClose,
    this.completeCloseCallback,
    this.isDeploying = false,
    super.key,
  });

  final bool canClose;
  final bool isDeploying;

  /// Callback that could be used to change default behavior for closing
  /// this screen when user achieved last step of sending when transaction is
  /// ready.
  final ValueChanged<BuildContext>? completeCloseCallback;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return SeparatedColumn(
      children: [
        Expanded(
          child: Center(
            child: SeparatedColumn(
              separatorSize: DimensSizeV2.d16,
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    if (isDeploying)
                      Assets.images.deploymentProgress.image()
                    else
                      Assets.images.transactionProgress.image(),
                    Positioned(
                      bottom: 1,
                      left: 1,
                      right: 1,
                      child: Column(
                        children: [
                          Text(
                            isDeploying
                                ? LocaleKeys.deploymentInProgress.tr()
                                : LocaleKeys.transactionIsSending.tr(),
                            style: theme.textStyles.headingLarge,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: DimensSizeV2.d32),
                          const ProgressIndicatorWidget(size: DimensSizeV2.d32),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: DimensSizeV2.d100),
              ],
            ),
          ),
        ),
        if (canClose)
          AccentButton(
            buttonShape: ButtonShape.pill,
            title: LocaleKeys.okayWord.tr(),
            onPressed: () {
              if (completeCloseCallback != null) {
                completeCloseCallback!(context);
              } else {
                context.goNamed(AppRoute.wallet.name);
              }
            },
          ),
        const SizedBox(height: DimensSizeV2.d4),
      ],
    );
  }
}
