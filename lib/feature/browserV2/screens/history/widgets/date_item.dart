import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class DateItem extends StatelessWidget {
  const DateItem({
    required this.dateText,
    super.key,
  });

  final String dateText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: DimensSizeV2.d12,
        left: DimensSize.d16,
        right: DimensSize.d16,
      ),
      child: Text(
        dateText,
        style: context.themeStyleV2.textStyles.headingSmall,
      ),
    );
  }
}
