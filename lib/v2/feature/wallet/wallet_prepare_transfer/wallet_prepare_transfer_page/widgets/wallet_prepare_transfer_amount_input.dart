import 'package:app/generated/generated.dart';
import 'package:app/v2/feature/wallet/wallet_prepare_transfer/wallet_prepare_transfer_page/data/wallet_prepare_transfer_asset.dart';
import 'package:app/v2/feature/wallet/wallet_prepare_transfer/wallet_prepare_transfer_page/widgets/wallet_prepare_transfer_asset_select.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:string_extensions/string_extensions.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class WalletPrepareTransferAmountInput extends StatelessWidget {
  const WalletPrepareTransferAmountInput({
    required this.focusNode,
    required this.controller,
    required this.selectedAsset,
    required this.assets,
    required this.onSelectedAssetChanged,
    required this.onMaxAmount,
    required this.onSubmitted,
    super.key,
  });

  final FocusNode focusNode;

  final TextEditingController controller;

  final List<WalletPrepareTransferAsset>? assets;

  final WalletPrepareTransferAsset? selectedAsset;

  final ValueChanged<WalletPrepareTransferAsset> onSelectedAssetChanged;

  final VoidCallback onMaxAmount;

  final ValueChanged<String> onSubmitted;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    final balance = selectedAsset?.balance.amount.toString() ?? '';

    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        border: Border.all(color: theme.colors.border0),
        borderRadius: BorderRadius.circular(DimensRadiusV2.radius16),
        color: theme.colors.background1,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: DimensSizeV2.d16,
              vertical: DimensSizeV2.d12,
            ),
            child: SeparatedRow(
              separatorSize: DimensSizeV2.d4,
              children: [
                Expanded(
                  child: SeparatedColumn(
                    separatorSize: DimensSizeV2.d4,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WalletPrepareTransferAssetSelect(
                        values: assets ?? [],
                        currentValue: selectedAsset,
                        onChanged: onSelectedAssetChanged,
                      ),
                      Text(
                        LocaleKeys.balance.tr(args: [balance]),
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
                PrimaryButton(
                  title: LocaleKeys.maxWord.tr(),
                  buttonShape: ButtonShape.rectangle,
                  buttonSize: ButtonSize.small,
                  onPressed: onMaxAmount,
                ),
              ],
            ),
          ),
          CommonDivider(color: theme.colors.border0),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: DimensSizeV2.d16,
              vertical: DimensSizeV2.d12,
            ),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: focusNode.requestFocus,
              child: FormField<String>(
                initialValue: controller.text,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: _validator,
                builder: _fieldBuilder,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _fieldBuilder(FormFieldState<String> state) {
    final theme = state.context.themeStyleV2;
    final inputStyle = theme.textStyles.headingLarge.copyWith(
      color:
          state.hasError ? theme.colors.contentNegative : theme.colors.content0,
    );
    final price = Fixed.parse(selectedAsset?.currency?.price ?? '0');
    final amount = Fixed.parse(state.value.nullIf('') ?? '0');
    final usd = Fixed.copyWith(amount * price, scale: 2);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: AutoSizeTextField(
                controller: controller,
                focusNode: focusNode,
                style: inputStyle,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  hintText: '0',
                  hintStyle: inputStyle,
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  if (selectedAsset != null)
                    CurrencyTextInputFormatter(selectedAsset!.balance.currency),
                ],
                fullwidth: false,
                onChanged: state.didChange,
                onSubmitted: onSubmitted,
              ),
            ),
            Text(
              selectedAsset?.tokenSymbol ?? '',
              style: theme.textStyles.headingLarge.copyWith(
                color: theme.colors.content3,
              ),
            ),
          ],
        ),
        if (!state.hasError)
          Text(
            '$usd USD',
            style: theme.textStyles.labelXSmall.copyWith(
              color: theme.colors.content3,
            ),
          ),
        if (state.hasError)
          Text(
            state.errorText!,
            style: theme.textStyles.labelXSmall.copyWith(
              color: theme.colors.contentNegative,
            ),
          ),
      ],
    );
  }

  String? _validator(String? value) => selectedAsset == null
      ? null
      : CurrencyTextInputValidator(
          selectedAsset!.balance.currency,
          emptyError: LocaleKeys.amountIsEmpty.tr(),
          error: LocaleKeys.amountIsWrong.tr(),
          max: selectedAsset!.balance.amount,
          maxError: LocaleKeys.insufficientFunds.tr(),
        ).validate(value);
}
