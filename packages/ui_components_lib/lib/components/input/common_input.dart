import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_components_lib/components/input/common_input_style_v2.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Default height for input
const commonInputHeight = DimensSize.d56;
const suggestionDividerSize = DimensStroke.small;

typedef SuggestionsCallback<T> = FutureOr<List<T>?> Function(String search);

typedef SuggestionsItemBuilder<T> = Widget Function(
  BuildContext context,
  T value,
);

/// {@template common_input}
/// Defaut input field that could be used in application.
/// This widget is a combination of default TextField and TypeAheadField.
///
/// To use TypeAheadField, you need to specify [suggestionsCallback],
/// [itemBuilder] and [onSuggestionSelected].
///
/// Also widget supports validation via FormField by [validator].
///
/// If [validator] specified and it returns not null value, then input will be
/// visible below input field. If empty text returned, only border will be red.
/// {@endtemplate}
class CommonInput extends StatefulWidget {
  /// {@macro common_input}
  const CommonInput({
    super.key,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.autocorrect = true,
    this.enableSuggestions = false,
    this.onSubmitted,
    this.validator,
    this.validateMode,
    this.onChanged,
    this.inputFormatters,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.suggestionsCallback,
    this.itemBuilder,
    this.onSuggestionSelected,
    this.height = commonInputHeight,
    this.onClearField,
    this.needClearButton = true,
    this.suggestionBackground,
    this.textStyle,
    this.textAlign = TextAlign.start,
    this.hintStyle,
    this.cursorColor,
    this.enabledBorderColor,
    this.inactiveBorderColor,
    this.focusedBorderColor,
    this.errorColor,
    this.obscureText = false,
    this.titleText,
    this.titleChild,
    this.subtitleText,
    this.prefixIconConstraints,
    this.suffixIconConstraints,
    this.fillColor,
    this.maxLength,
    this.outerActions,
    this.enabled = true,
    this.v2Style,
    this.radius = DimensRadius.medium,
  });

  /// Height of input field
  final double height;

  /// Controller for input field
  final TextEditingController? controller;

  /// Focus node for input field
  final FocusNode? focusNode;

  /// Type of keyboard, default to [TextInputType.text]
  final TextInputType? keyboardType;

  /// Action on submit, default to [TextInputAction.next]
  final TextInputAction? textInputAction;

  /// Flag to enable autocorrect, default to true
  final bool autocorrect;

  /// Flag to enable suggestions, default to false
  final bool enableSuggestions;

  /// Callback on submit action
  final void Function(String)? onSubmitted;

  /// If not null, then input will be validated by form
  final FormFieldValidator<String?>? validator;

  /// How field must be validated
  final AutovalidateMode? validateMode;

  /// Callback on input changes
  final void Function(String)? onChanged;

  /// Input formatters
  final List<TextInputFormatter>? inputFormatters;

  /// Hint text for input field
  final String? hintText;

  /// Icon to show before input field.
  /// If you want specify custom icon, you need to wrap your input with
  /// [BoxConstraints] for proper behavior.
  final Widget? prefixIcon;

  /// Constraints for [prefixIcon]
  final BoxConstraints? prefixIconConstraints;

  /// Constraints for [suffixIcon]
  final BoxConstraints? suffixIconConstraints;

  /// Icon to show after input field, if not specified and [needClearButton] is
  /// true then custom clear button will be shown.
  /// If you want specify custom icon, you need to wrap your input with
  /// [BoxConstraints] for proper behavior.
  final Widget? suffixIcon;

  /// Callback for suggestions.
  /// If null, then TextField will be used
  final SuggestionsCallback<String>? suggestionsCallback;

  /// Builder function for suggestions, no need for TextField.
  /// If null, default is used
  final SuggestionsItemBuilder<String>? itemBuilder;

  /// Callback for suggestion selection, no need for TextField
  final ValueSetter<String>? onSuggestionSelected;

  final Color? cursorColor;

  /// Border color for input with focus
  final Color? enabledBorderColor;

  /// Border color for input without focus
  final Color? inactiveBorderColor;

  /// Border color for input with focus
  final Color? focusedBorderColor;

  /// Border color for input with error
  final Color? errorColor;

  /// Callback that calls if clear button was pressed
  final VoidCallback? onClearField;

  /// If true, then clear button will be shown as [suffixIcon], true by default
  final bool needClearButton;

  /// Background color for suggestions
  final Color? suggestionBackground;

