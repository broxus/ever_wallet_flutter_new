import 'package:flutter/material.dart';
import 'package:money2/money2.dart';
import 'package:money2_improver/money2_improver.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class AmountWidget extends StatelessWidget {
  const AmountWidget({
    required this.amount,
    this.symbol,
    this.icon,
    this.style,
    this.sign,
    this.mainAxisAlignment,
    super.key,
  });

  AmountWidget.fromMoney({
    required Money amount,
    this.icon,
    this.style,
    this.sign,
    this.mainAxisAlignment,
    super.key,
    String? pattern,
  })  : amount = amount.formatImproved(pattern: pattern),
        symbol = amount.currency.symbol;

  final String amount;
  final String? symbol;
  final Widget? icon;
  final TextStyle? style;
  final String? sign;
  final MainAxisAlignment? mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      children: [
        if (icon != null) icon!,
        if (icon != null) const SizedBox(width: DimensSizeV2.d8),
        Flexible(
          child: Text(
            '${sign ?? ''}$amount',
            style: style ?? theme.textStyles.labelSmall,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            maxLines: 1,
          ),
        ),
        if (symbol != null) const SizedBox(width: DimensSizeV2.d4),
        if (symbol != null)
          Text(symbol!, style: style ?? theme.textStyles.labelSmall),
      ],
    );
  }
}
