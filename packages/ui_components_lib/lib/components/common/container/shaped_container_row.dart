import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// {@template shaped_container_row}
///
/// This is a widget that represents a row with squircle shape background.
///
/// {@endtemplate}
class ShapedContainerRow extends StatelessWidget {
  /// {@macro shaped_container_row}
  const ShapedContainerRow({
    required this.children,
    this.color,
    this.squircleRadius = DimensRadiusV2.radius12,
    this.margin = const EdgeInsets.symmetric(horizontal: DimensSizeV2.d16),
    this.padding = const EdgeInsets.all(DimensSizeV2.d16),
    super.key,
    this.separatorSize = DimensSizeV2.d8,
    this.separator,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.titleText,
  });

  /// See [Column.children]
  final List<Widget> children;

  /// Color of the background of container, default is
  /// [ColorsPalette.backgroundSecondary].
  final Color? color;

  /// Radius of squircle shape, default is [DimensRadiusV2.radius12].
  final double squircleRadius;

  /// Outer padding of container, default is horizontal: DimensSizeV2.d16
  final EdgeInsets margin;

  /// Inner padding of container, around content
  /// default is all: DimensSizeV2.d16
  final EdgeInsets padding;

  /// See <ContainerColumn.separatorSize>
  final double? separatorSize;

  /// See [Row.mainAxisSize]
  final MainAxisSize mainAxisSize;

  /// See [Row.crossAxisAlignment]
  final CrossAxisAlignment crossAxisAlignment;

  /// See [Row.mainAxisAlignment]
  final MainAxisAlignment mainAxisAlignment;

  /// See <ContainerColumn.separator>
  final Widget? separator;

  /// Title that displays above list of content
  final String? titleText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Material(
        color: color ?? context.themeStyle.colors.backgroundSecondary,
        shape: SquircleShapeBorder(cornerRadius: squircleRadius),
        // padding here, because ContainerColumn changes alignment in a bad way
        child: Padding(
          padding: padding,
          child: SeparatedColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            separatorSize: DimensSizeV2.d16,
            children: [
              if (titleText != null)
                Text(
                  titleText!,
                  style: StyleRes.h2.copyWith(
                    color: context.themeStyle.colors.textPrimary,
                  ),
                ),
              SeparatedRow(
                separator: separator,
                separatorSize: separatorSize,
                mainAxisSize: mainAxisSize,
                mainAxisAlignment: mainAxisAlignment,
                crossAxisAlignment: crossAxisAlignment,
                children: children,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
