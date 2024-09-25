import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:app/widgets/amount_input/amount_input_asset.dart';
import 'package:app/widgets/amount_input/amount_input_asset_select.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:string_extensions/string_extensions.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class AmountInput extends StatefulWidget {
  const AmountInput({
    required this.controller,
    required this.selectedAsset,
    required this.onMaxAmount,
    required this.onSubmitted,
    this.focusNode,
    this.assets,
    this.onSelectedAssetChanged,
    super.key,
  });

  final FocusNode? focusNode;
  final TextEditingController controller;
  final ValueListenable<List<AmountInputAsset>>? assets;
  final AmountInputAsset? selectedAsset;
  final ValueChanged<AmountInputAsset>? onSelectedAssetChanged;
  final VoidCallback onMaxAmount;
  final ValueChanged<String> onSubmitted;

  @override
  State<AmountInput> createState() => _AmountInputState();
}

class _AmountInputState extends State<AmountInput> {
  CurrencyTextInputFormatter? formatter;
  CurrencyTextInputValidator? validator;

  @override
  void initState() {
    _updateFormatterValidator();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AmountInput oldWidget) {
    if (oldWidget.selectedAsset != widget.selectedAsset) {
      _updateFormatterValidator();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    final balance = widget.selectedAsset?.balance.amount.toString() ?? '';

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
                      AmountInputAssetSelect(
                        values: widget.assets,
                        currentValue: widget.selectedAsset,
                        onChanged: widget.onSelectedAssetChanged,
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
                  onPressed: widget.onMaxAmount,
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
              onTap: widget.focusNode?.requestFocus,
              child: FormField<String>(
                initialValue: widget.controller.text,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: validator?.validate,
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
    final price = Fixed.parse(widget.selectedAsset?.currency?.price ?? '0');

    late Fixed amount;
    try {
      amount = Fixed.parse(state.value.nullIf('') ?? '0');
    } catch (e) {
      amount = Fixed.parse('0');
    }

    final usd = Fixed.copyWith(amount * price, scale: 2);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: AutoSizeTextField(
                controller: widget.controller,
                focusNode: widget.focusNode,
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
                inputFormatters: formatter?.let((formatter) => [formatter]),
                fullwidth: false,
                onChanged: state.didChange,
                onSubmitted: widget.onSubmitted,
              ),
            ),
            Text(
              widget.selectedAsset?.tokenSymbol ?? '',
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

  void _updateFormatterValidator() {
    if (widget.selectedAsset == null) {
      formatter = null;
      validator = null;
    } else {
      final (f, v) = createCurrencyTextInputFormatterValidator(
        widget.selectedAsset!.balance.currency,
        emptyError: LocaleKeys.amountIsEmpty.tr(),
        error: LocaleKeys.amountIsWrong.tr(),
        max: widget.selectedAsset!.balance.amount,
        maxError: LocaleKeys.insufficientFunds.tr(),
        decimalSeparators: ['.', ','],
      );
      formatter = f;
      validator = v;
    }
  }
}
