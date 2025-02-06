import 'package:app/data/models/models.dart';
import 'package:app/feature/wallet/staking/models/models.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:app/widgets/amount_input/amount_input.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Main view that displays content of staking
class StakingView extends StatelessWidget {
  const StakingView({
    required this.inputController,
    required this.info,
    required this.data,
    required this.requests,
    required this.receive,
    required this.onTabChanged,
    required this.onMaxAmount,
    super.key,
  });

  final TextEditingController inputController;
  final StakingInfo info;
  final StakingData data;
  final ListenableState<List<StEverWithdrawRequest>> requests;
  final ListenableState<Money> receive;
  final ValueChanged<StakingTab> onTabChanged;
  final VoidCallback onMaxAmount;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return SeparatedColumn(
      separatorSize: DimensSizeV2.d16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: StateNotifierBuilder(
            listenableState: requests,
            builder: (_, requests) => SwitcherSegmentControls(
              fullWidth: false,
              currentValue: data.tab,
              values: [
                PrimarySegmentControl(
                  title: StakingTab.stake.title,
                  value: StakingTab.stake,
                  size: SegmentControlSize.xsmall,
                  state: SegmentControlState.normal,
                ),
                PrimarySegmentControl(
                  title: StakingTab.unstake.title,
                  value: StakingTab.unstake,
                  size: SegmentControlSize.xsmall,
                  state: SegmentControlState.normal,
                ),
                if (requests != null && requests.isNotEmpty)
                  PrimarySegmentControl(
                    titleSpan: TextSpan(
                      children: [
                        TextSpan(text: StakingTab.inProgress.title),
                        const WidgetSpan(
                          child: SizedBox(width: DimensSizeV2.d8),
                        ),
                        TextSpan(
                          text: requests.length.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            background: Paint()
                              ..strokeWidth = DimensSizeV2.d8
                              ..color = theme.colors.backgroundAccent
                              ..style = PaintingStyle.stroke
                              ..strokeJoin = StrokeJoin.round,
                          ),
                        ),
                      ],
                    ),
                    value: StakingTab.inProgress,
                    size: SegmentControlSize.xsmall,
                    state: SegmentControlState.normal,
                  ),
              ],
              onTabChanged: onTabChanged,
            ),
          ),
        ),
        switch (data.tab) {
          StakingTab.stake || StakingTab.unstake => _stakeUnstakeBody(context),
          StakingTab.inProgress => StateNotifierBuilder(
              listenableState: requests,
              builder: (_, requests) => StakingInProgress(
                requests: requests ?? [],
                accountKey: info.wallet.publicKey,
                exchangeRate: data.exchangeRate,
                stakeCurrency: data.receiveCurrency,
                attachedFee: data.attachedAmount.minorUnits,
                withdrawHours: info.withdrawHours,
                everPrice: info.currency.price,
                tokenPrice: info.tokenCurrency.price,
              ),
            ),
        },
      ],
    );
  }

  Widget _stakeUnstakeBody(BuildContext context) {
    final theme = context.themeStyleV2;

    return SeparatedColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      separatorSize: DimensSizeV2.d4,
      children: [
        AmountInput(
          controller: inputController,
          selectedAsset: data.asset,
          onMaxAmount: onMaxAmount,
          onSubmitted: (value) => inputController.text = value,
        ),
        const SizedBox(height: DimensSizeV2.d12),
        _InfoField(
          currentCurrency: data.asset!.balance.currency,
          receiveCurrency: data.receiveCurrency,
          exchangeRate: data.exchangeRate,
          attachedAmount: data.attachedAmount,
          receiveBalance: data.tab == StakingTab.inProgress ? null : receive,
          apy: data.tab == StakingTab.inProgress ? null : info.apy,
        ),
        if (data.tab == StakingTab.unstake)
          Padding(
            padding: const EdgeInsets.only(top: DimensSizeV2.d8),
            child: PrimaryCard(
              padding: const EdgeInsets.all(DimensSizeV2.d16),
              borderRadius: BorderRadius.circular(DimensRadiusV2.radius16),
              color: theme.colors.backgroundWarning,
              child: Text(
                LocaleKeys.withdrawHoursHint.tr(
                  args: [info.withdrawHours.toString()],
                ),
                style: theme.textStyles.labelSmall.copyWith(
                  color: theme.colors.contentWarning,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _InfoField extends StatelessWidget {
  const _InfoField({
    required this.currentCurrency,
    required this.receiveCurrency,
    required this.exchangeRate,
    required this.attachedAmount,
    this.receiveBalance,
    this.apy,
  });

  final Currency currentCurrency;
  final Currency receiveCurrency;
  final double exchangeRate;
  final Money attachedAmount;
  final ListenableState<Money>? receiveBalance;
  final double? apy;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return PrimaryCard(
      padding: const EdgeInsets.all(DimensSizeV2.d16),
      borderRadius: BorderRadius.circular(DimensRadiusV2.radius16),
      // color: color,
      child: SeparatedColumn(
        separatorSize: DimensSizeV2.d16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InfoRow(
            label: LocaleKeys.exchangeRate.tr(),
            child: Text(
              // ignore: lines_longer_than_80_chars, no-magic-number, binary-expression-operand-order
              '1 ${currentCurrency.isoCode} ≈ ${(1 * exchangeRate).toStringAsFixed(4)} ${receiveCurrency.isoCode}',
              style: theme.textStyles.labelSmall,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              maxLines: 1,
            ),
          ),
          _InfoRow(
            label: LocaleKeys.attachedAmount.tr(),
            child: AmountWidget.fromMoney(
              amount: attachedAmount,
            ),
          ),
          if (receiveBalance != null)
            StateNotifierBuilder(
              listenableState: receiveBalance!,
              builder: (_, receiveBalance) =>
                  receiveBalance?.let(
                    (value) => _InfoRow(
                      label: LocaleKeys.receiveWord.tr(),
                      child: AmountWidget.fromMoney(
                        amount: value,
                        sign: value.amount == Fixed.zero ? '' : '~',
                      ),
                    ),
                  ) ??
                  const SizedBox.shrink(),
            ),
          if (apy != null)
            _InfoRow(
              label: LocaleKeys.averageApy.tr(),
              child: Text(
                '${apy!.toStringAsFixed(2)} %',
                style: theme.textStyles.labelSmall,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                maxLines: 1,
              ),
            ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.child,
  });

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return SeparatedRow(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textStyles.labelSmall.copyWith(
            color: theme.colors.content3,
          ),
        ),
        Flexible(child: child),
      ],
    );
  }
}

extension on StakingTab {
  String get title {
    return switch (this) {
      StakingTab.stake => LocaleKeys.stakeWord.tr(),
      StakingTab.unstake => LocaleKeys.unstakeWord.tr(),
      StakingTab.inProgress => LocaleKeys.inProgress.tr(),
    };
  }
}
