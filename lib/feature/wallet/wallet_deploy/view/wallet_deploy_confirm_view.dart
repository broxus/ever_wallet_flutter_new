import 'package:app/data/models/custom_currency.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/feature/wallet/wallet_deploy/view/deploy_wallet_confirm_modal.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/details_item.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Widget, that displays base information for deploying wallet and let user
/// confirm transaction by entering password.
class WalletDeployConfirmView extends StatelessWidget {
  const WalletDeployConfirmView({
    required this.publicKey,
    this.balance,
    this.fee,
    this.feeError,
    this.custodians,
    this.requireConfirmations,
    this.tonIconPath,
    this.currency,
    this.customCurrency,
    this.account,
    super.key,
  });

  final BigInt? balance;
  final BigInt? fee;
  final String? feeError;
  final PublicKey publicKey;
  final List<PublicKey>? custodians;
  final int? requireConfirmations;
  final String? tonIconPath;
  final Currency? currency;
  final CustomCurrency? customCurrency;
  final KeyAccount? account;

  @override
  Widget build(BuildContext context) {
    final isLoading = fee == null && feeError == null;
    final theme = context.themeStyleV2;

    return SeparatedColumn(
      separatorSize: DimensSizeV2.d16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (account != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d16),
            child: AccountInfo(account: account!),
          ),
        Expanded(
          child: SingleChildScrollView(
            child: ShapedContainerColumn(
              separator: const SizedBox.shrink(),
              padding: const EdgeInsets.only(
                top: DimensSizeV2.d24,
                left: DimensSizeV2.d16,
                right: DimensSizeV2.d16,
                bottom: DimensSizeV2.d4,
              ),
              color: theme.colors.background1,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  LocaleKeys.fundsDebitedToDeploy.tr(),
                  style: theme.textStyles.labelMedium,
                ),
                const SizedBox(height: DimensSizeV2.d16),
                CommonDivider(color: theme.colors.border0),
                const SizedBox(height: DimensSizeV2.d16),
                if (currency != null)
                  WalletTransactionDetailsItem(
                    title: LocaleKeys.accountBalance.tr(),
                    valueWidget: AmountWidget.fromMoney(
                      amount: Money.fromBigIntWithCurrency(
                        balance ?? BigInt.zero,
                        currency!,
                      ),
                      includeSymbol: false,
                    ),
                    iconPath: tonIconPath,
                    convertedValueWidget: AmountWidget.dollars(
                      amount: Money.fromBigIntWithCurrency(
                        balance ?? BigInt.zero,
                        currency!,
                      ).exchangeToUSD(
                        Fixed.parse(customCurrency?.price ?? '0'),
                      ),
                      style: theme.textStyles.labelXSmall.copyWith(
                        color: theme.colors.content3,
                      ),
                    ),
                  ),
                const SizedBox(height: DimensSizeV2.d16),
                if (currency != null)
                  WalletTransactionDetailsItem(
                    title: LocaleKeys.networkFee.tr(),
                    valueWidget: AmountWidget.fromMoney(
                      amount: Money.fromBigIntWithCurrency(
                        fee ?? BigInt.zero,
                        currency!,
                      ),
                      useDefaultFormat: false,
                      includeSymbol: false,
                    ),
                    iconPath: tonIconPath,
                    convertedValueWidget: AmountWidget.dollars(
                      amount: Money.fromBigIntWithCurrency(
                        fee ?? BigInt.zero,
                        currency!,
                      ).exchangeToUSD(
                        Fixed.parse(customCurrency?.price ?? '0'),
                        5,
                      ),
                      style: theme.textStyles.labelXSmall.copyWith(
                        color: theme.colors.content3,
                      ),
                    ),
                  ),
                const SizedBox(height: DimensSizeV2.d4),
                if (custodians?.isNotEmpty ?? false)
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: DimensSizeV2.d16,
                      top: DimensSizeV2.d12,
                    ),
                    child: CommonDivider(color: theme.colors.border0),
                  ),
                ...?custodians?.mapIndexed(
                  (index, e) => _info(
                    title: LocaleKeys.custodianNumber.tr(
                      args: [(index + 1).toString()],
                    ),
                    value: e.publicKey,
                  ),
                ),
                if (requireConfirmations != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: DimensSizeV2.d16),
                    child: CommonDivider(color: theme.colors.border0),
                  ),
                if (requireConfirmations != null)
                  _info(
                    title: LocaleKeys.requiredConfirms.tr(),
                    value: LocaleKeys.requireConfirmsCount.tr(
                      args: [
                        requireConfirmations!.toString(),
                        custodians!.length.toString(),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: DimensSize.d24,
            left: DimensSize.d16,
            right: DimensSize.d16,
            top: DimensSize.d16,
          ),
          child: AccentButton(
            isLoading: isLoading,
            title: LocaleKeys.deployWord.tr(),
            onPressed: feeError != null || fee == null
                ? null
                : () {
                    showDeployConfirmModal(
                      context,
                      (password) {
                        context
                            .read<WalletDeployBloc>()
                            .add(WalletDeployEvent.confirmDeploy(password));
                      },
                    );
                  },
            buttonShape: ButtonShape.pill,
          ),
        ),
      ],
    );
  }

  Widget _info({
    required String title,
    String? value,
    Widget? valueChild,
    String? subtitleError,
  }) {
    return Builder(
      builder: (context) {
        final theme = context.themeStyleV2;

        return SeparatedColumn(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          separatorSize: DimensSizeV2.d12,
          children: [
            Text(
              title,
              style: theme.textStyles.labelSmall.copyWith(
                color: theme.colors.content2,
              ),
            ),
            if (value != null)
              Text(
                value,
                style: theme.textStyles.paragraphSmall.copyWith(
                  color: theme.colors.content0,
                ),
              ),
            if (valueChild != null) valueChild,
            if (subtitleError != null)
              Text(
                subtitleError,
                style: StyleRes.addRegular.copyWith(
                  color: theme.colors.contentNegative,
                ),
              ),
            const SizedBox(height: DimensSizeV2.d12),
          ],
        );
      },
    );
  }
}
