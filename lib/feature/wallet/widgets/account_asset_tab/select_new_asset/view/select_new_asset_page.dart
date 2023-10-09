import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/select_new_asset/select_new_asset.dart';
import 'package:app/feature/widgets/change_notifier_listener.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Entry point to screen where user can add new asset(contract) to account with
/// [address].
/// User can add existed asset or custom.
class SelectNewAssetPage extends StatefulWidget {
  const SelectNewAssetPage({
    required this.address,
    super.key,
  });

  final Address address;

  @override
  State<SelectNewAssetPage> createState() => _SelectNewAssetPageState();
}

class _SelectNewAssetPageState extends State<SelectNewAssetPage> {
  final focus = FocusNode();

  @override
  void dispose() {
    focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: DefaultAppBar(
          titleText: LocaleKeys.selectNewAssets.tr(),
        ),
        body: BlocProvider<SelectNewAssetCubit>(
          create: (_) => SelectNewAssetCubit(
            address: widget.address,
            assetsService: inject<AssetsService>(),
            nekotonRepository: inject<NekotonRepository>(),
          ),
          child: BlocBuilder<SelectNewAssetCubit, SelectNewAssetState>(
            builder: (context, state) {
              final contracts = state.contracts;

              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: DimensSize.d16,
                  vertical: DimensSize.d12,
                ),
                child: SeparatedColumn(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ChangeNotifierListener(
                      changeNotifier: focus,
                      builder: (context) {
                        final hasFocus = focus.hasFocus;

                        if (hasFocus) return const SizedBox.shrink();

                        return CommonTabSwitcher<SelectNewAssetTabs>(
                          onTabChanged:
                              context.read<SelectNewAssetCubit>().changeTab,
                          values: [
                            CommonTabSwitcherItem(
                              title: LocaleKeys.searchWord.tr(),
                              value: SelectNewAssetTabs.select,
                            ),
                            CommonTabSwitcherItem(
                              title: LocaleKeys.customToken.tr(),
                              value: SelectNewAssetTabs.custom,
                            ),
                          ],
                          currentValue: state.tab,
                        );
                      },
                    ),
                    Expanded(
                      child: switch (state.tab) {
                        SelectNewAssetTabs.select => SelectNewAssetSelectTab(
                            focus: focus,
                            assetsToCreate: contracts?.$1 ?? [],
                            createdAssets: contracts?.$2 ?? [],
                          ),
                        SelectNewAssetTabs.custom =>
                          SelectNewAssetCustomEnter(focus: focus),
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
