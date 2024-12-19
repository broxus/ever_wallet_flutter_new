import 'package:app/app/service/connection/data/connection_data/connection_data.dart';
import 'package:app/feature/browser/approvals_listener/actions/change_network/change_network_wm.dart';
import 'package:app/feature/browser/approvals_listener/actions/widgets/widgets.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class ChangeNetworkWidget extends ElementaryWidget<ChangeNetworkWidgetModel> {
  const ChangeNetworkWidget({
    required this.origin,
    required this.networkId,
    required this.connections,
    required this.scrollController,
    Key? key,
    WidgetModelFactory wmFactory = defaultChangeNetworkWidgetModelFactory,
  }) : super(wmFactory, key: key);

  final Uri origin;
  final int networkId;
  final List<ConnectionData> connections;
  final ScrollController scrollController;

  @override
  Widget build(ChangeNetworkWidgetModel wm) {
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
                if (connections.length > 1)
                  ValueListenableBuilder(
                    valueListenable: wm.connection,
                    builder: (_, value, __) =>
                        CommonSelectDropdown<ConnectionData>(
                      values: [
                        for (final connection in connections)
                          CommonSheetDropdownItem<ConnectionData>(
                            value: connection,
                            title: connection.name,
                          ),
                      ],
                      titleText: LocaleKeys.networkWord.tr(),
                      currentValue: value,
                      onChanged: wm.onConnectionChanged,
                    ),
                  ),
                ValueListenableBuilder(
                  valueListenable: wm.connection,
                  builder: (_, connection, __) => PrimaryCard(
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
                      children: [
                        _Param(
                          label: LocaleKeys.networkId.tr(),
                          value: networkId.toString(),
                        ),
                        _Param(
                          label: LocaleKeys.networkName.tr(),
                          value: connection.name,
                        ),
                        _Param(
                          label: LocaleKeys.networkType.tr(),
                          value: connection.networkType,
                        ),
                      ],
                    ),
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
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

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
