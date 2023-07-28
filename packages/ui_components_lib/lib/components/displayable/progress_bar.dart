import 'package:flutter/material.dart';
import 'package:ui_components_lib/theme_style.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({this.value, super.key});

  final double? value;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    return LinearProgressIndicator(
      value: value,
      color: colors.blue,
      backgroundColor: Colors.transparent,
    );
  }
}
