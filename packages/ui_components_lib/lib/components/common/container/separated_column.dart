import 'package:flutter/widgets.dart';
import 'package:ui_components_lib/components/common/container/separated_mixin.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class SeparatedColumn extends Column with SeparatedMixin {
  SeparatedColumn({
    required List<Widget> children,
    Widget? separator,
    double? separatorSize = DimensSizeV2.d8,
    super.key,
    super.mainAxisAlignment,
    super.mainAxisSize,
    super.crossAxisAlignment,
    super.textDirection,
    super.verticalDirection,
    super.textBaseline,
  }) : super(
          children: SeparatedMixin.buildChildren(
            separator ??
                SizedBox(
                  height: separatorSize,
                ),
            children,
          ),
        );
}
