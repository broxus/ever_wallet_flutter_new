import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Background that is used on main screen of onboarding.
/// It adds gradient behind [child].
/// If [OnboardingBackground] is displayed above [Scaffold], then
/// [Scaffold.backgroundColor] should be transparent to allow gradient to be
/// visible.
class OnboardingBackground extends StatelessWidget {
  const OnboardingBackground({
    required this.child,
    this.otherPositioned,
    this.backgroundColor,
    super.key,
  });

  /// Widget that must be displayed as main content
  final Widget child;

  /// Background of gradient. Default to [ColorsPalette.backgroundPrimary]
  final Color? backgroundColor;

  /// Allow add more elements to screen.
  /// Widgets must be wrapped in Positioned for better positioning
  final List<Widget>? otherPositioned;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: OnboardingGradient(backgroundColor: backgroundColor),
        ),
        ...?otherPositioned,
        Positioned.fill(child: child),
      ],
    );
  }
}

class OnboardingGradient extends StatelessWidget {
  const OnboardingGradient({
    super.key,
    this.backgroundColor,
  });

  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    /// color is used to avoid transparent scaffold when popping with left-swipe
    /// gesture
    final background =
        backgroundColor ?? context.themeStyle.colors.backgroundPrimary;

    return Material(
      color: background,
      child: const Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: -200,
            top: -100,
            width: 500,
            height: 500,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  stops: [0.35, 1],
                  colors: [
                    Color(0x3D0038FF),
                    Color(0x006557FF),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: -150,
            bottom: -50,
            width: 400,
            height: 400,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  stops: [0.4, 1],
                  colors: [
                    Color(0x335200FF),
                    Color(0x00DD57FF),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
