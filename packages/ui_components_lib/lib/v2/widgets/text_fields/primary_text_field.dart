import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/widgets/text_fields/base_text_field.dart';

class PrimaryTextField extends StatelessWidget {
  const PrimaryTextField({
    super.key,
    this.height,
    this.sizeType = PrimaryTextFieldSize.large,
  });

  final double? height;
  final PrimaryTextFieldSize sizeType;

  @override
  Widget build(BuildContext context) {
    return BaseTextField(
      height: height ?? sizeType.height,
    );
  }
}

enum PrimaryTextFieldSize {
  large(56),
  medium(48);

  const PrimaryTextFieldSize(this.height);

  final double height;
}
