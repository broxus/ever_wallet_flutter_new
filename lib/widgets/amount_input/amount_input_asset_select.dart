import 'package:app/feature/wallet/widgets/account_asset_tab/token_wallet_asset/token_wallet_icon.dart';
import 'package:app/generated/generated.dart';
import 'package:app/widgets/amount_input/amount_input_asset.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class AmountInputAssetSelect extends StatelessWidget {
  const AmountInputAssetSelect({
    required this.currentValue,
    this.values,
    this.onChanged,
    super.key,
  });

  final ValueListenable<List<AmountInputAsset>>? values;

  final AmountInputAsset? currentValue;

  final ValueChanged<AmountInputAsset>? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return PressScaleWidget(
      onPressed: values != null ? () => _openSelectSheet(context) : null,
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
    AmountInputAsset asset, {
    bool isSelected = false,
    VoidCallback? onPressed,
  }) =>
      Builder(
        builder: (context) {
          final theme = context.themeStyleV2;

          return GestureDetector(
            onTap: onPressed,
            behavior: HitTestBehavior.translucent,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: DimensSizeV2.d8),
              child: SeparatedRow(
                children: [
                  TokenWalletIconWidget(
                    address: asset.rootTokenContract,
                    logoURI: asset.logoURI,
                    // tip3 for native
                    version: asset.version ?? TokenWalletVersion.tip3,
                  ),
                  Expanded(
                    child: SeparatedColumn(
                      separatorSize: DimensSizeV2.d4,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AmountWidget.fromMoney(
                          amount: asset.balance,
                          style: theme.textStyles.labelSmall,
                          useDefaultFormat: true,
                        ),
                        Text(
                          asset.title,
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
                  if (isSelected)
                    const Icon(LucideIcons.check, size: DimensSizeV2.d20),
                ],
              ),
            ),
          );
        },
      );

  void _openSelectSheet(BuildContext context) {
    showCommonBottomSheet<void>(
      context: context,
      title: LocaleKeys.selectToken.tr(),
      centerTitle: true,
      body: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.only(top: DimensSizeV2.d16),
          child: ValueListenableBuilder(
            valueListenable: values!,
            builder: (_, values, __) => SeparatedColumn(
              separatorSize: DimensSizeV2.d12,
              children: values
                  .map(
                    (asset) => _itemBuilder(
                      asset,
                      isSelected: asset == currentValue,
                      onPressed: () {
                        Navigator.of(context).pop();
                        onChanged?.call(asset);
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
