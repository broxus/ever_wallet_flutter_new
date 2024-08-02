import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/v2/widgets/buttons/button.dart';

class IconEyeWidget extends StatelessWidget {
  const IconEyeWidget({
    required this.onPressed,
    required this.isTurnedOn,
    super.key,
  });

  final VoidCallback onPressed;
  final bool isTurnedOn;

  @override
  Widget build(BuildContext context) {
    return GhostButton(
      buttonShape: ButtonShape.square,
      icon: isTurnedOn ? LucideIcons.eye : LucideIcons.eyeOff,
      onPressed: onPressed,
    );
  }
}
