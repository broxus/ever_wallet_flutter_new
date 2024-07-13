import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/text_fields/base_text_field.dart';

class PrimaryTextField extends StatelessWidget {
  const PrimaryTextField({
    super.key,
    this.name,
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

  final String? name;
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

    final hintTextStyle = themeStyle?.textStyles.labelLarge.copyWith(
      color: themeStyle.colors.content1,
    );

    return BaseTextField(
      name: name,
      hintText: hintText,
      labelText: labelText,
      errorText: errorText,
      activeBackgroundColor: themeStyle?.colors.background1,
      enabledBorder: _getBorder(color: themeStyle?.colors.border0),
      disabledBorder: _getBorder(color: themeStyle?.colors.borderDisabled),
      focusedBorder: _getBorder(color: themeStyle?.colors.borderFocus),
      errorBorder: _getBorder(color: themeStyle?.colors.borderNegative),
      borderRadius: BorderRadius.circular(DimensSize.d20),
      height: height ?? sizeType.height,
      isAutofocus: isAutofocus,
      textStyle: themeStyle?.textStyles.labelSmall.copyWith(
        color: themeStyle.colors.primaryA,
      ),
      disabledTextStyle: hintTextStyle,
      hintTextStyle: hintTextStyle,
      labelTextStyle: themeStyle?.textStyles.labelSmall.copyWith(
        color: themeStyle.colors.content3,
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
        if (errorType == PrimaryTextFieldErrorType.outline)
          const Icon(
            LucideIcons.triangleAlert,
            size: DimensSize.d20,
          ),
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
  large(DimensSize.d56),
  medium(DimensSize.d48);

  const PrimaryTextFieldSizeType(this.height);

  final double height;
}

enum PrimaryTextFieldErrorType {
  inline,
  outline,
}
