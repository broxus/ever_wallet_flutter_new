import 'package:app/feature/no_internet/no_internet_screen_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/dimens.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class NoInternetScreen extends ElementaryWidget<NoInternetScreenWidgetModel> {
  const NoInternetScreen({
    Key? key,
    WidgetModelFactory<NoInternetScreenWidgetModel> wmFactory =
        defaultNoInternetScreenWidgetModelFactory,
  }) : super(
          wmFactory,
          key: key,
        );

  @override
  Widget build(NoInternetScreenWidgetModel wm) {
    return Scaffold(
      backgroundColor: wm.colors.background0,
      body: Stack(
        children: [
          Assets.images.bgInternet.image(width: double.infinity),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                LocaleKeys.oopsNoInternet.tr(),
                style: wm.textStyles.headingLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: DimensSize.d8),
              Text(
                LocaleKeys.offlineCheckConnection.tr(),
                style: wm.textStyles.paragraphMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Positioned(
            bottom: DimensSizeV2.d34,
            left: DimensSizeV2.d16,
            right: DimensSizeV2.d16,
            child: PrimaryButton(
              buttonShape: ButtonShape.pill,
              title: LocaleKeys.tryAgain.tr(),
              onPressed: wm.onPressedTryAgain,
            ),
          ),
        ],
      ),
    );
  }
}
