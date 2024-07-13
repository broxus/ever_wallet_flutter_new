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
    this.isEnabled = true,
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
  final bool isEnabled;
  final bool? isShowError;
  final ValueChanged<String?>? onSubmit;
  final ValueChanged<String?>? onChanged;
  final TextInputAction? textInputAction;

  String? get _errorText => switch (errorType) {
        PrimaryTextFieldErrorType.inline => null,
        _ => errorText,
      };

  @override
  Widget build(BuildContext context) {
    final themeStyle = context.themeStyleV2;

    final hintTextStyle = themeStyle?.textStyles.labelSmall.copyWith(
      color: themeStyle.colors.content1,
      height: 1,
    );

    final radius = BorderRadius.circular(DimensSize.d20);

    return BaseTextField(
      name: name,
      hintText: hintText,
      errorText: _errorText,
      activeBackgroundColor: themeStyle?.colors.background1,
      enabledBorder: _getBorder(
        color: themeStyle?.colors.border0,
        radius: radius,
      ),
      disabledBorder: _getBorder(
        color: themeStyle?.colors.borderDisabled,
        radius: radius,
      ),
      focusedBorder: _getBorder(
        color: themeStyle?.colors.borderFocus,
        radius: radius,
      ),
      errorBorder: _getBorder(
        color: themeStyle?.colors.borderNegative,
        radius: radius,
      ),
      borderRadius: radius,
      height: height ?? sizeType.height,
      contentPadding: const EdgeInsets.only(
        right: DimensSize.d8,
        top: DimensSize.d8,
        bottom: DimensSize.d8,
      ),
      prefixIcon: labelText == null
          ? const SizedBox(
              width: DimensSize.d16,
            )
          : Padding(
              padding: const EdgeInsets.only(
                left: DimensSize.d16,
                right: DimensSize.d4,
              ),
              child: Text(
                labelText!,
                style: themeStyle?.textStyles.labelSmall.copyWith(
                  color: themeStyle.colors.content3,
                  height: 1,
                ),
              ),
            ),
      isAutofocus: isAutofocus,
      textStyle: themeStyle?.textStyles.labelSmall.copyWith(
        color: themeStyle.colors.primaryA,
        height: 1,
      ),
      disabledTextStyle: hintTextStyle,
      hintTextStyle: hintTextStyle,
      controller: textEditingController,
      inputFormatters: inputFormatters,
      validator: validator,
      focusNode: focusNode,
      keyboardType: keyboardType,
      fillColor: fillColor,
      isObscureText: isObscureText,
      isEnabled: isEnabled,
      isShowError: isShowError,
      onSubmit: onSubmit,
      onChanged: onChanged,
      textInputAction: textInputAction,
      enabledOpacity: 1,
      disabledOpacity: .5,
      suffixBuilder: ({
        required bool isShowError,
      }) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (errorType == PrimaryTextFieldErrorType.inline)
              const Icon(
                LucideIcons.triangleAlert,
                size: DimensSize.d20,
              ),
          ],
        );
      },
    );
  }

  OutlineInputBorder? _getBorder({
    Color? color,
    required BorderRadius radius,
  }) {
    return color == null
        ? null
        : OutlineInputBorder(
            borderSide: BorderSide(
              color: color,
            ),
            borderRadius: radius,
            gapPadding: 0,
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
