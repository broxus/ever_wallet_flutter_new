import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

enum SegmentControlState { normal, selected, disabled }

class SegmentControlStyle {
  SegmentControlStyle.normal(
    ColorsPaletteV2 colors,
    TextStylesV2 textStyles,
    SegmentControlSize size,
  )   : backgroundColor = colors.background1,
        iconColor = colors.content1,
        titleTextStyle = (size == SegmentControlSize.large
                ? textStyles.labelMedium
                : textStyles.labelSmall)
            .copyWith(color: colors.content2),
        valueTextStyle = (size == SegmentControlSize.large
                ? textStyles.paragraphMedium
                : textStyles.paragraphSmall)
            .copyWith(color: colors.content2);

  SegmentControlStyle.selected(
    ColorsPaletteV2 colors,
    TextStylesV2 textStyles,
    SegmentControlSize size,
  )   : backgroundColor = colors.background2,
        iconColor = colors.content0,
        titleTextStyle = size == SegmentControlSize.large
            ? textStyles.labelMedium
            : textStyles.labelSmall,
        valueTextStyle = size == SegmentControlSize.large
            ? textStyles.paragraphMedium
            : textStyles.paragraphSmall;

  SegmentControlStyle.disabled(
    ColorsPaletteV2 colors,
    TextStylesV2 textStyles,
    SegmentControlSize size,
  )   : backgroundColor = ColorsResV2.transparent,
        iconColor = colors.content1.withAlpha(OpacV2.opac50.toByteInt()),
        titleTextStyle = (size == SegmentControlSize.large
                ? textStyles.labelMedium
                : textStyles.labelSmall)
            .copyWith(
          color: colors.content2.withAlpha(
            OpacV2.opac50.toByteInt(),
          ),
        ),
        valueTextStyle = (size == SegmentControlSize.large
                ? textStyles.paragraphMedium
                : textStyles.paragraphSmall)
            .copyWith(
          color: colors.content2.withAlpha(
            OpacV2.opac50.toByteInt(),
          ),
        );

  final Color backgroundColor;
  final Color iconColor;
  final TextStyle titleTextStyle;
  final TextStyle valueTextStyle;
}
