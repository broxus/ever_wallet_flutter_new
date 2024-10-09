import 'package:app/feature/splash/splash_screen_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

// Color does not depend on the theme
const _splashColor = Color(0xFF11142B);

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
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: _splashColor,
      ),
      child: Center(
        child: wm.isIos ? const _IosLogo() : const _AndroidLogo(),
      ),
    );
  }
}

class _AndroidLogo extends StatelessWidget {
  const _AndroidLogo();

  @override
  Widget build(BuildContext context) {
    return Assets.splash.icSplashLogo.image(
      width: 240,
      height: 240,
    );
  }
}

class _IosLogo extends StatelessWidget {
  const _IosLogo();

  @override
  Widget build(BuildContext context) {
    return Assets.splash.icSplashBanner.image(
      width: 247,
      height: 72,
    );
  }
}
