import 'dart:convert';

import 'package:app/feature/browser/approvals_listener/actions/add_network/add_network_wm.dart';
import 'package:app/feature/browser/approvals_listener/actions/widgets/widgets.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_webview/nekoton_webview.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

const _encoder = JsonEncoder.withIndent('  ');

class AddNetworkWidget extends ElementaryWidget<AddNetworkWidgetModel> {
  const AddNetworkWidget({
    required this.origin,
    required this.network,
    required this.switchNetwork,
    required this.scrollController,
    Key? key,
    WidgetModelFactory wmFactory = defaultAddNetworkWidgetModelFactory,
  }) : super(wmFactory, key: key);

  final Uri origin;
  final AddNetwork network;
  final bool switchNetwork;
  final ScrollController scrollController;

  @override
  Widget build(AddNetworkWidgetModel wm) {
    final theme = wm.theme;

    return SeparatedColumn(
      separatorSize: DimensSizeV2.d12,
      children: [
        Expanded(
          child: SingleChildScrollView(
            controller: scrollController,
            child: SeparatedColumn(
              separatorSize: DimensSizeV2.d12,
              children: [
                WebsiteInfoWidget(uri: origin),
                PrimaryCard(
                  color: theme.colors.background2,
                  borderRadius: BorderRadius.circular(
                    DimensRadiusV2.radius12,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: DimensSizeV2.d24,
                    horizontal: DimensSizeV2.d16,
                  ),
                  child: SeparatedColumn(
                    separatorSize: DimensSizeV2.d16,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _Param(
                        label: LocaleKeys.networkId.tr(),
                        value: network.networkId.toString(),
                      ),
                      _Param(
                        label: LocaleKeys.networkName.tr(),
                        value: network.name,
                      ),
                      _Param(
                        label: LocaleKeys.connectionData.tr(),
                        value: _encoder.convert(network.connection),
                        isColumn: true,
                      ),
                      if (network.config != null)
                        _Param(
                          label: LocaleKeys.networkConfig.tr(),
                          value: _encoder.convert(network.config),
                          isColumn: true,
                        ),
                    ],
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: wm.switchNetwork,
                  builder: (_, value, __) => Row(
                    children: [
                      Expanded(
                        child: Text(
                          LocaleKeys.networkAddedSheetSwitch.tr(),
                          style: StyleRes.secondaryBold,
                        ),
                      ),
                      Switch(value: value, onChanged: wm.onSwitchChanged),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        ValueListenableBuilder(
          valueListenable: wm.loading,
          builder: (_, loading, __) => AccentButton(
            buttonShape: ButtonShape.pill,
            title: LocaleKeys.confirm.tr(),
            isLoading: loading,
            onPressed: wm.onConfirm,
          ),
        ),
      ],
    );
  }
}

class _Param extends StatelessWidget {
  const _Param({
    required this.label,
    required this.value,
    this.isColumn = false,
  });

  final String label;
  final String value;
  final bool isColumn;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    if (isColumn) {
      return SeparatedColumn(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            label,
            style: theme.textStyles.paragraphSmall.copyWith(
              color: theme.colors.content3,
            ),
          ),
          PrimaryCard(
            color: theme.colors.background3,
            borderRadius: BorderRadius.circular(DimensRadiusV2.radius8),
            child: Text(value, style: theme.textStyles.paragraphSmall),
          ),
        ],
      );
    }

    return SeparatedRow(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textStyles.paragraphSmall.copyWith(
            color: theme.colors.content3,
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: theme.textStyles.paragraphSmall,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
