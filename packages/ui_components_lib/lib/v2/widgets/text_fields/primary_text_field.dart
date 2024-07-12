import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/text_fields/base_text_field.dart';

class PrimaryTextField extends StatelessWidget {
  const PrimaryTextField({
    super.key,
    this.hintText,
    this.labelText,
    this.errorText,
    this.errorType = PrimaryTextFieldErrorType.outline,
    this.height,
    this.sizeType = PrimaryTextFieldSizeType.large,
    this.isAutofocus = false,
    this.textEditingController,
    this.inputFormatters,
    this.validator,
    this.focusNode,
    this.keyboardType = TextInputType.text,
    this.fillColor,
    this.isObscureText = false,
    this.isEnable = true,
    this.isShowError,
    this.textInputAction,
    this.onSubmit,
    this.onChanged,
  });

  final String? hintText;
  final String? labelText;
  final String? errorText;
  final PrimaryTextFieldErrorType? errorType;
  final double? height;
  final PrimaryTextFieldSizeType sizeType;
  final bool isAutofocus;
  final TextEditingController? textEditingController;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final Color? fillColor;
  final bool isObscureText;
  final bool isEnable;
  final bool? isShowError;
  final ValueChanged<String?>? onSubmit;
  final ValueChanged<String?>? onChanged;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    final themeStyle = context.themeStyleV2;

    // TODO(knightforce): use needed textstyle and color from thee
    final hintTextStyle = themeStyle?.textStyles.labelLarge.copyWith(
      color: themeStyle.colors.content1,
      height: 1,
    );

    return BaseTextField(
      hintText: hintText,
      labelText: labelText,
      errorText: errorText,
      activeBackgroundColor: themeStyle?.colors.background1,
      enabledBorder: _getBorder(color: themeStyle?.colors.border0),
      disabledBorder: _getBorder(color: themeStyle?.colors.borderDisabled),
      focusedBorder: _getBorder(color: themeStyle?.colors.borderFocus),
      errorBorder: _getBorder(color: themeStyle?.colors.borderNegative),
      borderRadius: BorderRadius.circular(16),
      height: height ?? sizeType.height,
      isAutofocus: isAutofocus,
      // TODO(knightforce): use needed textstyle and color from thee
      textStyle: themeStyle?.textStyles.labelLarge.copyWith(
        color: ColorsResV2.p100,
        height: 1,
      ),
      disabledTextStyle: hintTextStyle,
      hintTextStyle: hintTextStyle,
      labelTextStyle: themeStyle?.textStyles.labelLarge.copyWith(
        color: themeStyle.colors.content2,
        height: 1,
      ),
      controller: textEditingController,
      inputFormatters: inputFormatters,
      validator: validator,
      focusNode: focusNode,
      keyboardType: keyboardType,
      fillColor: fillColor,
      isObscureText: isObscureText,
      isEnable: isEnable,
      isShowError: isShowError,
      onSubmit: onSubmit,
      onChanged: onChanged,
      textInputAction: textInputAction,
      enabledOpacity: 1,
      disabledOpacity: .5,
      postfixes: [
        /// TODO
        if (errorType == PrimaryTextFieldErrorType.outline) const Placeholder(),
      ],
    );
  }

  Border? _getBorder({
    Color? color,
  }) {
    return color == null
        ? null
        : Border.all(
            color: color,
          );
  }
}

enum PrimaryTextFieldSizeType {
  large(56),
  medium(48);

  const PrimaryTextFieldSizeType(this.height);

  final double height;
}

enum PrimaryTextFieldErrorType {
  inline,
  outline,
}
