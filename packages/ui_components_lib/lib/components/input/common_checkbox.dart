import 'package:flutter/material.dart';
import 'package:ui_components_lib/res/images.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/dimens_v2.dart';

/// {@template common_checkbox_input}
///
/// Widget that displays checkbox state, that could be check or not.
/// This input can be validated by form.
///
/// {@endtemplate}
class CommonCheckboxInput extends StatefulWidget {
  /// {@macro common_checkbox_input}
  const CommonCheckboxInput({
    required this.checked,
    this.onChanged,
    this.validateMode,
    this.validator,
    super.key,
  });

  /// Callback that calls when user taps checkbox
  final ValueChanged<bool>? onChanged;

  /// Current state of checkbox
  final bool checked;

  /// How field must be validated
  final AutovalidateMode? validateMode;

  /// If not null, then input will be validated by form
  final FormFieldValidator<bool>? validator;

  @override
  State<CommonCheckboxInput> createState() => _CommonCheckboxInputState();
}

class _CommonCheckboxInputState extends State<CommonCheckboxInput> {
  FormFieldState<bool>? field;

  void _handleDidChange(bool v) {
    if (!mounted) return;
    field?.didChange(v);
  }

  Widget _onBuild(FormFieldState<bool> state) {
    final colors = context.themeStyle.colors;
    field = state;

    return GestureDetector(
      onTap: () {
        _handleDidChange(!widget.checked);
        widget.onChanged?.call(!widget.checked);
      },
      child: CommonCheckbox(
        checked: widget.checked,
        color: field?.hasError ?? false
            ? colors.alert
            : widget.onChanged == null
                ? colors.textSecondary
                : widget.checked
                    ? colors.textPrimary
                    : colors.strokePrimary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormField<bool>(
      validator: widget.validator,
      initialValue: widget.checked,
      autovalidateMode: widget.validateMode,
      builder: _onBuild,
    );
  }
}

/// {@template common_checkbox}
///
/// Widget that displays only checkbox state, without actions.
/// To add actions use [CommonCheckboxInput].
///
/// {@endtemplate}
class CommonCheckbox extends StatelessWidget {
  /// {@macro common_checkbox}
  const CommonCheckbox({
    required this.checked,
    required this.color,
    super.key,
  });

  /// Current state of checkbox
  final bool checked;

  /// Color of background/stroke
  final Color color;

  @override
  Widget build(BuildContext context) {
    return checked
        ? CommonIconWidget.svg(
            svg: AssetsImages.checkedUri,
            size: DimensSizeV2.d20,
          )
        : SizedBox(
            width: DimensSizeV2.d20,
            height: DimensSizeV2.d20,
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(
                  color: context.themeStyleV2.colors.borderAlpha,
                ),
                borderRadius: BorderRadius.circular(
                  DimensRadiusV2.radius6,
                ),
              ),
            ),
          );
  }
}
