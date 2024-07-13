import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ui_components_lib/v2/utils/state_mixins.dart';

typedef SuffixBuilder = Widget Function({
  required bool isShowError,
});

class BaseTextField extends StatefulWidget {
  const BaseTextField({
    super.key,
    this.name,
    this.hintText,
    this.prefixIcon,
    this.suffixBuilder,
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
    this.isAutofocus = false,
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
    this.isObscureText = false,
    this.isEnabled = true,
    this.isShowError,
    this.contentPadding = EdgeInsets.zero,
    this.onSubmit,
    this.onChanged,
    this.textInputAction,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.enabledOpacity,
    this.disabledOpacity,
    this.postfixes,
  });

  final String? name;
  final String? hintText;
  final Widget? prefixIcon;
  final SuffixBuilder? suffixBuilder;
  final Color? activeBackgroundColor;
  final Color? disableBackgroundColor;
  final Color? focusedBackgroundColor;
  final Color? errorBackgroundColor;
  final InputBorder? enabledBorder;
  final InputBorder? disabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
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
  final bool? isShowError;
  final EdgeInsetsGeometry contentPadding;
  final ValueChanged<String?>? onSubmit;
  final ValueChanged<String?>? onChanged;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final double? enabledOpacity;
  final double? disabledOpacity;
  final List<Widget>? postfixes;

  @override
  State<BaseTextField> createState() => _BaseTextFieldState();
}

class _BaseTextFieldState extends State<BaseTextField> with StateMixin {
  static final _r = Random();

  late final _controller = widget.controller ?? TextEditingController();

  late final _focusNode = widget.focusNode ?? FocusNode();

  String? _localName;

  final _counterText = '';

  bool _isError = false;

  String get _name {
    if (widget.name != null) {
      return widget.name!;
    }

    return _localName ??= _r.nextDouble().toString();
  }

  bool get _isEnabled => widget.isEnabled;

  bool get _isFocused => _focusNode.hasFocus;

  String get _text => _controller.text;

  bool get _isShowError => widget.isShowError ?? _isError;

  String? get _errorText {
    return _isShowError
        ? widget.errorText ?? widget.validator?.call(_text)
        : null;
  }

  BorderRadiusGeometry get _borderRadius =>
      widget.borderRadius ?? BorderRadius.zero;

  Color? get _backgroundColor {
    Color? result;
    if (!_isEnabled) {
      result = widget.disableBackgroundColor;
    } else if (_isShowError) {
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
    return widget.enabledOpacity ?? widget.disabledOpacity ?? 1;
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
            borderRadius: _borderRadius,
            opacity: _opacity,
            child: FormBuilderTextField(
              enabled: _isEnabled,
              name: _name,
              decoration: InputDecoration(
                filled: true,
                contentPadding: widget.contentPadding,
                hintText: widget.hintText,
                hintStyle: _hintTextStyle,
                errorStyle: const TextStyle(fontSize: 0),
                fillColor: _backgroundColor,
                counterText: _counterText,
                enabledBorder: widget.enabledBorder,
                disabledBorder: widget.disabledBorder,
                focusedBorder: widget.focusedBorder,
                errorBorder: widget.errorBorder,
                focusedErrorBorder: widget.errorBorder,
                border: widget.enabledBorder,
                prefixIconConstraints: const BoxConstraints(),
                prefixIcon: widget.prefixIcon,
                suffixIconConstraints: const BoxConstraints(),
                suffixIcon: widget.suffixBuilder == null
                    ? null
                    : Align(
                        widthFactor: 1,
                        heightFactor: 1,
                        child: widget.suffixBuilder!(
                          isShowError: _isShowError,
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
              validator: _validate,
            ),
          ),
        ),
        if (_errorText != null)
          Flexible(
            child: _ErrorText(
              text: _errorText!,
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

    final isSuccess = validator.call(text) == null;

    _onValidate(isSuccess);

    return isSuccess ? null : '';
  }

  void _onValidate(bool isSuccess) {
    if (_isError == !isSuccess) {
      return;
    }
    Future(() => setStateSafe(() => _isError = !isSuccess));
  }

  void _onChangeFocus() {
    setStateSafe();
  }
}

class _Container extends StatelessWidget {
  const _Container({
    required this.borderRadius,
    required this.child,
    required this.opacity,
    this.height,
  });

  final Widget child;
  final double? height;
  final BorderRadiusGeometry borderRadius;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Opacity(
        opacity: opacity,
        child: ClipRRect(
          borderRadius: borderRadius,
          child: child,
        ),
      ),
    );
  }
}

class _ErrorText extends StatelessWidget {
  const _ErrorText({
    required this.text,
    this.style,
  });

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        text,
        style: style,
      ),
    );
  }
}
