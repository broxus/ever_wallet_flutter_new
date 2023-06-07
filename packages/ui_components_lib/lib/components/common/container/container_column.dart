import 'package:flutter/widgets.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class ContainerColumn extends Container {
  ContainerColumn({
    required List<Widget> children,
    super.key,
    super.alignment,
    super.padding = const EdgeInsets.all(DimensSize.d8),
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
            separator: const SizedBox(height: DimensSize.d8),
            children: children,
          ),
        );
}
