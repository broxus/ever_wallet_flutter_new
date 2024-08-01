import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class PrimaryText extends StatelessWidget {
  const PrimaryText(
    this.text, {
    this.type = PrimaryTextType.descriptionLarge,
    this.textAlign = TextAlign.center,
    super.key,
  });

  final String text;
  final PrimaryTextType type;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: _getTextStyle(context.themeStyleV2.textStyles),
      textAlign: textAlign,
    );
  }

  TextStyle _getTextStyle(TextStylesV2 textStyles) => switch (type) {
        PrimaryTextType.titleLarge => textStyles.headingLarge,
        PrimaryTextType.titleSmall => textStyles.headingXSmall,
        PrimaryTextType.descriptionLarge => textStyles.paragraphMedium,
        PrimaryTextType.descriptionSmall => textStyles.paragraphXSmall,
      };
}

enum PrimaryTextType {
  titleLarge,
  titleSmall,
  descriptionLarge,
  descriptionSmall,
}
