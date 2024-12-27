import 'package:app/feature/connection_fail/connection_fail_screen_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/dimens.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class ConnectionFailScreen extends ElementaryWidget<ConnectionFailWidgetModel> {
  const ConnectionFailScreen({
    Key? key,
    WidgetModelFactory<ConnectionFailWidgetModel> wmFactory =
        defaultConnectionFailWidgetModelFactory,
  }) : super(
          wmFactory,
          key: key,
        );

  @override
  Widget build(ConnectionFailWidgetModel wm) {
    return Scaffold(
      backgroundColor: wm.colors.background0,
      body: Stack(
        children: [
          Assets.images.bgConnection.image(width: double.infinity),
          SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  LocaleKeys.noRpcConnection.tr(),
                  style: wm.textStyles.headingLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: DimensSize.d8),
                Text(
                  LocaleKeys.tryAgainOrContact.tr(),
                  style: wm.textStyles.paragraphMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: DimensSizeV2.d34,
            left: DimensSizeV2.d16,
            right: DimensSizeV2.d16,
            child: Column(
              children: [
                PrimaryButton(
                  buttonShape: ButtonShape.pill,
                  title: LocaleKeys.tryAgain.tr(),
                  onPressed: wm.onPressedTryAgain,
                ),
                const SizedBox(height: DimensSize.d12),
                PrimaryButton(
                  buttonShape: ButtonShape.pill,
                  title: LocaleKeys.contactUs.tr(),
                  onPressed: wm.onPressedContactUs,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
