import 'package:flutter/widgets.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class ContainerRow extends Container {
  ContainerRow({
    required List<Widget> children,
    super.key,
    super.alignment,
    super.padding = const EdgeInsets.all(Dimens.xSmall),
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
          child: SeparatedRow(
            separator: const SizedBox(height: Dimens.xSmall),
            children: children,
          ),
        );
}
