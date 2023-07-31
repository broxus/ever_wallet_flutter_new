import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

// TODO(Odrin): I have no idea which button it is, so I created a new one
class CountIndicator extends StatelessWidget {
  const CountIndicator({required this.count, super.key, this.onPressed});

  final int count;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;
    final styles = context.themeStyle.styles;

    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        height: DimensSize.d24,
        child: Material(
          child: Container(
            decoration: BoxDecoration(
              border: SquircleBoxBorder(
                squircleRadius: DimensRadius.small,
                borderSide: BorderSide(color: colors.textPrimary, width: 2),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: DimensSize.d8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    count.toString(),
                    style: styles.buttonTextStyle,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
