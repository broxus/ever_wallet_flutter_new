import 'package:app/data/models/models.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/details.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/widgets.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/widgets.dart';

class CancelUnstakingPageWidget
    extends ElementaryWidget<CancelUnstakingPageWidgetModel> {
  const CancelUnstakingPageWidget({
    required this.request,
    required this.accountKey,
    required this.exchangeRate,
    required this.withdrawHours,
    required this.stakeCurrency,
    required this.attachedFee,
    required this.tokenPrice,
    required this.everPrice,
    Key? key,
    WidgetModelFactory wmFactory = defaultCancelUnstakingPageWidgetModelFactory,
  }) : super(wmFactory, key: key);

  /// Pending withdraw requests
  final StEverWithdrawRequest request;
  final PublicKey accountKey;
  final double exchangeRate;
  final int withdrawHours;
  final Currency stakeCurrency;
  final BigInt attachedFee;
  final Fixed? tokenPrice;
  final Fixed? everPrice;

  @override
  Widget build(CancelUnstakingPageWidgetModel wm) {
    final theme = wm.theme;
    final tokenValue = Money.fromBigIntWithCurrency(
      request.data.amount,
      stakeCurrency,
    );
    final everValue = Money.fromBigIntWithCurrency(
      (tokenValue * exchangeRate).minorUnits,
      wm.nativeCurrency,
    );

    return Scaffold(
      appBar: DefaultAppBar(
        titleText: LocaleKeys.transactionInformation.tr(),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            bottom: DimensSizeV2.d90,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: DimensSizeV2.d16,
                vertical: DimensSizeV2.d8,
              ),
              child: PrimaryCard(
                padding: const EdgeInsets.symmetric(
                  horizontal: DimensSize.d16,
                  vertical: DimensSize.d8,
                ),
                borderRadius: BorderRadius.circular(DimensRadiusV2.radius12),
                child: SeparatedColumn(
                  separatorSize: DimensSizeV2.d16,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox.shrink(),
                    _StatusDateRow(request: request),
                    Text(
                      LocaleKeys.withdrawHoursNote.tr(
                        args: [withdrawHours.toString()],
                      ),
                      style: StyleRes.secondaryRegular.copyWith(
                        color: theme.colors.content3,
                      ),
                    ),
                    const Divider(),
                    WalletTransactionDetailsItem(
                      title: LocaleKeys.typeWord.tr(),
                      value: LocaleKeys.liquidStaking.tr(),
                    ),
                    StateNotifierBuilder(
                      listenableState: wm.asset,
                      builder: (_, asset) => WalletTransactionDetailsItem(
                        title: LocaleKeys.unstakeAmount.tr(),
                        valueWidget: AmountWidget.fromMoney(
                          amount: tokenValue,
                          includeSymbol: false,
                        ),
                        iconPath: asset?.logoURI ??
                            Assets.images.tokenDefaultIcon.path,
                        convertedValueWidget: tokenPrice != null
                            ? AmountWidget.dollars(
                                amount: tokenValue.exchangeToUSD(tokenPrice!),
                                style: theme.textStyles.labelXSmall.copyWith(
                                  color: theme.colors.content3,
                                ),
                              )
                            : null,
                      ),
                    ),
                    WalletTransactionDetailsItem(
                      title: LocaleKeys.exchangeRate.tr(),
                      value:
                          // ignore: lines_longer_than_80_chars, no-magic-number, binary-expression-operand-order
                          '1 ${wm.nativeCurrency.symbol} ≈ ${(1 * exchangeRate).toStringAsFixed(4)} ${stakeCurrency.isoCode}',
                    ),
                    WalletTransactionDetailsItem(
                      title: LocaleKeys.receiveWord.tr(),
                      valueWidget: AmountWidget.fromMoney(
                        amount: everValue,
                        includeSymbol: false,
                      ),
                      iconPath: wm.nativeTokenIcon,
                      convertedValueWidget: everPrice != null
                          ? AmountWidget.fromMoney(
                              amount: everValue.exchangeToUSD(everPrice!),
                              style: theme.textStyles.labelXSmall.copyWith(
                                color: theme.colors.content3,
                              ),
                              sign: '~ ',
                            )
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: DimensSizeV2.d0,
            left: DimensSizeV2.d0,
            right: DimensSizeV2.d0,
            child: Padding(
              padding: const EdgeInsets.all(DimensSizeV2.d16),
              child: DestructiveButton(
                buttonShape: ButtonShape.pill,
                title: LocaleKeys.cancelUnstaking.tr(),
                onPressed: wm.tryCancelUnstaking,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusDateRow extends StatelessWidget {
  const _StatusDateRow({
    required this.request,
  });

  final StEverWithdrawRequest request;

  @override
  Widget build(BuildContext context) {
    final date = request.data.timestamp;
    final theme = context.themeStyleV2;
    final formatter = date.year == NtpTime.now().year
        ? DateFormat('MM.dd, HH:mm', context.locale.languageCode)
        : DateFormat('MM.dd.y, HH:mm', context.locale.languageCode);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          formatter.format(date),
          style: theme.textStyles.labelXSmall.copyWith(
            color: theme.colors.content3,
          ),
        ),
        TonWalletTransactionStatus.unstakingInProgress.chipByStatus,
      ],
    );
  }
}