  /// Style for text of input, color used for cursor, default
  /// [StyleRes.primaryRegular] and [ColorsPalette.textPrimary]
  /// or [ColorsPalette.textSecondary] if the input is not enabled.
  final TextStyle? textStyle;

  final TextAlign textAlign;

  /// Style for label text, default [StyleRes.primaryRegular] and
  /// [ColorsPalette.textSecondary].
  final TextStyle? hintStyle;

  /// Title (name) of input, it displays above input
  final String? titleText;

  /// Custom title instead of [titleText]
  final Widget? titleChild;

  /// Subtitle (additional info) of input, displays near title.
  /// To display subtitle, specify [titleText].
  final String? subtitleText;

  /// If text should look like password, default false
  final bool obscureText;

  /// See [InputDecoration.fillColor]
  final Color? fillColor;

  /// See [TextField.maxLength]
  final int? maxLength;

  /// Actions that will be displayed right from text field
  final List<Widget>? outerActions;

  /// Flag to enable/disable input
  final bool enabled;

  ///remove after refactoring enter_seed_phrase_view
  ///only for fast fix
  final CommonInputStyleV2? v2Style;

  final double radius;

  @override
  State<CommonInput> createState() => _CommonInputState();
}

class _CommonInputState extends State<CommonInput> {
  late TextEditingController _controller;
  bool isEmpty = true;

  FormFieldState<String>? field;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();

