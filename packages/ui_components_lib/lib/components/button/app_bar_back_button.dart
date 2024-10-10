import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/v2/widgets/buttons/button_shape.dart';
import 'package:ui_components_lib/v2/widgets/buttons/button_size.dart';
import 'package:ui_components_lib/v2/widgets/buttons/float_button.dart';

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({
    required this.onPressed,
    super.key,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatButton(
      buttonShape: ButtonShape.circle,
      icon: LucideIcons.arrowLeft,
      buttonSize: ButtonSize.medium,
      onPressed: onPressed,
    );
  }
}
