import 'package:flutter/widgets.dart';
import 'package:ui_components_lib/components/common/container/separated_mixin.dart';

class SeparatedColumn extends Column with SeparatedMixin {
  SeparatedColumn({
    required Widget separator,
    required List<Widget> children,
    super.key,
    super.mainAxisAlignment,
    super.mainAxisSize,
    super.crossAxisAlignment,
    super.textDirection,
    super.verticalDirection,
    super.textBaseline,
  }) : super(
          children: SeparatedMixin.buildChildren(separator, children),
        );
}
