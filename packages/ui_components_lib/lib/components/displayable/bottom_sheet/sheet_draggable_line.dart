import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Draggable line that displays in top of a sheet to let user know that
/// he can drag sheet.
class SheetDraggableLine extends StatelessWidget {
  const SheetDraggableLine({
    required this.height,
    required this.verticalMargin,
    super.key,
  });

  final double height;
  final double verticalMargin;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    return Center(
      child: Container(
        height: height,
        width: DimensSize.d40,
        margin: EdgeInsets.symmetric(vertical: verticalMargin),
        decoration: ShapeDecoration(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(DimensRadius.max),
            ),
          ),
          color: colors.textSecondary,
        ),
      ),
    );
  }
}
