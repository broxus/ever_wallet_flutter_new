import 'package:app/generated/generated.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/wallet_prepare_transfer_page/data/wallet_prepare_transfer_asset.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/token_wallet_asset/token_wallet_icon.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class WalletPrepareTransferAssetSelect extends StatelessWidget {
  const WalletPrepareTransferAssetSelect({
    required this.values,
    required this.currentValue,
    required this.onChanged,
    super.key,
  });

  final List<WalletPrepareTransferAsset> values;

  final WalletPrepareTransferAsset? currentValue;

  final ValueChanged<WalletPrepareTransferAsset> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return PressScaleWidget(
      onPressed: values.length == 1 ? null : () => _openSelectSheet(context),
      child: SeparatedRow(
        children: [
          if (currentValue != null) ...[
            TokenWalletIconWidget(
              size: DimensSizeV2.d20,
              address: currentValue!.rootTokenContract,
              logoURI: currentValue!.logoURI,
              version: currentValue!.version ?? TokenWalletVersion.tip3,
            ),
            Flexible(
              child: Text(
                currentValue!.title,
                style: theme.textStyles.labelMedium,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                maxLines: 1,
              ),
            ),
          ],
          Icon(
            LucideIcons.chevronDown,
            color: theme.colors.content0,
            size: DimensSizeV2.d16,
          ),
        ],
      ),
    );
  }

  Widget _itemBuilder(
    WalletPrepareTransferAsset asset, {
    bool isSelected = false,
    VoidCallback? onPressed,
  }) =>
      Builder(
        builder: (context) {
          final colors = context.themeStyle.colors;

          return CommonListTile(
            leading: TokenWalletIconWidget(
              address: asset.rootTokenContract,
              logoURI: asset.logoURI,
              // tip3 for native
              version: asset.version ?? TokenWalletVersion.tip3,
            ),
            padding: EdgeInsets.zero,
            onPressed: onPressed,
            titleText: asset.title,
            trailing: isSelected
                ? Icon(Icons.check_rounded, color: colors.textPrimary)
                : null,
          );
        },
      );

  void _openSelectSheet(BuildContext context) {
    showCommonBottomSheet<void>(
      context: context,
      title: LocaleKeys.selectToken.tr(),
      body: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.only(top: DimensSize.d16),
          child: SeparatedColumn(
            separator: const Padding(
              padding: EdgeInsets.symmetric(vertical: DimensSize.d12),
              child: CommonDivider(),
            ),
            children: values
                .map(
                  (asset) => _itemBuilder(
                    asset,
                    isSelected: asset == currentValue,
                    onPressed: () {
                      Navigator.of(context).pop();
                      onChanged(asset);
                    },
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
