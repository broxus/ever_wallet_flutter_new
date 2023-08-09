import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

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
    return SizedBox(
      width: DimensSize.d20,
      height: DimensSize.d20,
      child: CustomPaint(
        // This is strange to use painter, but we cant import svg's here
        painter: _CheckboxPainter(
          color: color,
          checked: checked,
        ),
      ),
    );
  }
}

class _CheckboxPainter extends CustomPainter {
  _CheckboxPainter({
    required this.checked,
    required this.color,
  });

  final bool checked;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    canvas
      ..saveLayer(Offset.zero & size, Paint())
      ..drawRRect(
        ui.RRect.fromLTRBR(
          0,
          0,
          width,
          height,
          const Radius.circular(DimensRadius.small),
        ),
        Paint()
          ..color = color
          ..style = checked ? PaintingStyle.fill : PaintingStyle.stroke,
      );
    if (checked) {
      final checkPath = Path()
        ..moveTo(width * 0.3, height * 0.5)
        ..lineTo(width * 0.45, height * 0.65)
        ..lineTo(width * 0.7, height * 0.35);
      canvas.drawPath(
        checkPath,
        Paint()
          ..style = PaintingStyle.stroke
          ..blendMode = BlendMode.clear
          ..strokeWidth = DimensStroke.medium
          ..strokeJoin = StrokeJoin.round
          ..strokeCap = StrokeCap.round,
      );
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _CheckboxPainter oldDelegate) =>
      oldDelegate.checked != checked || oldDelegate.color != color;
}
