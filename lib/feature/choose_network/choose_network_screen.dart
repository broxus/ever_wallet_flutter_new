import 'package:app/feature/choose_network/choose_network_screen_wm.dart';
import 'package:app/feature/choose_network/data/choose_network_item_data.dart';
import 'package:app/feature/choose_network/widgets/choose_network_item.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

const chooseNetworkScreenNextStepQuery = 'chooseNetworkNextStep';

/// Network selection screen
class ChooseNetworkScreen
    extends ElementaryWidget<ChooseNetworkScreenWidgetModel> {
  const ChooseNetworkScreen({
    Key? key,
    this.nextStep,
    WidgetModelFactory<ChooseNetworkScreenWidgetModel> wmFactory =
        defaultChooseNetworkScreenWidgetModelFactory,
  }) : super(
          wmFactory,
          key: key,
        );

  final String? nextStep;

  @override
  Widget build(ChooseNetworkScreenWidgetModel wm) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: wm.backgroundColor,
      ),
      child: Stack(
        children: [
          Assets.images.networkEarth.image(width: double.infinity),
          SizedBox(
            height: wm.windowHeight,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: const DefaultAppBar(
                systemOverlayStyle: SystemUiOverlayStyle.light,
              ),
              body: Column(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PrimaryText(
                    LocaleKeys.chooseNetwork.tr(),
                    type: PrimaryTextType.titleLarge,
                  ), //Choose a network
                  SizedBox(height: DimensAdaptiveSize.d8.hp),
                  PrimaryText(
                    LocaleKeys.selectNetworkNewWalletDescription.tr(),
                  ),
                  SizedBox(height: DimensAdaptiveSize.d32.hp),
                  StateNotifierBuilder<List<ChooseNetworkItemData>>(
                    listenableState: wm.connectionsState,
                    builder: (_, List<ChooseNetworkItemData>? items) {
                      if (items == null) {
                        return const SizedBox.shrink();
                      }

                      return Column(
                        children: [
                          for (final item in items)
                            ChooseNetworkItem(
                              item,
                              onPressed: wm.onPressedType,
                            ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: DimensAdaptiveSize.d22.hp),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
