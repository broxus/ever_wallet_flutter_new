import 'package:flutter/material.dart';

/// Builder for [AnimatedColor] widget
typedef ColorWidgetBuilder = Widget Function(BuildContext context, Color color);

/// {@template animated_color}
/// Widget that automatically animate color of content and provide it
/// to [builder].
/// This widget change color from old one to new one.
/// {@endtemplate}
class AnimatedColor extends ImplicitlyAnimatedWidget {
  /// {@macro animated_color}
  const AnimatedColor({
    required this.color,
    required this.builder,
    required super.duration,
    super.key,
  });

  final Color color;
  final ColorWidgetBuilder builder;

  @override
  ImplicitlyAnimatedWidgetState<AnimatedColor> createState() =>
      _AnimatedColorState();
}

class _AnimatedColorState extends AnimatedWidgetBaseState<AnimatedColor> {
  ColorTween? _color;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _color = visitor(
      _color,
      widget.color,
      (dynamic value) => ColorTween(begin: value as Color),
    ) as ColorTween?;
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _color!.evaluate(animation)!);
  }
}
