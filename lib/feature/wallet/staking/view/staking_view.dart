import 'package:app/data/models/models.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:app/widgets/amount_input/amount_input.dart';
import 'package:app/widgets/amount_input/amount_input_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

extension on StakingPageType {
  String get title {
    return switch (this) {
      StakingPageType.stake => LocaleKeys.stakeWord.tr(),
      StakingPageType.unstake => LocaleKeys.unstakeWord.tr(),
      StakingPageType.inProgress => LocaleKeys.inProgress.tr(),
    };
  }
}

/// Main view that displays content of staking
class StakingView extends StatelessWidget {
  const StakingView(
    this.type,
    this.withdrawTime,
    this.attachedAmount,
    // ignore: avoid_positional_boolean_parameters
    this.canSubmitAction,
    this.inputController,
    this.exchangeRate,
    this.receiveCurrency,
    this.accountPublicKey,
    this.enteredPrice,
    this.asset,
    this.receiveBalance,
    this.requests,
    this.apy, {
    super.key,
  });

  /// Type of current selected action
  final StakingPageType type;

  /// Amount in EVER that will be attached to action
  final BigInt attachedAmount;
  final int withdrawTime;
  final bool canSubmitAction;
  final TextEditingController inputController;
  final Currency receiveCurrency;

  /// How many stevers could be received for evers
  final double? exchangeRate;

  /// Price in real curreny of entered tokens
  final Money enteredPrice;

  /// Balance of token user select after action (stake-stever, unstake-ever)
  final Money? receiveBalance;

  /// Pending withdraw requests
  final List<StEverWithdrawRequest>? requests;

  final PublicKey accountPublicKey;

  /// Average profit
  final double? apy;

  final AmountInputAsset asset;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    final bloc = context.read<StakingBloc>();

    return SeparatedColumn(
      separatorSize: DimensSizeV2.d16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SwitcherSegmentControls<StakingPageType>(
            fullWidth: false,
            currentValue: type,
            values: [
              PrimarySegmentControl(
                title: StakingPageType.stake.title,
                value: StakingPageType.stake,
                size: SegmentControlSize.xsmall,
                state: SegmentControlState.normal,
              ),
              PrimarySegmentControl(
                title: StakingPageType.unstake.title,
                value: StakingPageType.unstake,
                size: SegmentControlSize.xsmall,
                state: SegmentControlState.normal,
              ),
              if (requests != null && requests!.isNotEmpty)
                PrimarySegmentControl(
                  titleSpan: TextSpan(
                    children: [
                      TextSpan(text: StakingPageType.inProgress.title),
                      const WidgetSpan(
                        child: SizedBox(width: DimensSizeV2.d8),
                      ),
                      TextSpan(
                        text: requests?.length.toString() ?? '0',
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
                  value: StakingPageType.inProgress,
                  size: SegmentControlSize.xsmall,
                  state: SegmentControlState.normal,
                ),
            ],
            onTabChanged: (value) => context
                .read<StakingBloc>()
                .add(StakingBlocEvent.changeTab(value)),
          ),
        ),
        switch (type) {
          StakingPageType.stake => _stakeUnstakeBody(context),
          StakingPageType.unstake => _stakeUnstakeBody(context),
          StakingPageType.inProgress => StakingInProgress(
              requests: requests ?? [],
              accountKey: accountPublicKey,
              exchangeRate: exchangeRate ?? 0.0,
              stakeCurrency: receiveCurrency,
              attachedFee: attachedAmount,
              withdrawHours: withdrawTime,
              everPrice: bloc.everWalletCurrency.price,
              tokenPrice: bloc.stEverWalletCurrency.price,
            ),
        },
      ],
    );
  }

  Widget _stakeUnstakeBody(BuildContext context) {
    return SeparatedColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      separatorSize: DimensSizeV2.d4,
      children: [
        AmountInput(
          controller: inputController,
          selectedAsset: asset,
          onMaxAmount: () => context
              .read<StakingBloc>()
              .add(const StakingBlocEvent.selectMax()),
          onSubmitted: (value) => inputController.text = value,
        ),
        const SizedBox(height: DimensSizeV2.d12),
        _InfoField(
          currentCurrency: asset.balance.currency,
          receiveCurrency: receiveCurrency,
          exchangeRate: exchangeRate ?? 1,
          attachedAmount: Money.fromBigIntWithCurrency(
            attachedAmount,
            Currencies()[inject<NekotonRepository>()
                .currentTransport
                .nativeTokenTicker]!,
          ),
          receiveBalance: receiveBalance,
          apy: apy,
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
  final Money? receiveBalance;
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
            _InfoRow(
              label: LocaleKeys.receiveWord.tr(),
              child: AmountWidget.fromMoney(
                amount: receiveBalance!,
                sign: receiveBalance!.amount == Fixed.zero ? '' : '~',
              ),
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
