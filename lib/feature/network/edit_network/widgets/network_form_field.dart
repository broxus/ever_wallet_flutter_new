import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class NetworkFormField extends StatelessWidget {
  const NetworkFormField({
    required this.label,
    required this.child,
    this.trailing,
    super.key,
  });

  final String label;
  final Widget? trailing;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    final text = Text(
      label,
      style: theme.textStyles.headingXSmall.copyWith(
        color: theme.colors.content3,
      ),
    );

    return SeparatedColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (trailing != null)
          SeparatedRow(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [text, trailing!],
          )
        else
          text,
        child,
      ],
    );
  }
}
