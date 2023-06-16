import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// {@template shaped_container_column}
///
/// This is a widget that represents a column with squircle shape background.
///
/// {@endtemplate}
class ShapedContainerColumn extends StatelessWidget {
  /// {@macro shaped_container_column}
  const ShapedContainerColumn({
    required this.children,
    this.color,
    this.squircleRadius = DimensRadius.medium,
    this.margin = const EdgeInsets.symmetric(horizontal: DimensSize.d16),
    this.padding = const EdgeInsets.all(DimensSize.d16),
    super.key,
    this.separatorSize = DimensSize.d8,
    this.separator,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.titleText,
  });

  /// See [Column.children]
  final List<Widget> children;

  /// Color of the background of container, default is
  /// [ColorsPalette.backgroundSecondary].
  final Color? color;

  /// Radius of squircle shape, default is [DimensRadius.medium].
  final double squircleRadius;

  /// Outer padding of container, default is horizontal: DimensSize.d16
  final EdgeInsets margin;

  /// Inner padding of container, around content, default is all: DimensSize.d16
  final EdgeInsets padding;

  /// See <ContainerColumn.separatorSize>
  final double? separatorSize;

  /// See [Column.mainAxisSize]
  final MainAxisSize mainAxisSize;

  /// See [Column.crossAxisAlignment]
  final CrossAxisAlignment crossAxisAlignment;

  /// See [Column.mainAxisAlignment]
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
            separatorSize: DimensSize.d16,
            children: [
              if (titleText != null)
                Text(
                  titleText!,
                  style: StyleRes.h2.copyWith(
                    color: context.themeStyle.colors.textPrimary,
                  ),
                ),
              SeparatedColumn(
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
