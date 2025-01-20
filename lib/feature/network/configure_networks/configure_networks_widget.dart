import 'package:app/feature/network/network.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class ConfigureNetworksWidget
    extends ElementaryWidget<ConfigureNetworksWidgetModel> {
  const ConfigureNetworksWidget({
    Key? key,
    WidgetModelFactory wmFactory = defaultConfigureNetworksWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(ConfigureNetworksWidgetModel wm) {
    return SeparatedColumn(
      separatorSize: DimensSizeV2.d16,
      children: [
        StateNotifierBuilder(
          listenableState: wm.connections,
          builder: (_, connections) => Flexible(
            child: ListView.separated(
              itemCount: connections?.length ?? 0,
              itemBuilder: (_, index) {
                final item = connections?[index];
                return item?.let(
                  (data) => NetworkItem(
                    padding: const EdgeInsets.symmetric(
                      vertical: DimensSizeV2.d8,
                    ),
                    data: data,
                    trailing: const Icon(
                      LucideIcons.chevronRight,
                      size: DimensSizeV2.d20,
                    ),
                    onTap: () => wm.onItemTap(data),
                  ),
                );
              },
              separatorBuilder: (_, __) =>
                  const SizedBox(height: DimensSizeV2.d16),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: DimensSizeV2.d12),
          child: AccentButton(
            buttonShape: ButtonShape.pill,
            title: LocaleKeys.addCustomNetwork.tr(),
            onPressed: wm.onAddNetwork,
          ),
        ),
      ],
    );
  }
}
