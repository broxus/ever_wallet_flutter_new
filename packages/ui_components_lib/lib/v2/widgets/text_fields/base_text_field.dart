import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ui_components_lib/dimens.dart';
import 'package:ui_components_lib/v2/utils/state_mixins.dart';

class BaseTextField extends StatefulWidget {
  const BaseTextField({
    super.key,
    this.name,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.errorInlineIcon,
    this.contentPadding = EdgeInsets.zero,
    this.errorText,
    this.errorTextStyle,
    this.activeBackgroundColor,
    this.disableBackgroundColor,
    this.focusedBackgroundColor,
    this.errorBackgroundColor,
    this.enabledBorder,
    this.disabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.borderRadius,
    this.height,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.textStyle,
    this.disabledTextStyle,
    this.hintTextStyle,
    this.disabledHintTextStyle,
    this.controller,
    this.inputFormatters,
    this.validator,
    this.focusNode,
    this.keyboardType = TextInputType.text,
    this.fillColor,
    this.isAutofocus = false,
    this.isObscureText = false,
    this.isEnabled = true,
    this.isShowError,
    this.onSubmit,
    this.onChanged,
    this.textInputAction,
    this.maxLength,
    this.minLines,
    this.maxLines,
    this.enabledOpacity,
    this.disabledOpacity,
    this.postfixes,
    this.errorType = TextFieldErrorType.outline,
  });

  final String? name;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? errorInlineIcon;
  final EdgeInsetsGeometry contentPadding;
  final Color? activeBackgroundColor;
  final Color? disableBackgroundColor;
  final Color? focusedBackgroundColor;
  final Color? errorBackgroundColor;
  final BoxBorder? enabledBorder;
  final BoxBorder? disabledBorder;
  final BoxBorder? focusedBorder;
  final BoxBorder? errorBorder;
  final BorderRadiusGeometry? borderRadius;
  final String? errorText;
  final TextStyle? errorTextStyle;
  final double? height;
  final AutovalidateMode autovalidateMode;
  final bool isAutofocus;
  final TextStyle? textStyle;
  final TextStyle? disabledTextStyle;
  final TextStyle? hintTextStyle;
  final TextStyle? disabledHintTextStyle;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final Color? fillColor;
  final bool isObscureText;
  final bool isEnabled;
  final ValueChanged<String?>? onSubmit;
  final ValueChanged<String?>? onChanged;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final double? enabledOpacity;
  final double? disabledOpacity;
  final List<Widget>? postfixes;
  final TextFieldErrorType errorType;
  final bool? isShowError;

  @override
  State<BaseTextField> createState() => _BaseTextFieldState();
}

class _BaseTextFieldState extends State<BaseTextField> with StateMixin {
  static final _r = Random();

  late final _controller = widget.controller ?? TextEditingController();

  late final _focusNode = widget.focusNode ?? FocusNode();

  String? _localName;

  final _counterText = '';

  String? _errorText;

  String get _name {
    if (widget.name != null) {
      return widget.name!;
    }

    return _localName ??= _r.nextDouble().toString();
  }

  bool get _isEnabled => widget.isEnabled;

  bool get _isFocused => _focusNode.hasFocus;

  bool get _isShowedError {
    return widget.isShowError ?? (widget.errorText ?? _errorText) != null;
  }

  BoxBorder? get _border {
    BoxBorder? result;
    if (!_isEnabled) {
      result = widget.disabledBorder;
    } else if (_isShowedError) {
      result = widget.errorBorder;
    } else if (_isFocused) {
      result = widget.focusedBorder;
    }

    return result ?? widget.enabledBorder;
  }

  BorderRadiusGeometry get _borderRadius =>
      widget.borderRadius ?? BorderRadius.zero;

  Color? get _backgroundColor {
    Color? result;
    if (!_isEnabled) {
      result = widget.disableBackgroundColor;
    } else if (_isShowedError) {
      result = widget.errorBackgroundColor;
    } else if (_isFocused) {
      result = widget.focusedBackgroundColor;
    }

    return result ?? widget.activeBackgroundColor;
  }

