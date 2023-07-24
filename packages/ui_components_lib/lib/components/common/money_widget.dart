import 'package:flutter/material.dart';
import 'package:money2_improver/money2_improver.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

export 'package:money2/money2.dart';

/// Style for [MoneyWidget] which indicates will style will be used.
///
/// [big] - balance style for money and secondaryBold for symbol, color:
///   textPrimary
/// [primary] - button style for both, color: textPrimary
/// [secondary] - addRegular style for both, color: textSecondary
enum MoneyWidgetStyle { big, primary, secondary }

/// Widget that allows displaying money in different formats.
class MoneyWidget extends StatelessWidget {
  const MoneyWidget({
    required this.money,
    required this.style,
    super.key,
  });

  final Money money;
  final MoneyWidgetStyle style;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;
    final moneyStyle = switch (style) {
      MoneyWidgetStyle.big =>
        StyleRes.balance.copyWith(color: colors.textPrimary),
      MoneyWidgetStyle.primary =>
        StyleRes.button.copyWith(color: colors.textPrimary),
      MoneyWidgetStyle.secondary =>
        StyleRes.addRegular.copyWith(color: colors.textSecondary),
    };
    final symbolStyle = switch (style) {
      MoneyWidgetStyle.big =>
        StyleRes.secondaryBold.copyWith(color: colors.textPrimary),
      MoneyWidgetStyle.primary =>
        StyleRes.button.copyWith(color: colors.textPrimary),
      MoneyWidgetStyle.secondary =>
        StyleRes.addRegular.copyWith(color: colors.textSecondary),
    };

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(money.formatImproved(), style: moneyStyle),
        const SizedBox(width: DimensStroke.medium),
        Text(money.currency.symbol, style: symbolStyle),
      ],
    );
  }
}
