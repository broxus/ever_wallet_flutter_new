import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// {@template common_switch_input}
/// Default switcher for application that can display enabled or disabled state.
/// This is a wrapper widget above [CommonSwitcher] with tap and validation
/// logic.
/// {@endtemplate}
class CommonSwitchInput extends StatefulWidget {
  /// {@macro common_switch_input}
  const CommonSwitchInput({
    required this.value,
    required this.onChanged,
    super.key,
    this.validator,
    this.validateMode,
    this.thumbChild,
    this.thumbColor,
  });

  /// Current state of switcher enabled/disabled
  final bool value;

  /// Callback when user taps switcher
  final ValueChanged<bool> onChanged;

  /// How field must be validated
  final AutovalidateMode? validateMode;

  /// If not null, then input will be validated by form
  final FormFieldValidator<bool>? validator;

  /// Widget that displays inside of sliding circle. Nothing by default.
  /// It can be icon for example.
  final Widget? thumbChild;

  /// Color of sliding circle, white by default
  final Color? thumbColor;

  @override
  State<CommonSwitchInput> createState() => _CommonSwitchInputState();
}

class _CommonSwitchInputState extends State<CommonSwitchInput> {
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
        _handleDidChange(!widget.value);
        widget.onChanged(!widget.value);
      },
      child: CommonSwitcher(
        value: widget.value,
        backgroundColor: state.hasError
            ? colors.alert
            : widget.value
                ? colors.apply
                : colors.backgroundSecondary,
        thumbColor: widget.thumbColor ?? ColorsRes.white,
        thumbSize: widget.value ? DimensSize.d24 : DimensSize.d16,
        thumbChild: widget.thumbChild,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormField<bool>(
      validator: widget.validator,
      initialValue: widget.value,
      autovalidateMode: widget.validateMode,
      builder: _onBuild,
    );
  }
}

/// {@template common_switcher}
/// Primary widget with switching animation.
/// It's based on [AnimatedContainer].
/// {@endtemplate}
class CommonSwitcher extends StatelessWidget {
  /// {@macro common_switcher}
  const CommonSwitcher({
    required this.value,
    required this.thumbColor,
    required this.backgroundColor,
    required this.thumbSize,
    super.key,
    this.width = DimensSize.d56,
    this.height = DimensSize.d32,
    this.thumbChild,
  });

  /// Current state of switcher
  final bool value;

  /// Color of sliding circle
  final Color thumbColor;

  /// Color of background of switcher
  final Color backgroundColor;

  /// Width of whole sliding field
  final double width;

  /// Height of whole sliding field
  final double height;

  /// Size of sliding circle
  final double thumbSize;

  /// Optional widget that can be displayed inside of sliding circle
  final Widget? thumbChild;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: value
          ? const EdgeInsets.all(DimensSize.d4)
          : const EdgeInsets.all(DimensSize.d8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(DimensRadius.max),
      ),
      child: AnimatedAlign(
        duration: kThemeAnimationDuration,
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        child: AnimatedContainer(
          duration: kThemeAnimationDuration,
          width: thumbSize,
          height: thumbSize,
          decoration: BoxDecoration(
            color: thumbColor,
            shape: BoxShape.circle,
          ),
          child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: thumbChild,
            ),
          ),
        ),
      ),
    );
  }
}