  TextStyle? get _textStyle {
    return _isEnabled ? widget.textStyle : widget.disabledTextStyle;
  }

  TextStyle? get _hintTextStyle {
    return _isEnabled ? widget.hintTextStyle : widget.disabledHintTextStyle;
  }

  double get _opacity {
    if (_isEnabled) {
      return widget.enabledOpacity ?? 1;
    }

    return widget.disabledOpacity ?? 1;
  }

  @override
  void initState() {
    _focusNode.addListener(_onChangeFocus);

    super.initState();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }

    if (widget.focusNode == null) {
      _focusNode.dispose();
    } else {
      _focusNode.removeListener(_onChangeFocus);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: _Container(
            height: widget.height,
            color: _backgroundColor,
            borderRadius: _borderRadius,
            border: _border,
            opacity: _opacity,
            child: FormBuilderTextField(
              enabled: _isEnabled,
              name: _name,
              decoration: InputDecoration(
                filled: true,
                hintText: widget.hintText,
                hintStyle: _hintTextStyle,
                errorStyle: const TextStyle(fontSize: 0),
                fillColor: Colors.transparent,
                contentPadding: widget.contentPadding,
                counterText: _counterText,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                border: InputBorder.none,
                prefixIconConstraints: const BoxConstraints(),
                prefixIcon: widget.prefixIcon,
                suffixIconConstraints: const BoxConstraints(),
                suffixIcon: Align(
                  widthFactor: 1,
                  heightFactor: 1,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.suffixIcon != null) widget.suffixIcon!,
                      if (_isShowedError &&
                          widget.errorType == TextFieldErrorType.inline &&
                          widget.errorInlineIcon != null)
                        widget.errorInlineIcon!,
                    ],
                  ),
                ),
              ),
              keyboardType: widget.keyboardType,
              obscureText: widget.isObscureText,
              onSubmitted: widget.onSubmit,
              onChanged: widget.onChanged,
              textInputAction: widget.textInputAction,
              controller: _controller,
              focusNode: _focusNode,
              readOnly: !_isEnabled,
              style: _textStyle,
              autovalidateMode: widget.autovalidateMode,
              inputFormatters: widget.inputFormatters,
              autofocus: widget.isAutofocus,
              maxLength: widget.maxLength,
              maxLines: widget.maxLines,
              minLines: widget.minLines,
              expands: true,
              textAlignVertical: TextAlignVertical.center,
              validator: _validate,
            ),
          ),
        ),
        if (_isShowedError && widget.errorType == TextFieldErrorType.outline)
          Flexible(
            child: _ErrorText(
              text: widget.errorText ?? _errorText,
              style: widget.errorTextStyle,
            ),
          ),
      ],
    );
  }

  @protected
  String? _validate(String? text) {
    final validator = widget.validator;

    if (validator == null) {
      return null;
    }

    final validatorErrorText = validator.call(text);

    _onValidate(validatorErrorText);

    return validatorErrorText == null ? null : '';
  }

  void _onValidate(String? validatorErrorText) {
    if (_errorText == validatorErrorText) {
      return;
    }
    Future(() => setStateSafe(() => _errorText = validatorErrorText));
  }

  void _onChangeFocus() {
    setStateSafe();
  }
}

class _Container extends StatelessWidget {
  const _Container({
    required this.borderRadius,
    required this.child,
    required this.border,
    required this.opacity,
    this.color,
    this.height,
  });

  final Widget child;
  final BorderRadiusGeometry borderRadius;
  final double opacity;
  final BoxBorder? border;
  final Color? color;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Opacity(
        opacity: opacity,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            border: border,
            color: color,
          ),
          child: ClipRRect(
            borderRadius: borderRadius,
            child: child,
          ),
        ),
      ),
    );
  }
}

class _ErrorText extends StatelessWidget {
  const _ErrorText({
    this.text,
    this.style,
  });

  final String? text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    if (text == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: DimensSize.d8),
      child: Text(
        text!,
        style: style,
      ),
    );
  }
}

enum TextFieldErrorType {
  inline,
  outline,
}
