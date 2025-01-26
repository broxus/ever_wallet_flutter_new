import 'package:flutter/material.dart';
import 'package:money2_fixer/money2_fixer.dart';
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
    this.sign,
    this.signValue,
    this.showSymbol = true,
    super.key,
  });

  final Money money;
  final MoneyWidgetStyle style;

  /// If sign > 0, then + will be displayed before [money], if sign < 0, then
  /// - will be displayed.
  /// If null, nothing will displayed.
  final int? sign;

  /// Additional string, that can be put before money.
  /// Typically, this can be `~` symbol for fee.
  final String? signValue;

  /// If true, then currency symbol will be displayed after money.
  /// True, by default
  final bool showSymbol;

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

    final signStr = sign == null || sign == 0 ? '' : (sign! > 0 ? '+' : '-');

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            '${signValue ?? ''}$signStr${money.formatImproved()}',
            style: moneyStyle,
            softWrap: false,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (showSymbol)
          Padding(
            padding: const EdgeInsets.only(left: DimensStroke.medium),
            child: Text(
              money.currency.symbol,
              style: symbolStyle,
            ),
          ),
      ],
    );
  }
}
