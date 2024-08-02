import 'package:app/data/models/network_type.dart';
import 'package:app/generated/generated.dart';
import 'package:app/v2/feature/choose_network/choose_network_screen_wm.dart';
import 'package:app/v2/feature/choose_network/widgets/choose_network_item.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

typedef SuccessCallback = void Function();

/// Network selection screen
class ChooseNetworkScreen
    extends ElementaryWidget<ChooseNetworkScreenWidgetModel> {
  const ChooseNetworkScreen({
    Key? key,
    this.onSuccess,
    WidgetModelFactory<ChooseNetworkScreenWidgetModel> wmFactory =
        defaultChooseNetworkScreenWidgetModelFactory,
  }) : super(
          wmFactory,
          key: key,
        );

  final SuccessCallback? onSuccess;

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
                  const SizedBox(height: DimensSize.d8),
                  PrimaryText(
                    LocaleKeys.selectNetworkNewWalletDescription.tr(),
                  ),
                  const SizedBox(height: DimensSize.d32),
                  StateNotifierBuilder<List<NetworkType>>(
                    listenableState: wm.connectionsState,
                    builder: (_, List<NetworkType>? items) {
                      if (items == null) {
                        return const SizedBox.shrink();
                      }

                      return Column(
                        children: [
                          for (final networkType in items)
                            ChooseNetworkItem(
                              networkType: networkType,
                              onPressed: wm.onPressedType,
                            ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: DimensSize.d22),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
