import 'package:app/app/router/app_route.dart';
import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/details.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_status_body.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

// TODO(komarov): refactor
/// Screen that allows user to cancel pending withdraw request
class CancelUnstakingPage extends StatelessWidget {
  const CancelUnstakingPage({
    required this.request,
    required this.accountKey,
    required this.exchangeRate,
    required this.withdrawHours,
    required this.stakeCurrency,
    required this.attachedFee,
    required this.tokenPrice,
    required this.everPrice,
    super.key,
  });

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
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    final steverMoney = Money.fromBigIntWithCurrency(
      request.data.amount,
      stakeCurrency,
    );
    final everMoney = Money.fromBigIntWithCurrency(
      (steverMoney * exchangeRate).minorUnits,
      Currencies()[
          inject<NekotonRepository>().currentTransport.nativeTokenTicker]!,
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
                    _statusDateRow(context),
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
                    WalletTransactionDetailsItem(
                      title: LocaleKeys.unstakeAmount.tr(),
                      valueWidget: AmountWidget.fromMoney(amount: steverMoney),
                      tonIconPath: Assets.images.stever.stever.path,
                      convertedValueWidget: tokenPrice != null
                          ? AmountWidget.fromMoney(
                              amount: steverMoney.exchangeToUSD(tokenPrice!),
                              style: theme.textStyles.labelXSmall.copyWith(
                                color: theme.colors.content3,
                              ),
                              sign: '~ ',
                              useDefaultFormat: true,
                            )
                          : null,
                    ),
                    WalletTransactionDetailsItem(
                      title: LocaleKeys.exchangeRate.tr(),
                      value:
                        // ignore: lines_longer_than_80_chars, no-magic-number, binary-expression-operand-order
                        '1 ${inject<NekotonRepository>().currentTransport.nativeTokenTicker} ≈ ${(1 * exchangeRate).toStringAsFixed(4)} ${stakeCurrency.isoCode}',
                    ),
                    WalletTransactionDetailsItem(
                      title: LocaleKeys.receiveWord.tr(),
                      valueWidget: AmountWidget.fromMoney(amount: everMoney),
                      tonIconPath: Assets.images.stever.stever.path,
                      convertedValueWidget: everPrice != null
                          ? AmountWidget.fromMoney(
                        amount: everMoney.exchangeToUSD(everPrice!),
                        style: theme.textStyles.labelXSmall.copyWith(
                          color: theme.colors.content3,
                        ),
                        sign: '~ ',
                        useDefaultFormat: true,
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
                onPressed: () => tryCancelUnstaking(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusDateRow(BuildContext context) {
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

  Future<void> tryCancelUnstaking(BuildContext context) async {
    final agreed = await showVerifyCancelUnstakingSheet(context);
    if (!agreed) return;
    final staking =
        inject<NekotonRepository>().currentTransport.stakeInformation!;
    final payload =
        await inject<StakingService>().removeWithdrawPayload(request.nonce);
    if (context.mounted) {
      final result =
          await Navigator.of(context, rootNavigator: true).push<bool>(
        MaterialPageRoute(
          builder: (_) => TonWalletSendPage(
            address: request.accountAddress,
            amount: staking.stakeRemovePendingWithdrawAttachedFee,
            comment: payload,
            destination: staking.stakingValutAddress,
            publicKey: accountKey,
            resultMessage: LocaleKeys.stEverReturnInMinutes.tr(),
            completeCloseCallback: (context) => Navigator.of(context).pop(true),
          ),
        ),
      );

      if (result ?? false) {
        inject<StakingService>().acceptCancelledWithdraw(request);
        if (context.mounted) context.goNamed(AppRoute.wallet.name);
      }
    }
  }
}
