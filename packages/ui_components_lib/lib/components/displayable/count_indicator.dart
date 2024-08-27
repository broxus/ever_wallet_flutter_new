import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/dimens_v2.dart';

// TODO(Odrin): I have no idea which button it is, so I created a new one
class CountIndicator extends StatelessWidget {
  const CountIndicator({required this.count, super.key, this.onPressed});

  final int count;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyleV2.colors;
    final styles = context.themeStyleV2.textStyles;

    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        width: DimensSize.d24,
        height: DimensSize.d24,
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(DimensSizeV2.d6),
              border: Border.all(
                width: DimensSizeV2.d2,
                color: colors.primaryA,
              ),
            ),
            child: Center(
              child: Text(
                count.toString(),
                // TODO(MolochkoAndrew): ceck design
                style: styles.headingXSmall.copyWith(
                  fontWeight: FontWeight.w600,
                  height: 1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