    _controller.addListener(_handleDidChange);
  }

  @override
  void dispose() {
    _controller.removeListener(_handleDidChange);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _handleInput();
  }

  @override
  void didUpdateWidget(covariant CommonInput oldWidget) {
    if (widget.controller != null && widget.controller != _controller) {
      _controller.removeListener(_handleDidChange);
      _controller = widget.controller!;
      _controller.addListener(_handleDidChange);
    }

    return super.didUpdateWidget(oldWidget);
  }

  void _handleDidChange() {
    final value = _controller.text;
    if (!mounted) return;
    _handleInput();
    field?.didChange(value);
  }

  void _handleInput() {
    if (!mounted) return;
    final inputText = _controller.text;
    isEmpty = inputText.isEmpty;
  }

  // ignore: long-method
  Widget _onBuild(FormFieldState<String> state) {
    final colors = context.themeStyle.colors;
    field = state;

    Widget child;

    final suggestionsCallback = widget.suggestionsCallback;
    child = suggestionsCallback == null
        ? _commonInputField(colors: colors, hasError: state.hasError)
        : _suggestionsInputField(
            colors: colors,
            hasError: state.hasError,
            suggestionsCallback: suggestionsCallback,
          );

    if (widget.outerActions != null) {
      child = SeparatedRow(
        children: [
          Expanded(child: child),
          ...widget.outerActions!,
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.titleText != null || widget.titleChild != null) ...[
          Text.rich(
            TextSpan(
              children: [
                if (widget.titleChild != null) ...[
                  WidgetSpan(child: widget.titleChild!),
                  const WidgetSpan(child: SizedBox(width: DimensSize.d4)),
                ],
                if (widget.titleText != null)
                  TextSpan(
                    text: widget.titleText,
                    style: StyleRes.secondaryBold
                        .copyWith(color: colors.textPrimary),
                  ),
                if (widget.subtitleText != null) ...[
                  const WidgetSpan(child: SizedBox(width: DimensSize.d4)),
                  TextSpan(
                    text: widget.subtitleText,
                    style: StyleRes.addRegular
                        .copyWith(color: colors.textSecondary),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: DimensSize.d8),
        ],
        child,
        if (state.errorText != null && state.errorText!.isNotEmpty) ...[
          const SizedBox(height: DimensSize.d4),
          Text(
            state.errorText!,
            style: StyleRes.addRegular.copyWith(
              color: widget.errorColor ?? colors.alert,
            ),
          ),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) => FormField<String>(
        validator: widget.validator,
        autovalidateMode: widget.validateMode,
        initialValue: _controller.text,
        enabled: widget.enabled,
        builder: _onBuild,
      );

  Widget _buildSuffixIcon(ColorsPalette colors) {
    if (widget.suffixIcon != null) return widget.suffixIcon!;
    if (widget.needClearButton && !isEmpty) {
      return _buildClearIcon(colors);
    }

    return const SizedBox.shrink();
  }

  BoxConstraints _suffixIconConstraints() {
    if (widget.suffixIconConstraints != null) {
      return widget.suffixIconConstraints!;
    }

    if (widget.suffixIcon != null || widget.needClearButton && !isEmpty) {
      return BoxConstraints(
        minHeight: widget.height,
        minWidth: defaultCommonIconButtonSize,
      );
    }

    return BoxConstraints(
      minHeight: widget.height,
      minWidth: DimensSize.d8,
    );
  }

  BoxConstraints _prefixIconConstraints() {
    if (widget.prefixIconConstraints != null) {
      return widget.prefixIconConstraints!;
    }

    if (widget.prefixIcon != null) {
      return BoxConstraints(
        minHeight: widget.height,
        minWidth: defaultCommonIconButtonSize,
      );
    }

    return BoxConstraints(
      minHeight: widget.height,
      minWidth: DimensSize.d8,
    );
  }

  Widget _buildClearIcon(ColorsPalette colors) {
    return CommonIconButton.icon(
      buttonType: EverButtonType.ghost,
      icon: Icons.clear_rounded,
      onPressed: _clearText,
      color: widget.textStyle?.color ?? colors.textSecondary,
    );
  }

  void _clearText() {
    widget.onClearField?.call();
    widget.focusNode?.unfocus();
    _controller.clear();
  }

  // ignore: long-method
  Widget _commonInputField({
    required ColorsPalette colors,
    required bool hasError,
  }) {
    final color = widget.enabled ? colors.textPrimary : colors.textSecondary;
    final style =
        widget.textStyle ?? StyleRes.primaryRegular.copyWith(color: color);

    return SizedBox(
      height: widget.height,
      child: TextField(
        obscureText: widget.obscureText,
        style: style,
        controller: _controller,
        focusNode: widget.focusNode,
        keyboardType: widget.keyboardType ?? TextInputType.text,
        onChanged: widget.onChanged,
        textInputAction: widget.textInputAction ?? TextInputAction.next,
        cursorColor: widget.cursorColor ?? widget.textStyle?.color ?? color,
        onSubmitted: widget.onSubmitted,
        autocorrect: widget.autocorrect,
        enableSuggestions: widget.enableSuggestions,
        inputFormatters: widget.inputFormatters,
        textAlign: widget.textAlign,
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.fillColor ?? colors.backgroundSecondary,
          errorText: hasError ? '' : null,
          errorStyle: const TextStyle(fontSize: 0, height: 0),
          hintText: widget.hintText,
          hintStyle: widget.hintStyle ??
              StyleRes.primaryRegular.copyWith(color: colors.textSecondary),
          contentPadding: EdgeInsets.zero,
          suffixIcon: _buildSuffixIcon(colors),
          suffixIconConstraints: _suffixIconConstraints(),
          prefixIconConstraints: _prefixIconConstraints(),
          prefixIcon:
              widget.prefixIcon ?? const SizedBox(width: DimensSize.d16),
          border: SquircleInputBorder(
            squircleRadius: widget.radius,
            borderSide: BorderSide(
              color: widget.inactiveBorderColor ?? colors.strokePrimary,
            ),
          ),
          enabledBorder: SquircleInputBorder(
            squircleRadius: widget.radius,
            borderSide: BorderSide(
              color: widget.enabledBorderColor ?? colors.strokePrimary,
            ),
          ),
          focusedBorder: SquircleInputBorder(
            squircleRadius: widget.radius,
            borderSide: BorderSide(
              color: widget.focusedBorderColor ?? colors.strokeContrast,
            ),
          ),
          errorBorder: SquircleInputBorder(
            squircleRadius: widget.radius,
            borderSide: BorderSide(
              color: widget.errorColor ?? colors.alert,
            ),
          ),
          focusedErrorBorder: SquircleInputBorder(
            squircleRadius: widget.radius,
            borderSide: BorderSide(
              color: widget.errorColor ?? colors.alert,
            ),
          ),
        ),
        enabled: widget.enabled,
      ),
    );
  }

  // ignore: long-method
  Widget _suggestionsInputField({
    required ColorsPalette colors,
    required bool hasError,
    required SuggestionsCallback<String> suggestionsCallback,
  }) {
    final onSuggestionSelected = widget.onSuggestionSelected;

    if (onSuggestionSelected == null) {
      assert(
        false,
        'onSuggestionSelected must be set to use TypeAheadField',
      );

      return const SizedBox();
    } else {
      return SizedBox(
        height: widget.height,
        child: TypeAheadField<String>(
          autoFlipDirection: true,
          hideOnEmpty: true,
          hideOnError: true,
          hideOnLoading: true,
          controller: _controller,
          focusNode: widget.focusNode,
          suggestionsCallback: suggestionsCallback,
          onSelected: onSuggestionSelected,
          itemSeparatorBuilder: (_, __) => Divider(
            height: suggestionDividerSize,
            color: widget.v2Style != null
                ? widget.v2Style!.borderSuggestionColor
                : colors.strokeSecondary,
            thickness: suggestionDividerSize,
          ),
          itemBuilder: widget.itemBuilder ??
              (context, item) =>
                  _defaultSuggestionItemBuilder(context, item, colors),
          decorationBuilder: (context, child) => ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth:
                    widget.v2Style != null ? double.infinity : DimensSize.d168,
              ),
              child: Material(
                type: MaterialType.card,
                shape: SquircleShapeBorder(
                  cornerRadius: widget.v2Style != null
                      ? DimensSizeV2.d12
                      : DimensRadius.medium,
                ),
                color:
                    widget.suggestionBackground ?? colors.backgroundSecondary,
                child: child,
              ),
            ),
          ),
          builder: (context, controller, focusNode) => TextField(
            style: widget.textStyle ??
                StyleRes.primaryRegular.copyWith(color: colors.textPrimary),
            controller: controller,
            focusNode: focusNode,
            keyboardType: widget.keyboardType ?? TextInputType.text,
            onChanged: widget.onChanged,
            textInputAction: widget.textInputAction ?? TextInputAction.next,
            cursorColor: widget.textStyle?.color ?? colors.textPrimary,
            onSubmitted: widget.onSubmitted,
            autocorrect: widget.autocorrect,
            enableSuggestions: widget.enableSuggestions,
            inputFormatters: widget.inputFormatters,
            maxLength: widget.maxLength,
            decoration: InputDecoration(
              errorText: hasError ? '' : null,
              errorStyle: const TextStyle(fontSize: 0, height: 0),
              hintText: widget.hintText,
              hintStyle: widget.hintStyle ??
                  StyleRes.primaryRegular.copyWith(color: colors.textSecondary),
              contentPadding: EdgeInsets.zero,
              suffixIcon: _buildSuffixIcon(colors),
              suffixIconConstraints: _suffixIconConstraints(),
              prefixIconConstraints: widget.prefixIcon == null
                  ? const BoxConstraints(
                      maxHeight: 0,
                      maxWidth: DimensSize.d16,
                    )
                  : const BoxConstraints(
                      minHeight: commonInputHeight,
                      minWidth: DimensSize.d40,
                    ),
              prefixIcon:
                  widget.prefixIcon ?? const SizedBox(width: DimensSize.d16),
              border: SquircleInputBorder(
                squircleRadius: widget.v2Style != null
                    ? DimensRadius.xMedium
                    : DimensRadius.medium,
                borderSide: BorderSide(
                  color: widget.inactiveBorderColor ?? colors.strokePrimary,
                ),
              ),
              enabledBorder: SquircleInputBorder(
                squircleRadius: widget.v2Style != null
                    ? DimensRadius.xMedium
                    : DimensRadius.medium,
                borderSide: BorderSide(
                  color: widget.inactiveBorderColor ?? colors.strokePrimary,
                ),
              ),
              focusedBorder: SquircleInputBorder(
                squircleRadius: widget.v2Style != null
                    ? DimensRadius.xMedium
                    : DimensRadius.medium,
                borderSide: BorderSide(
                  color: widget.v2Style != null
                      ? widget.v2Style!.borderColor
                      : colors.strokeContrast,
                ),
              ),
              errorBorder: SquircleInputBorder(
                squircleRadius: widget.v2Style != null
                    ? DimensRadius.xMedium
                    : DimensRadius.medium,
                borderSide: BorderSide(
                  color: widget.errorColor ?? colors.alert,
                ),
              ),
              focusedErrorBorder: SquircleInputBorder(
                squircleRadius: widget.v2Style != null
                    ? DimensRadius.xMedium
                    : DimensRadius.medium,
                borderSide: BorderSide(
                  color: widget.errorColor ?? colors.alert,
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  /// Default builder for suggestions item
  Widget _defaultSuggestionItemBuilder(
    BuildContext _,
    String itemData,
    ColorsPalette colors,
  ) {
    return Container(
      height: DimensSize.d40,
      margin: const EdgeInsets.all(DimensSize.d12),
      child: ListTile(
        title: Text(
          itemData,
          style: StyleRes.button.copyWith(color: colors.textPrimary),
        ),
      ),
    );
  }
}
