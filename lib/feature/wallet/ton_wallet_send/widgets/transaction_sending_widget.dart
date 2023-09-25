import 'package:app/app/router/router.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Widget that allows display process of sending transaction to blockchain.
/// If [canClose] is true, then 'Okay' button will be visible and user will be
/// able to navigate to wallet root page.
class TransactionSendingWidget extends StatelessWidget {
  const TransactionSendingWidget({
    required this.canClose,
    this.completeCloseCallback,
    super.key,
  });

  final bool canClose;

  /// Callback that could be used to change default behavior for closing
  /// this screen when user achieved last step of sending when transaction is
  /// ready.
  final ValueChanged<BuildContext>? completeCloseCallback;

  @override
  Widget build(BuildContext context) {
    return SeparatedColumn(
      children: [
        Expanded(
          child: Center(
            child: SeparatedColumn(
              separatorSize: DimensSize.d16,
              mainAxisSize: MainAxisSize.min,
              children: [
                const CommonCircularProgressIndicator(
                  size: CircularIndicatorSize.large,
                ),
                Text(
                  LocaleKeys.transactionIsSending.tr(),
                  style: StyleRes.primaryRegular.copyWith(
                    color: context.themeStyle.colors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        if (canClose)
          CommonButton.primary(
            fillWidth: true,
            text: LocaleKeys.okayWord.tr(),
            onPressed: () {
              if (completeCloseCallback != null) {
                completeCloseCallback!(context);
              } else {
                context.goNamed(AppRoute.wallet.name);
              }
            },
          ),
      ],
    );
  }
}
