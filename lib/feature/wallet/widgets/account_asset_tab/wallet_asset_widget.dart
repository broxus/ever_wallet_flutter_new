import 'package:app/generated/generated.dart';
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
    super.key,
  });

  /// Balance of token
  final Money? tokenBalance;

  /// Balance of token in real-world currency
  final Money? fiatBalance;

  final Widget icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CommonListTile(
      leading: icon,
      titleChild: tokenBalance == null
          ? _loader(1)
          : MoneyWidget(
              money: tokenBalance!,
              style: MoneyWidgetStyle.primary,
            ),
      subtitleChild: fiatBalance == null
          // ignore: no-magic-number
          ? _loader(2)
          : MoneyWidget(
              money: fiatBalance!,
              style: MoneyWidgetStyle.secondary,
            ),
      onPressed: onPressed,
      trailing: CommonIconWidget.svg(svg: Assets.images.caretRight.path),
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
