import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_components_lib/v2/utils/state_mixins.dart';

class BaseTextField extends StatefulWidget {
  const BaseTextField({
    super.key,
    this.hintText,
    this.labelText,
    this.errorText,
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
    this.labelTextStyle,
    this.disabledLabelTextStyle,
    this.controller,
    this.inputFormatters,
    this.validator,
    this.focusNode,
    this.keyboardType = TextInputType.text,
    this.fillColor,
    this.isObscureText = false,
    this.isEnable = true,
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

  final String? hintText;
  final String? labelText;
  final Color? activeBackgroundColor;
  final Color? disableBackgroundColor;
  final Color? focusedBackgroundColor;
  final Color? errorBackgroundColor;
  final Border? enabledBorder;
  final Border? disabledBorder;
  final Border? focusedBorder;
  final Border? errorBorder;
  final BorderRadiusGeometry? borderRadius;
  final String? errorText;
  final double? height;
  final AutovalidateMode autovalidateMode;
  final bool isAutofocus;
  final TextStyle? textStyle;
  final TextStyle? disabledTextStyle;
  final TextStyle? hintTextStyle;
  final TextStyle? disabledHintTextStyle;
  final TextStyle? labelTextStyle;
  final TextStyle? disabledLabelTextStyle;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final Color? fillColor;
  final bool isObscureText;
  final bool isEnable;
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
  late final _controller = widget.controller ?? TextEditingController();

  late final _focusNode = widget.focusNode ?? FocusNode();

  bool _isError = false;

  bool get _isEnable => widget.isEnable;

  bool get _isFocused => _focusNode.hasFocus;

  String get _text => _controller.text;

  bool get _isShowError => widget.isShowError ?? _isError;

  String? get _errorText {
    return _isShowError
        ? widget.errorText ?? widget.validator?.call(_text)
        : null;
  }

  BoxBorder? get _border {
    Border? result;
    if (!_isEnable) {
      result = widget.disabledBorder;
    } else if (_isShowError) {
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
    if (!_isEnable) {
      result = widget.disableBackgroundColor;
    } else if (_isShowError) {
      result = widget.errorBackgroundColor;
    } else if (_isFocused) {
      result = widget.focusedBackgroundColor;
    }

    return result ?? widget.activeBackgroundColor;
  }

  TextStyle? get _textStyle {
    return _isEnable ? widget.textStyle : widget.disabledTextStyle;
  }

  TextStyle? get _hintTextStyle {
    return _isEnable ? widget.hintTextStyle : widget.disabledHintTextStyle;
  }

  TextStyle? get _labelTextStyle {
    return _isEnable ? widget.labelTextStyle : widget.disabledLabelTextStyle;
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
    final postfixes = widget.postfixes;

    return Opacity(
      opacity: _opacity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: _backgroundColor,
              border: _border,
              borderRadius: _borderRadius,
            ),
            child: ClipRRect(
              borderRadius: _borderRadius,
              child: Row(
                children: [
                  if (widget.labelText != null) _Label(widget.labelText!),
                  TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      contentPadding: widget.contentPadding,
                      hintText: widget.hintText,
                      hintStyle: _hintTextStyle,
                      labelStyle: _labelTextStyle,
                      errorStyle: const TextStyle(fontSize: 0),
                      fillColor: _backgroundColor,
                      counterText: "",
                      enabled: _isEnable,
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      border: InputBorder.none,
                    ),
                    keyboardType: widget.keyboardType,
                    obscureText: widget.isObscureText,
                    onFieldSubmitted: widget.onSubmit,
                    onChanged: widget.onChanged,
                    textInputAction: widget.textInputAction,
                    controller: _controller,
                    focusNode: _focusNode,
                    readOnly: !_isEnable,
                    style: _textStyle,
                    autovalidateMode: widget.autovalidateMode,
                    inputFormatters: widget.inputFormatters,
                    autofocus: widget.isAutofocus,
                    maxLength: widget.maxLength,
                    maxLines: widget.maxLines,
                    minLines: widget.minLines,
                    validator: _validate,
                  ),
                  if (postfixes != null && postfixes.isNotEmpty)
                    for (final action in postfixes) action,
                ],
              ),
            ),
          ),
          if (_errorText != null)
            Flexible(
              child: _ErrorText(_errorText!),
            ),
        ],
      ),
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

class _Label extends StatelessWidget {
  const _Label(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}

class _ErrorText extends StatelessWidget {
  final String _text;

  const _ErrorText(
    this._text, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        _text,

        /// TODO
      ),
    );
  }
}
