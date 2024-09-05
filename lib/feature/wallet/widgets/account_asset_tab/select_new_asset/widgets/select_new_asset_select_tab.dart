import 'package:app/data/models/models.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/select_new_asset/select_new_asset.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/token_wallet_asset/token_wallet_icon.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Widget that allows user select asset(contract) from list of loaded assets.
class SelectNewAssetSelectTab extends StatefulWidget {
  const SelectNewAssetSelectTab({
    required this.contracts,
    required this.focus,
    super.key,
  });

  final List<(TokenContractAsset, bool)> contracts;
  final FocusNode focus;

  @override
  State<SelectNewAssetSelectTab> createState() =>
      _SelectNewAssetSelectTabState();
}

class _SelectNewAssetSelectTabState extends State<SelectNewAssetSelectTab> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final assetsWidgets = widget.contracts
        .map((pair) => SelectNewAssetItem(asset: pair.$1, isSelected: pair.$2));

    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: searchController,
      builder: (context, value, _) {
        final found =
            assetsWidgets.where((e) => _assetSearchValidation(e.asset));

        return SingleChildScrollView(
          child: SeparatedColumn(
            separatorSize: DimensSizeV2.d16,
            children: [
              PrimaryTextField(
                hintText: LocaleKeys.enterAssetName.tr(),
                textEditingController: searchController,
                suffixes: [
                  if (value.text.isEmpty)
                    const Padding(
                      padding: EdgeInsets.only(
                        right: DimensSizeV2.d20,
                      ),
                      child: Icon(
                        LucideIcons.search,
                        size: DimensSizeV2.d16,
                      ),
                    ),
                  if (value.text.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(
                        right: DimensSizeV2.d8,
                      ),
                      child: FloatButton(
                        buttonShape: ButtonShape.square,
                        buttonSize: ButtonSize.small,
                        icon: LucideIcons.x,
                        onPressed: searchController.clear,
                      ),
                    ),
                ],
              ),
              if (found.isEmpty)
                _emptyBody()
              else
                SeparatedColumn(
                  mainAxisSize: MainAxisSize.min,
                  separatorSize: DimensSizeV2.d12,
                  children: found.toList(),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _emptyBody() {
    return Builder(
      builder: (context) {
        final theme = context.themeStyleV2;

        return Padding(
          padding: const EdgeInsets.all(DimensSizeV2.d20),
          child: SeparatedColumn(
            separatorSize: DimensSizeV2.d12,
            children: [
              SvgPicture.asset(Assets.images.searchEmpty.path),
              Text(
                LocaleKeys.sorryNoAssetsFound.tr(),
                style: theme.textStyles.headingSmall.copyWith(
                  color: theme.colors.content3,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }

  bool _assetSearchValidation(TokenContractAsset asset) {
    final text = searchController.text.toLowerCase();

    return asset.symbol.toLowerCase().contains(text) ||
        asset.name.toLowerCase().contains(text);
  }
}

class SelectNewAssetItem extends StatelessWidget {
  const SelectNewAssetItem({
    required this.asset,
    this.isSelected = false,
    super.key,
  });

  final TokenContractAsset asset;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: DimensSizeV2.d8),
      child: SeparatedRow(
        children: [
          TokenWalletIconWidget(
            logoURI: asset.logoURI,
            address: asset.address,
            version: asset.version,
          ),
          Expanded(
            child: SeparatedColumn(
              separatorSize: DimensSizeV2.d4,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  asset.symbol,
                  style: theme.textStyles.labelSmall,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  maxLines: 1,
                ),
                Text(
                  asset.name,
                  style: theme.textStyles.labelXSmall.copyWith(
                    color: theme.colors.content3,
                  ),
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          Switch(
            value: isSelected,
            onChanged: (v) {
              if (v) {
                context.read<SelectNewAssetCubit>().enableAsset(asset.address);
              } else {
                context.read<SelectNewAssetCubit>().disableAsset(asset.address);
              }
            },
          ),
        ],
      ),
    );
  }
}
