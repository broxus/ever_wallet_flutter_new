import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// {@template common_radio_input}
///
/// Widget that displays radio element and able to make callback on it.
/// Radio also can be validated.
///
/// {@endtemplate}
class CommonRadioInput<T> extends StatefulWidget {
  /// {@macro common_radio_input}
  const CommonRadioInput({
    required this.value,
    required this.groupValue,
    this.onChanged,
    this.validateMode,
    this.validator,
    super.key,
  });

  /// Value of this radio element.
  final T value;

  /// Selected value of the group.
  final T? groupValue;

  /// Callback that calls when user taps radio element
  final ValueChanged<T>? onChanged;

  /// How field must be validated
  final AutovalidateMode? validateMode;

  /// If not null, then input will be validated by form
  final FormFieldValidator<T>? validator;

  @override
  State<CommonRadioInput<T>> createState() => _CommonRadioInputState();
}

class _CommonRadioInputState<T> extends State<CommonRadioInput<T>> {
  FormFieldState<T>? field;

  void _handleDidChange(T v) {
    if (!mounted) return;
    field?.didChange(v);
  }

  Widget _onBuild(FormFieldState<T> state) {
    field = state;

    return GestureDetector(
      onTap: widget.onChanged == null
          ? null
          : () {
              _handleDidChange(widget.value);
              widget.onChanged!(widget.value);
            },
      child: CommonRadio<T>(
        value: widget.value,
        groupValue: widget.groupValue,
        enabled: widget.onChanged != null,
        hasError: field?.hasError ?? false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      validator: widget.validator,
      initialValue: widget.value,
      autovalidateMode: widget.validateMode,
      builder: _onBuild,
    );
  }
}

/// {@template common_radio}
///
/// Widget that displays a radio element where only one value of a group can be
/// selected.
///
/// {@endtemplate}
class CommonRadio<T> extends StatelessWidget {
  /// {@macro common_radio}
  const CommonRadio({
    required this.value,
    required this.groupValue,
    required this.enabled,
    this.hasError = false,
    super.key,
  });

  /// Value of this radio element.
  final T value;

  /// Selected value of the group.
  final T? groupValue;

  /// If this radio item should contains colors as it can be pressed.
  final bool enabled;

  /// If this radio item should contains colors of error
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;
    final selected = value == groupValue;

    return Container(
      height: DimensSize.d20,
      width: DimensSize.d20,
      decoration: BoxDecoration(
        border: SquircleBoxBorder(
          squircleRadius: DimensRadius.small,
          borderSide: BorderSide(
            color: hasError
                ? colors.alert
                : enabled
                    ? colors.strokePrimary
                    : colors.strokeSecondary,
          ),
        ),
      ),
      alignment: Alignment.center,
      child: AnimatedContainer(
        duration: kThemeAnimationDuration,
        // 12 too big, 8 too small
        // ignore: no-magic-number
        width: selected ? 10 : 0,
        // ignore: no-magic-number
        height: selected ? 10 : 0,
        child: Material(
          color: enabled ? colors.textPrimary : colors.textSecondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              DimensRadius.xSmall,
            ),
          ),
        ),
      ),
    );
  }
}
