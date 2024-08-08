import 'package:app/app/router/app_route.dart';
import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:app/v1/feature/wallet/wallet.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Screen that allows user to cancel pending withdraw request
class CancelUnstakingPage extends StatelessWidget {
  const CancelUnstakingPage({
    required this.request,
    required this.accountKey,
    required this.exchangeRate,
    required this.withdrawHours,
    required this.stakeCurrency,
    required this.attachedFee,
    super.key,
  });

  /// Pending withdraw requests
  final StEverWithdrawRequest request;
  final PublicKey accountKey;
  final double exchangeRate;
  final int withdrawHours;
  final Currency stakeCurrency;
  final BigInt attachedFee;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;
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
      appBar: const DefaultAppBar(),
      body: Stack(
        children: [
          Positioned.fill(
            bottom: commonButtonHeight + DimensSize.d16,
            child: SingleChildScrollView(
              child: SeparatedColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                separatorSize: DimensSize.d16,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimensSize.d16,
                    ),
                    child: Text(
                      LocaleKeys.transactionInformation.tr(),
                      style: StyleRes.h1.copyWith(
                        color: context.themeStyle.colors.textPrimary,
                      ),
                    ),
                  ),
                  ShapedContainerColumn(
                    mainAxisSize: MainAxisSize.min,
                    padding: const EdgeInsets.symmetric(
                      vertical: DimensSize.d16,
                    ),
                    separator: const Padding(
                      padding: EdgeInsets.symmetric(vertical: DimensSize.d8),
                      child: CommonDivider(),
                    ),
                    children: [
                      _statusDateRow(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: DimensSize.d16,
                        ),
                        child: Text(
                          LocaleKeys.withdrawHoursNote.tr(
                            args: [withdrawHours.toString()],
                          ),
                          style: StyleRes.secondaryRegular.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                      ),
                      CommonListTile(
                        invertTitleSubtitleStyles: true,
                        padding: const EdgeInsets.symmetric(
                          horizontal: DimensSize.d16,
                        ),
                        titleText: LocaleKeys.typeWord.tr(),
                        subtitleText: LocaleKeys.liquidStaking.tr(),
                      ),
                      CommonListTile(
                        invertTitleSubtitleStyles: true,
                        padding: const EdgeInsets.symmetric(
                          horizontal: DimensSize.d16,
                        ),
                        titleText: LocaleKeys.unstakeAmount.tr(),
                        subtitleChild: MoneyWidget(
                          money: steverMoney,
                          style: MoneyWidgetStyle.primary,
                        ),
                      ),
                      CommonListTile(
                        invertTitleSubtitleStyles: true,
                        padding: const EdgeInsets.symmetric(
                          horizontal: DimensSize.d16,
                        ),
                        titleText: LocaleKeys.exchangeRate.tr(),
                        subtitleText:
                            // ignore: lines_longer_than_80_chars, no-magic-number, binary-expression-operand-order
                            '1 ${inject<NekotonRepository>().currentTransport.nativeTokenTicker} ≈ ${(1 * exchangeRate).toStringAsFixed(4)} ${stakeCurrency.code}',
                      ),
                      CommonListTile(
                        invertTitleSubtitleStyles: true,
                        padding: const EdgeInsets.symmetric(
                          horizontal: DimensSize.d16,
                        ),
                        titleText: LocaleKeys.receiveWord.tr(),
                        subtitleChild: MoneyWidget(
                          money: everMoney,
                          style: MoneyWidgetStyle.primary,
                          signValue: '~',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: DimensSize.d16,
            left: DimensSize.d16,
            right: DimensSize.d16,
            child: CommonButton(
              buttonType: EverButtonType.secondary,
              contentColor: colors.alert,
              text: LocaleKeys.cancelUnstaking.tr(),
              onPressed: () => tryCancelUnstaking(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusDateRow() {
    return Builder(
      builder: (context) {
        final date = request.data.timestamp;
        final colors = context.themeStyle.colors;
        final formatter = date.year == NtpTime.now().year
            ? DateFormat('MM.dd, HH:mm', context.locale.languageCode)
            : DateFormat('MM.dd.y, HH:mm', context.locale.languageCode);

        final statusWidget = tonWalletTransactionStatusBody(
          TonWalletTransactionStatus.unstakingInProgress,
        );

        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DimensSize.d16,
            vertical: DimensSize.d8,
          ),
          child: SeparatedRow(
            children: [
              if (statusWidget != null) statusWidget,
              Expanded(
                child: Text(
                  formatter.format(date),
                  style: StyleRes.addRegular.copyWith(
                    color: colors.textSecondary,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        );
      },
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
