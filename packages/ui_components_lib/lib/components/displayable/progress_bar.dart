import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({this.value, super.key});

  final double? value;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    return TweenAnimationBuilder(
      duration: defaultAnimationDuration,
      curve: Curves.easeInOut,
      tween: Tween<double>(
        begin: 0,
        end: value ?? 0,
      ),
      builder: (BuildContext context, double value, _) =>
          LinearProgressIndicator(
        value: value,
        color: colors.blue,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
