import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Default widget that displays information about Ton/Token wallet and allows
/// interacting with it.
class WalletAssetWidget extends StatelessWidget {
  const WalletAssetWidget({
    required this.tokenBalance,
    required this.fiatBalance,
    required this.icon,
    required this.onPressed,
    this.onRetryPressed,
    this.error,
    super.key,
  });

  /// Balance of token
  final Money? tokenBalance;

  /// Balance of token in real-world currency
  final Money? fiatBalance;

  final Widget icon;
  final VoidCallback onPressed;

  /// The error that happened during wallet subscription
  final Object? error;

  /// Callback that helps retry subscribe process
  final ValueChanged<BuildContext>? onRetryPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    return CommonListTile(
      leading: icon,
      titleChild: error != null
          ? Text(
              convertRetrySubscribeErrorToText(error!),
              style: StyleRes.primaryRegular.copyWith(
                color: colors.textPrimary,
              ),
            )
          : tokenBalance == null
              ? _loader(1)
              : MoneyWidget(
                  money: tokenBalance!,
                  style: MoneyWidgetStyle.primary,
                ),
      subtitleChild: error != null
          ? null
          : fiatBalance == null
              // ignore: no-magic-number
              ? _loader(2)
              : MoneyWidget(
                  money: fiatBalance!,
                  style: MoneyWidgetStyle.secondary,
                ),
      onPressed: onPressed,
      trailing: error != null
          ? CommonIconButton.svg(
              svg: Assets.images.refresh.path,
              buttonType: EverButtonType.primary,
              onPressed: onRetryPressed == null
                  ? null
                  : () => onRetryPressed!(context),
            )
          : CommonIconWidget.svg(svg: Assets.images.caretRight.path),
    );
  }

  Widget _loader(int part) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return CommonLoader(
          width: constraints.maxWidth / part,
          height: DimensSize.d16,
        );
      },
    );
  }
}
