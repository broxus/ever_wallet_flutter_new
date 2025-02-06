import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/opac_v2.dart';
import 'package:ui_components_lib/v2/widgets/text_fields/base_text_field.dart';

/// {@template base_text_field}
/// Primary text field v2,
/// {@endtemplate}
class PrimaryTextField extends StatelessWidget {
  const PrimaryTextField({
    super.key,
    this.name,
    this.hintText,
    this.labelText,
    this.errorText,
    this.errorType = TextFieldErrorType.outline,
    this.height,
    this.sizeType = PrimaryTextFieldSizeType.large,
    this.isAutofocus = false,
    this.textEditingController,
    this.inputFormatters,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.focusNode,
    this.keyboardType = TextInputType.text,
    this.fillColor,
    this.isObscureText = false,
    this.isEnabled = true,
    this.isShowErrorForced,
    this.textInputAction,
    this.onSubmit,
    this.onChanged,
    this.suffixes,
    this.contentPadding,
    this.errorInlineIconPadding,
    this.maxLength,
  });

  final String? name;
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final TextFieldErrorType errorType;
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
  final bool isEnabled;
  final bool? isShowErrorForced;
  final ValueChanged<String?>? onSubmit;
  final ValueChanged<String?>? onChanged;
  final TextInputAction? textInputAction;
  final List<Widget>? suffixes;
  final EdgeInsets? contentPadding;
  final EdgeInsets? errorInlineIconPadding;
  final AutovalidateMode autovalidateMode;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    final themeStyle = context.themeStyleV2;

    final hintTextStyle = themeStyle.textStyles.labelSmall.copyWith(
      color: themeStyle.colors.content1,
      height: 1,
    );

    final radius = BorderRadius.circular(DimensSize.d16);

    return BaseTextField(
      name: name,
      hintText: hintText,
      errorText: errorText,
      activeBackgroundColor: themeStyle.colors.background1,
      cursorColor: themeStyle.colors.primaryA,
      enabledBorder: _getBorder(color: themeStyle.colors.border0),
      disabledBorder: _getBorder(color: themeStyle.colors.borderDisabled),
      focusedBorder: _getBorder(color: themeStyle.colors.borderFocus),
      errorBorder: _getBorder(color: themeStyle.colors.borderNegative),
      borderRadius: radius,
      height: height ?? sizeType.height,
      errorType: errorType,
      contentPadding: contentPadding ??
          const EdgeInsets.only(
            left: DimensSize.d16,
            right: DimensSize.d4,
          ),
      prefixIcon: labelText == null
          ? null
          : Padding(
              padding: const EdgeInsets.only(
                left: DimensSize.d16,
                right: DimensSize.d4,
              ),
              child: Text(
                labelText!,
                style: themeStyle.textStyles.labelSmall.copyWith(
                  color: themeStyle.colors.content3,
                  height: 1,
                ),
              ),
            ),
      isAutofocus: isAutofocus,
      textStyle: themeStyle.textStyles.labelSmall.copyWith(
        color: themeStyle.colors.content0,
        height: 1,
      ),
      errorTextStyle: themeStyle.textStyles.paragraphSmall.copyWith(
        color: themeStyle.colors.contentNegative,
      ),
      errorInlineIcon: Padding(
        padding: errorInlineIconPadding ??
            const EdgeInsets.symmetric(
              horizontal: DimensSize.d14,
            ),
        child: Center(
          child: Icon(
            LucideIcons.triangleAlert,
            size: DimensSize.d20,
            color: themeStyle.colors.contentNegative,
          ),
        ),
      ),
      disabledTextStyle: hintTextStyle,
      hintTextStyle: hintTextStyle,
      controller: textEditingController,
      inputFormatters: inputFormatters,
      validator: validator,
      autovalidateMode: autovalidateMode,
      focusNode: focusNode,
      keyboardType: keyboardType,
      fillColor: fillColor,
      isObscureText: isObscureText,
      isEnabled: isEnabled,
      isShowErrorForced: isShowErrorForced,
      onSubmit: onSubmit,
      onChanged: onChanged,
      textInputAction: textInputAction,
      enabledOpacity: OpacV2.opac100,
      disabledOpacity: OpacV2.opac50,
      suffixIcon: suffixes == null
          ? null
          : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: suffixes!,
            ),
      maxLines: isObscureText ? 1 : null,
      maxLength: maxLength,
    );
  }

  BoxBorder? _getBorder({Color? color}) {
    return color == null ? null : Border.all(color: color);
  }
}

enum PrimaryTextFieldSizeType {
  large(DimensSize.d56),
  medium(DimensSize.d48);

  const PrimaryTextFieldSizeType(this.height);

  final double height;
}
