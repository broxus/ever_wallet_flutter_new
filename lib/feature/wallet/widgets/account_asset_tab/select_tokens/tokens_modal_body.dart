// ignore_for_file: inference_failure_on_function_return_type
import 'package:app/feature/wallet/widgets/account_asset_tab/select_tokens/token_data_element.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/token_wallet_asset/token_wallet_icon.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class TokensModalBody extends StatelessWidget {
  const TokensModalBody({
    required this.assets,
    required this.onChecked,
    required this.isAllSelected,
    required this.onClickAll,
    required this.isLoading,
    required this.onClickImport,
    super.key,
  });

  final List<TokenDataElement> assets;
  final Function(TokenDataElement) onChecked;
  final VoidCallback onClickAll;
  final bool isAllSelected;
  final bool isLoading;
  final VoidCallback onClickImport;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    final isButtonEnabled =
        (isAllSelected || assets.any((e) => e.isSelected)) && !isLoading;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onClickAll,
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              isAllSelected
                  ? LocaleKeys.hideAll.tr()
                  : LocaleKeys.selectAll.tr(),
              style: theme.textStyles.labelSmall,
              textAlign: TextAlign.right,
            ),
          ),
        ),
        const SizedBox(height: DimensSizeV2.d8),
        SeparatedColumn(
          mainAxisSize: MainAxisSize.min,
          separatorSize: DimensSizeV2.d12,
          children: assets
              .map(
                (value) => _TokenItem(
                  tokenDataElement: value,
                  onChecked: onChecked,
                ),
              )
              .toList(),
        ),
        if (isLoading)
          const Padding(
            padding: EdgeInsets.only(top: DimensSizeV2.d16),
            child: ProgressIndicatorWidget(size: DimensSizeV2.d40),
          ),
        const SizedBox(height: DimensSizeV2.d24),
        AccentButton(
          buttonShape: ButtonShape.pill,
          title: LocaleKeys.importWalletButtonText.tr(),
          onPressed: isButtonEnabled ? onClickImport : null,
        ),
        const SizedBox(height: DimensSizeV2.d8),
      ],
    );
  }
}

class _TokenItem extends StatelessWidget {
  const _TokenItem({
    required this.tokenDataElement,
    required this.onChecked,
  });

  final TokenDataElement tokenDataElement;
  final Function(TokenDataElement) onChecked;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return SeparatedRow(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: DimensSize.d4),
          child: TokenWalletIconWidget(
            logoURI: tokenDataElement.asset.logoURI,
            address: tokenDataElement.asset.address,
            version: tokenDataElement.asset.version,
          ),
        ),
        Expanded(
          child: SeparatedColumn(
            separatorSize: DimensSizeV2.d4,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (tokenDataElement.value != null)
                AmountWidget.fromMoney(
                  amount: tokenDataElement.value!,
                  includeSymbol: false,
                  style: theme.textStyles.labelSmall,
                ),
              Text(
                tokenDataElement.asset.name,
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
        CommonCheckboxInput(
          checked: tokenDataElement.isSelected,
          onChanged: (v) {
            onChecked(tokenDataElement.copyWith(isSelected: v));
          },
        ),
      ],
    );
  }
}
