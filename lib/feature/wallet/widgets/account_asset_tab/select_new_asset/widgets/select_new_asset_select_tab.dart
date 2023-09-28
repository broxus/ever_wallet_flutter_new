import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/select_new_asset/select_new_asset.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/token_wallet_asset/token_wallet_icon.dart';
import 'package:app/generated/generated.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Widget that allows user select asset(contract) from list of loaded assets.
class SelectNewAssetSelectTab extends StatefulWidget {
  const SelectNewAssetSelectTab({
    required this.createdAssets,
    required this.assetsToCreate,
    required this.focus,
    super.key,
  });

  final List<TokenContractAsset> createdAssets;
  final List<TokenContractAsset> assetsToCreate;
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
    final manifestAssets =
        inject<AssetsService>().currentSystemTokenContractAssets;
    final mappedAssets = Map.fromEntries(
      manifestAssets.mapIndexed(
        (index, contract) => MapEntry(contract.address, index),
      ),
    );
    final assetsWidgets = [
      ...widget.createdAssets
          .map((e) => SelectNewAssetItem(asset: e, isSelected: true)),
      ...widget.assetsToCreate.map((e) => SelectNewAssetItem(asset: e)),
    ]..sort((a, b) {
        final aIndex = mappedAssets[a.asset.address];
        final bIndex = mappedAssets[b.asset.address];

        // if index is null (asset is custom), move to the end
        if (aIndex == null) return 1;
        if (bIndex == null) return -1;

        // sort according to manifest list
        return aIndex.compareTo(bIndex);
      });

    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: searchController,
      builder: (context, value, _) {
        final found =
            assetsWidgets.where((e) => _assetSearchValidation(e.asset));

        return SingleChildScrollView(
          child: SeparatedColumn(
            children: [
              CommonInput(
                controller: searchController,
                prefixIconConstraints: BoxConstraints.loose(
                  const Size(DimensSize.d40, DimensSize.d20),
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(
                    left: DimensSize.d12,
                    right: DimensSize.d8,
                  ),
                  child: SvgPicture.asset(
                    Assets.images.search.path,
                    width: DimensSize.d20,
                    height: DimensSize.d20,
                  ),
                ),
              ),
              if (found.isEmpty) _emptyBody() else ...found,
            ],
          ),
        );
      },
    );
  }

  Widget _emptyBody() {
    return Builder(
      builder: (context) {
        final colors = context.themeStyle.colors;

        return Padding(
          padding: const EdgeInsets.all(DimensSize.d20),
          child: SeparatedColumn(
            separatorSize: DimensSize.d12,
            children: [
              SvgPicture.asset(Assets.images.searchEmpty.path),
              Text(
                LocaleKeys.sorryNoAssetsFound.tr(),
                style: StyleRes.primaryRegular.copyWith(
                  color: colors.textSecondary,
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
    return CommonListTile(
      height: DimensSize.d68,
      leading: TokenWalletIconWidget(
        logoURI: asset.logoURI,
        address: asset.address,
        version: asset.version,
      ),
      titleText: asset.symbol,
      subtitleText: asset.name,
      trailing: CommonSwitchInput(
        value: isSelected,
        onChanged: (v) {
          if (v) {
            context.read<SelectNewAssetCubit>().enableAsset(asset.address);
          } else {
            context.read<SelectNewAssetCubit>().disableAsset(asset.address);
          }
        },
      ),
    );
  }
}
