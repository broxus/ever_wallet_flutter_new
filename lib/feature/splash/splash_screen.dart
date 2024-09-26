import 'package:app/feature/splash/splash_screen_wm.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

class SplashScreen extends ElementaryWidget<SplashScreenWidgetModel> {
  const SplashScreen({
    Key? key,
    WidgetModelFactory<SplashScreenWidgetModel> wmFactory =
        defaultSplashScreenWidgetModelFactory,
  }) : super(
          wmFactory,
          key: key,
        );

  @override
  Widget build(SplashScreenWidgetModel wm) {
    return const Placeholder();
  }
}
