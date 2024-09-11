import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class ButtonsEditSection extends StatelessWidget {
  const ButtonsEditSection({
    required this.isEditing,
    required this.editText,
    required this.clearText,
    required this.doneText,
    required this.onPressedEdit,
    required this.onPressedClear,
    required this.onPressedDone,
    super.key,
  });

  final bool isEditing;
  final String editText;
  final String clearText;
  final String doneText;
  final VoidCallback onPressedEdit;
  final VoidCallback onPressedClear;
  final VoidCallback onPressedDone;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.themeStyleV2.colors.background0,
      ),
      padding: const EdgeInsets.only(
        top: DimensSizeV2.d12,
        bottom: DimensSizeV2.d50,
        left: DimensSizeV2.d16,
        right: DimensSizeV2.d16,
      ),
      child: isEditing
          ? Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DestructiveButton(
                  buttonShape: ButtonShape.pill,
                  title: clearText,
                  onPressed: onPressedClear,
                ),
                const SizedBox(height: DimensSizeV2.d8),
                PrimaryButton(
                  buttonShape: ButtonShape.pill,
                  title: doneText,
                  onPressed: onPressedDone,
                ),
              ],
            )
          : PrimaryButton(
              buttonShape: ButtonShape.pill,
              title: editText,
              onPressed: onPressedEdit,
            ),
    );
  }
}
