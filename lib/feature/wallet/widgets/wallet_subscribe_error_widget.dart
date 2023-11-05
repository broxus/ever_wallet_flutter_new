import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Widget that displays error that arrived when wallet subscription failed
class WalletSubscribeErrorWidget extends StatelessWidget {
  const WalletSubscribeErrorWidget({
    required this.error,
    this.onRetryPressed,
    this.isLoadingError = false,
    super.key,
  });

  /// Error that should be displayed.
  /// Error automatically converts to user-friendly text via
  /// [convertRetrySubscribeErrorToText].
  final Object error;

  /// Action that will be called when user pressed retry button.
  final ValueChanged<BuildContext>? onRetryPressed;

  /// Wether retry in progress.
  final bool isLoadingError;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    return SeparatedColumn(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          convertRetrySubscribeErrorToText(error),
          style: StyleRes.primaryRegular.copyWith(
            color: colors.textPrimary,
          ),
        ),
        if (onRetryPressed != null)
          CommonButton.primary(
            text: LocaleKeys.tryAgain.tr(),
            isLoading: isLoadingError,
            onPressed: () => onRetryPressed!(context),
          ),
      ],
    );
  }
}
