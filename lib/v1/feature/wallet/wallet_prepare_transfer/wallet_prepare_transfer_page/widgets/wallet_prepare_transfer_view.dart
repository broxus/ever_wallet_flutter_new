import 'package:app/v1/feature/wallet/wallet.dart';
import 'package:app/v1/feature/wallet/wallet_prepare_transfer/wallet_prepare_transfer_page/data/wallet_prepare_transfer_asset.dart';
import 'package:app/v1/feature/wallet/wallet_prepare_transfer/wallet_prepare_transfer_page/wallet_prepare_transfer_page_wm.dart';
import 'package:app/v1/feature/wallet/wallet_prepare_transfer/wallet_prepare_transfer_page/widgets/wallet_prepare_address_suffix_icon.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';

/// View for Ton/Token Wallet to prepare transfer

class WalletPrepareTransferView extends StatelessWidget {
  const WalletPrepareTransferView(
    this._wm, {
    this.account,
    this.localCustodians,
    this.selectedCustodian,
    this.selectedAsset,
    this.assets,
    super.key,
  });

  final WalletPrepareTransferPageWidgetModel _wm;

  final KeyAccount? account;
  final List<PublicKey>? localCustodians;
  final PublicKey? selectedCustodian;
  final WalletPrepareTransferAsset? selectedAsset;
  final List<WalletPrepareTransferAsset>? assets;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    return Form(
      key: _wm.formKey,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: SeparatedColumn(
                separatorSize: DimensSize.d16,
                children: [
                  Text(
                    LocaleKeys.sendYourFunds.tr(),
                    style: StyleRes.h1.copyWith(color: colors.textPrimary),
                  ),
                  if (assets != null)
                    CommonSelectDropdown<WalletPrepareTransferAsset>(
                      values: [
                        for (final asset in assets!)
                          CommonSheetDropdownItem<WalletPrepareTransferAsset>(
                            value: asset,
                            title: asset.title,
                            icon: TokenWalletIconWidget(
                              size: DimensSize.d32,
                              address: asset.rootTokenContract,
                              logoURI: asset.logoURI,
                              // tip3 for native
                              version: asset.version ?? TokenWalletVersion.tip3,
                            ),
                          ),
                      ],
                      titleText: LocaleKeys.assetsWord.tr(),
                      currentValue: selectedAsset,
                      sheetTitle: LocaleKeys.selectToken.tr(),
                      onChanged: _wm.onChangeAsset,
                    ),
                  if (localCustodians != null && localCustodians!.length > 1)
                    CommonSelectDropdown<PublicKey>(
                      values: [
                        for (final c in localCustodians!)
                          CommonSheetDropdownItem<PublicKey>(
                            value: c,
                            title: _wm.getSeedName(c) ?? c.toEllipseString(),
                          ),
                      ],
                      titleText: LocaleKeys.custodianWord.tr(),
                      currentValue: selectedCustodian,
                      onChanged: _wm.onChangedCustodian,
                    ),
                  CommonInput(
                    titleText: LocaleKeys.receiverAddress.tr(),
                    controller: _wm.receiverController,
                    focusNode: _wm.receiverFocus,
                    onSubmitted: _wm.onSubmittedReceiverAddress,
                    inputFormatters: [_wm.addressFilterFormatter],
                    validator: (value) => value?.isEmpty ?? true
                        ? LocaleKeys.addressIsEmpty.tr()
                        : null,
                    suffixIconConstraints: BoxConstraints(
                      minHeight: commonInputHeight,
                      // ignore: no-magic-number
                      minWidth: CommonIconButtonSize.small.value * 2,
                    ),
                    suffixIcon: WalletPrepareAddressSuffixIcon(
                      receiverState: _wm.receiverState,
                      onPressedClear: _wm.onPressedReceiverClear,
                      onPressedPastAddress: _wm.onPressedPastAddress,
                      onPressedScan: _wm.onPressedScan,
                    ),
                  ),
                  CommonInput(
                    titleText: LocaleKeys.amountWord.tr(),
                    subtitleText: LocaleKeys.amountAvailable.tr(
                      args: selectedAsset == null
                          ? null
                          : [selectedAsset!.balance.formatImproved()],
                    ),
                    controller: _wm.amountController,
                    focusNode: _wm.amountFocus,
                    onSubmitted: _wm.onSubmittedAmountWord,
                    validator: (value) => selectedAsset == null
                        ? null
                        : CurrencyTextInputValidator(
                            selectedAsset!.balance.currency,
                            emptyError: LocaleKeys.amountIsEmpty.tr(),
                            error: LocaleKeys.amountIsWrong.tr(),
                            max: selectedAsset!.balance.amount,
                            maxError: LocaleKeys.insufficientFunds.tr(),
                          ).validate(value),
                    inputFormatters: [
                      if (selectedAsset != null)
                        CurrencyTextInputFormatter(
                          selectedAsset!.balance.currency,
                        ),
                    ],
                    suffixIconConstraints: const BoxConstraints(
                      minWidth: DimensSize.d64,
                      minHeight: commonInputHeight,
                    ),
                    suffixIcon: SmallButton(
                      buttonType: EverButtonType.ghost,
                      text: LocaleKeys.maxWord.tr(),
                      contentColor: colors.blue,
                      onPressed: _wm.setMaxBalance,
                    ),
                  ),
                  CommonInput(
                    titleText: LocaleKeys.commentWord.tr(),
                    controller: _wm.commentController,
                    focusNode: _wm.commentFocus,
                    onSubmitted: (_) => _wm.onPressedNext(),
                  ),
                ],
              ),
            ),
          ),
          CommonButton.primary(
            fillWidth: true,
            text: LocaleKeys.nextWord.tr(),
            onPressed: _wm.onPressedNext,
          ),
          const SizedBox(height: DimensSize.d16),
        ],
      ),
    );
  }
}
