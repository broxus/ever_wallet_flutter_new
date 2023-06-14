import 'package:flutter/widgets.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class ContainerColumn extends Container {
  ContainerColumn({
    required List<Widget> children,
    super.key,
    super.alignment,
    super.padding = const EdgeInsets.all(DimensSize.d8),
    double? separatorSize = DimensSize.d8,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
    Widget? separator,
    super.color,
    super.decoration,
    super.foregroundDecoration,
    super.width,
    super.height,
    super.constraints,
    super.margin,
    super.transform,
    super.transformAlignment,
    super.clipBehavior = Clip.none,
  }) : super(
          child: SeparatedColumn(
            separatorSize: separatorSize,
            mainAxisSize: mainAxisSize,
            crossAxisAlignment: crossAxisAlignment,
            separator: separator,
            children: children,
          ),
        );
}
