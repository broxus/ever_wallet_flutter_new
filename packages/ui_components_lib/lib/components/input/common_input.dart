import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Default height for input
const commonInputHeight = 56.0;

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
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.suggestionsCallback,
    this.itemBuilder,
    this.onSuggestionSelected,
    this.height,
    this.onClearField,
    this.needClearButton = true,
    this.suggestionBackground,
    this.textStyle,
    this.labelStyle,
    this.enabledBorderColor,
    this.inactiveBorderColor,
    this.errorColor,
    this.obscureText = false,
  });

  /// Height of input field
  final double? height;

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

  /// Label text for input field
  final String? labelText;

  /// Icon to show before input field.
  /// If you want specify custom icon, you need to wrap your input with
  /// [BoxConstraints] for proper behavior.
  final Widget? prefixIcon;

  /// Icon to show after input field, if not specified and [needClearButton] is
  /// true then custom clear button will be shown.
  /// If you want specify custom icon, you need to wrap your input with
  /// [BoxConstraints] for proper behavior.
  final Widget? suffixIcon;

  /// Callback for suggestions.
  /// If null, then TextField will be used
  final SuggestionsCallback<String>? suggestionsCallback;

  /// Builder function for suggestions, no need for TextField
  final ItemBuilder<String>? itemBuilder;

  /// Callback for suggestion selection, no need for TextField
  final SuggestionSelectionCallback<String>? onSuggestionSelected;

  /// Border color for input with focus
  final Color? enabledBorderColor;

  /// Border color for input without focus
  final Color? inactiveBorderColor;

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
  final TextStyle? textStyle;

  /// Style for label text, default [StyleRes.primaryRegular] and
  /// [ColorsPalette.textSecondary].
  final TextStyle? labelStyle;

  /// If text should look like password, default false
  final bool obscureText;

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

  // TODO(Alex-A4): This method is too long, need to refactor
  // ignore: long-method
  Widget _onBuild(FormFieldState<String> state) {
    final colors = context.themeStyle.colors;
    field = state;

    Widget child;

    final suggestionsCallback = widget.suggestionsCallback;
    if (suggestionsCallback == null) {
      child = SizedBox(
        height: widget.height ?? commonInputHeight,
        child: TextField(
          obscureText: widget.obscureText,
          style: widget.textStyle ??
              StyleRes.primaryRegular.copyWith(color: colors.textPrimary),
          controller: _controller,
          focusNode: widget.focusNode,
          keyboardType: widget.keyboardType ?? TextInputType.text,
          onChanged: widget.onChanged,
          textInputAction: widget.textInputAction ?? TextInputAction.next,
          cursorWidth: 1,
          cursorColor: widget.textStyle?.color ?? colors.textPrimary,
          onSubmitted: widget.onSubmitted,
          autocorrect: widget.autocorrect,
          enableSuggestions: widget.enableSuggestions,
          inputFormatters: widget.inputFormatters,
          decoration: InputDecoration(
            errorText: state.hasError ? '' : null,
            errorStyle: const TextStyle(fontSize: 0, height: 0),
            labelText: widget.labelText,
            labelStyle: widget.labelStyle ??
                StyleRes.primaryRegular.copyWith(color: colors.textSecondary),
            contentPadding: EdgeInsets.zero,
            suffixIcon: _buildSuffixIcon(),
            prefixIconConstraints: widget.prefixIcon == null
                ? const BoxConstraints(maxHeight: 0, maxWidth: 16)
                : const BoxConstraints(
                    minHeight: commonInputHeight,
                    minWidth: 35,
                  ),
            prefixIcon: widget.prefixIcon ?? const SizedBox(width: 16),
            border: OutlineInputBorder(
              gapPadding: 1,
              borderRadius: BorderRadius.circular(0),
              borderSide: BorderSide(
                color: widget.inactiveBorderColor ?? colors.strokePrimary,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              gapPadding: 1,
              borderRadius: BorderRadius.circular(0),
              borderSide: BorderSide(
                color: widget.inactiveBorderColor ?? colors.strokePrimary,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              gapPadding: 1,
              borderRadius: BorderRadius.circular(0),
              borderSide: BorderSide(
                color: colors.strokeContrast,
              ),
            ),
            errorBorder: OutlineInputBorder(
              gapPadding: 1,
              borderRadius: BorderRadius.circular(0),
              borderSide: BorderSide(
                color: widget.errorColor ?? colors.alert,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              gapPadding: 1,
              borderRadius: BorderRadius.circular(0),
              borderSide: BorderSide(
                color: widget.errorColor ?? colors.alert,
              ),
            ),
          ),
        ),
      );
    } else {
      final itemBuilder = widget.itemBuilder;
      final onSuggestionSelected = widget.onSuggestionSelected;

      if (itemBuilder == null || onSuggestionSelected == null) {
        assert(
          false,
          // ignore: lines_longer_than_80_chars
          'itemBuilder and onSuggestionSelected must be set to use TypeAheadField',
        );
        child = const SizedBox();
      } else {
        child = SizedBox(
          height: widget.height ?? commonInputHeight,
          child: TypeAheadField<String>(
            autoFlipDirection: true,
            hideOnEmpty: true,
            hideOnError: true,
            hideOnLoading: true,
            textFieldConfiguration: TextFieldConfiguration(
              style: widget.textStyle ??
                  StyleRes.primaryRegular.copyWith(color: colors.textPrimary),
              controller: _controller,
              focusNode: widget.focusNode,
              keyboardType: widget.keyboardType ?? TextInputType.text,
              onChanged: widget.onChanged,
              textInputAction: widget.textInputAction ?? TextInputAction.next,
              cursorWidth: 1,
              cursorColor: widget.textStyle?.color ?? colors.textPrimary,
              onSubmitted: widget.onSubmitted,
              autocorrect: widget.autocorrect,
              enableSuggestions: widget.enableSuggestions,
              inputFormatters: widget.inputFormatters,
              decoration: InputDecoration(
                errorText: state.hasError ? '' : null,
                errorStyle: const TextStyle(fontSize: 0, height: 0),
                labelText: widget.labelText,
                labelStyle: widget.labelStyle ??
                    StyleRes.primaryRegular
                        .copyWith(color: colors.textSecondary),
                contentPadding: EdgeInsets.zero,
                suffixIcon: _buildSuffixIcon(),
                prefixIconConstraints: widget.prefixIcon == null
                    ? const BoxConstraints(maxHeight: 0, maxWidth: 16)
                    : const BoxConstraints(
                        minHeight: commonInputHeight,
                        minWidth: 35,
                      ),
                prefixIcon: widget.prefixIcon ?? const SizedBox(width: 16),
                border: OutlineInputBorder(
                  gapPadding: 1,
                  borderRadius: BorderRadius.circular(0),
                  borderSide: BorderSide(
                    color: widget.inactiveBorderColor ?? colors.strokePrimary,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  gapPadding: 1,
                  borderRadius: BorderRadius.circular(0),
                  borderSide: BorderSide(
                    color: widget.inactiveBorderColor ?? colors.strokePrimary,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  gapPadding: 1,
                  borderRadius: BorderRadius.circular(0),
                  borderSide: BorderSide(
                    color: colors.strokeContrast,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  gapPadding: 1,
                  borderRadius: BorderRadius.circular(0),
                  borderSide: BorderSide(
                    color: widget.errorColor ?? colors.alert,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  gapPadding: 1,
                  borderRadius: BorderRadius.circular(0),
                  borderSide: BorderSide(
                    color: widget.errorColor ?? colors.alert,
                  ),
                ),
              ),
            ),
            suggestionsCallback: suggestionsCallback,
            itemBuilder: itemBuilder,
            suggestionsBoxDecoration: SuggestionsBoxDecoration(
              color: widget.suggestionBackground ?? Colors.transparent,
            ),
            onSuggestionSelected: onSuggestionSelected,
          ),
        );
      }
    }

    if (widget.validator == null) return child;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        child,
        if (state.errorText != null && state.errorText!.isNotEmpty) ...[
          const SizedBox(height: 4),
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
        builder: _onBuild,
      );

  Widget _buildSuffixIcon() {
    if (widget.suffixIcon != null) return widget.suffixIcon!;
    if (widget.needClearButton && !isEmpty) {
      return _buildClearIcon();
    }

    return const SizedBox.shrink();
  }

  Widget _buildClearIcon() {
    return Container(
      constraints: const BoxConstraints(maxHeight: 30, maxWidth: 38),
      margin: const EdgeInsets.only(left: 8),
      alignment: Alignment.center,
      child: CommonIconButton.icon(
        buttonType: EverButtonType.ghost,
        icon: Icons.clear_rounded,
        onPressed: _clearText,
        outerPadding: EdgeInsets.zero,
        color: widget.textStyle?.color,
      ),
    );
  }

  void _clearText() {
    widget.onClearField?.call();
    widget.focusNode?.unfocus();
    _controller.clear();
  }
}
