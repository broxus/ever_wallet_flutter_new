import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/qr_scanner/qr_scanner.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';

final addressFilter = FilteringTextInputFormatter.deny(RegExp(r'\s'));

/// View for Ton/Token Wallet to prepare transfer
class WalletPrepareTransferView extends StatefulWidget {
  const WalletPrepareTransferView({
    required this.account,
    required this.localCustodians,
    required this.selectedCustodian,
    required this.selectedAsset,
    required this.assets,
    super.key,
  });

  final KeyAccount account;
  final List<PublicKey> localCustodians;
  final PublicKey selectedCustodian;
  final WalletPrepareTransferAsset selectedAsset;
  final List<WalletPrepareTransferAsset> assets;

  @override
  State<WalletPrepareTransferView> createState() =>
      _WalletPrepareTransferViewState();
}

class _WalletPrepareTransferViewState extends State<WalletPrepareTransferView> {
  final _formKey = GlobalKey<FormState>();

  final _receiverController = TextEditingController();
  final _receiverFocus = FocusNode();

  final _amountController = TextEditingController();
  final _amountFocus = FocusNode();

  final _commentController = TextEditingController();
  final _commentFocus = FocusNode();

  @override
  void dispose() {
    _receiverController.dispose();
    _receiverFocus.dispose();

    _amountController.dispose();
    _amountFocus.dispose();

    _commentController.dispose();
    _commentFocus.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant WalletPrepareTransferView oldWidget) {
    // drop amount if token was changed
    if (oldWidget.selectedAsset.rootTokenContract !=
        widget.selectedAsset.rootTokenContract) {
      _amountController.clear();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    return Form(
      key: _formKey,
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
                  CommonSelectDropdown<WalletPrepareTransferAsset>(
                    values: widget.assets
                        .map(
                          (c) => CommonSheetDropdownItem<
                              WalletPrepareTransferAsset>(
                            value: c,
                            title: c.title,
                            icon: TokenWalletIconWidget(
                              size: DimensSize.d32,
                              address: c.rootTokenContract,
                              logoURI: c.logoURI,
                              // tip3 for native
                              version: c.version ?? TokenWalletVersion.tip3,
                            ),
                          ),
                        )
                        .toList(),
                    titleText: LocaleKeys.assetsWord.tr(),
                    currentValue: widget.selectedAsset,
                    sheetTitle: LocaleKeys.selectToken.tr(),
                    onChanged: (asset) => context
                        .read<WalletPrepareTransferCubit>()
                        .changeAsset(asset.rootTokenContract),
                  ),
                  if (widget.localCustodians.length > 1)
                    CommonSelectDropdown<PublicKey>(
                      values: widget.localCustodians
                          .map(
                            (c) => CommonSheetDropdownItem<PublicKey>(
                              value: c,
                              title: inject<NekotonRepository>()
                                      .seedList
                                      .findSeedKey(c)
                                      ?.name ??
                                  c.toEllipseString(),
                            ),
                          )
                          .toList(),
                      titleText: LocaleKeys.custodianWord.tr(),
                      currentValue: widget.selectedCustodian,
                      onChanged: (custodian) => context
                          .read<WalletPrepareTransferCubit>()
                          .changeCustodian(custodian),
                    ),
                  CommonInput(
                    titleText: LocaleKeys.receiverAddress.tr(),
                    controller: _receiverController,
                    focusNode: _receiverFocus,
                    onSubmitted: (_) => _amountFocus.requestFocus(),
                    inputFormatters: [addressFilter],
                    validator: (value) => value?.isEmpty ?? true
                        ? LocaleKeys.addressIsEmpty.tr()
                        : null,
                    suffixIconConstraints: BoxConstraints(
                      minHeight: commonInputHeight,
                      // ignore: no-magic-number
                      minWidth: CommonIconButtonSize.small.value * 2,
                    ),
                    suffixIcon: _addressSuffixIcon(),
                  ),
                  CommonInput(
                    titleText: LocaleKeys.amountWord.tr(),
                    subtitleText: LocaleKeys.amountAvailable.tr(
                      args: [widget.selectedAsset.balance.formatImproved()],
                    ),
                    controller: _amountController,
                    focusNode: _amountFocus,
                    onSubmitted: (_) => _commentFocus.requestFocus(),
                    validator: (value) => CurrencyTextInputValidator(
                      widget.selectedAsset.balance.currency,
                      emptyError: LocaleKeys.amountIsEmpty.tr(),
                      error: LocaleKeys.amountIsWrong.tr(),
                      max: widget.selectedAsset.balance.amount,
                      maxError: LocaleKeys.insufficientFunds.tr(),
                    ).validate(value),
                    inputFormatters: [
                      CurrencyTextInputFormatter(
                        widget.selectedAsset.balance.currency,
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
                      onPressed: _setMaxBalance,
                    ),
                  ),
                  CommonInput(
                    titleText: LocaleKeys.commentWord.tr(),
                    controller: _commentController,
                    focusNode: _commentFocus,
                    onSubmitted: (_) => _nextAction(),
                  ),
                ],
              ),
            ),
          ),
          CommonButton.primary(
            fillWidth: true,
            text: LocaleKeys.nextWord.tr(),
            onPressed: _nextAction,
          ),
          const SizedBox(height: DimensSize.d16),
        ],
      ),
    );
  }

  void _nextAction() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<WalletPrepareTransferCubit>().nextAction(
            receiverAddress: _receiverController.text.trim(),
            amount: _amountController.text.trim(),
            comment: _commentController.text.trim(),
          );
    }
  }

  Future<void> _pasteAddress() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data != null && data.text != null) {
      final addr = data.text!.trim();
      if (await validateAddress(Address(address: addr))) {
        _receiverController.text = addr;
        _receiverFocus.unfocus();
      } else {
        inject<MessengerService>().show(
          Message.error(message: LocaleKeys.addressIsWrong.tr()),
        );
      }
    }
  }

  void _setMaxBalance() {
    final available = widget.selectedAsset.balance;
    // TODO(alex-a4): add formatting balance
    _amountController.text = available.formatImproved();
  }

  Widget _addressSuffixIcon() {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: _receiverController,
      builder: (context, value, _) {
        final colors = context.themeStyle.colors;

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (value.text.isNotEmpty)
              CommonIconButton.icon(
                buttonType: EverButtonType.ghost,
                icon: Icons.clear_rounded,
                size: CommonIconButtonSize.small,
                onPressed: _receiverController.clear,
                color: colors.textSecondary,
              )
            else
              CommonIconButton.svg(
                buttonType: EverButtonType.ghost,
                svg: Assets.images.paste.path,
                size: CommonIconButtonSize.small,
                onPressed: _pasteAddress,
                color: colors.blue,
              ),
            CommonIconButton.svg(
              buttonType: EverButtonType.ghost,
              svg: Assets.images.scan.path,
              size: CommonIconButtonSize.small,
              onPressed: () async {
                final address = await showQrScanner(context);
                if (address != null) {
                  _receiverController.text = address;
                }
              },
              color: colors.blue,
            ),
          ],
        );
      },
    );
  }
}
