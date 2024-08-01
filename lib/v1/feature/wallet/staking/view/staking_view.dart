import 'package:app/data/models/models.dart';
import 'package:app/di/di.dart';
import 'package:app/v1/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

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
    this.imagePath,
    this.exchangeRate,
    this.receiveCurrency,
    this.accountPublicKey,
    this.currentBalance,
    this.enteredPrice,
    this.receiveBalance,
    this.requests,
    this.apy, {
    super.key,
  });

  /// Type of current selected action
  final StakingPageType type;

  /// Amount in EVER that will be attached to action
  final BigInt attachedAmount;

  final String imagePath;

  final int withdrawTime;
  final bool canSubmitAction;
  final TextEditingController inputController;
  final Currency receiveCurrency;

  /// How many stevers could be received for evers
  final double? exchangeRate;

  /// Balance of current selected token (stake-ever, unstake-stever)
  final Money currentBalance;

  /// Price in real curreny of entered tokens
  final Money enteredPrice;

  /// Balance of token user select after action (stake-stever, unstake-ever)
  final Money? receiveBalance;

  /// Pending withdraw requests
  final List<StEverWithdrawRequest>? requests;

  final PublicKey accountPublicKey;

  /// Average profit
  final double? apy;

  @override
  Widget build(BuildContext context) {
    return SeparatedColumn(
      separatorSize: DimensSize.d16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: CommonTabBar<StakingPageType>(
            selectedValue: type,
            onChanged: (type) => context
                .read<StakingBloc>()
                .add(StakingBlocEvent.changeTab(type)),
            values: [
              StakingPageType.stake,
              StakingPageType.unstake,
              if (requests != null && requests!.isNotEmpty)
                StakingPageType.inProgress,
            ],
            builder: (_, e) => e.title,
            trailingBuilder: (_, e) => e == StakingPageType.inProgress
                ? _pendingWithdrawIndicator()
                : null,
          ),
        ),
        switch (type) {
          StakingPageType.stake => _stakeUnstakeBody(),
          StakingPageType.unstake => _stakeUnstakeBody(),
          StakingPageType.inProgress => StakingInProgress(
              requests: requests ?? [],
              accountKey: accountPublicKey,
              exchangeRate: exchangeRate ?? 0.0,
              stakeCurrency: receiveCurrency,
              attachedFee: attachedAmount,
              withdrawHours: withdrawTime,
            ),
        },
      ],
    );
  }

  Widget _pendingWithdrawIndicator() {
    return Builder(
      builder: (context) {
        final textColor = EverButtonStyleProvider.of(context).contentColor;
        final colors = context.themeStyle.colors;

        return Container(
          width: DimensSize.d20,
          height: DimensSize.d20,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: colors.blue,
            shape: BoxShape.circle,
          ),
          child: Text(
            requests?.length.toString() ?? '0',
            style: StyleRes.addBold.copyWith(color: textColor),
          ),
        );
      },
    );
  }

  Widget _stakeUnstakeBody() {
    return SeparatedColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      separatorSize: DimensSize.d4,
      children: [
        _inputField(),
        MoneyWidget(
          money: currentBalance,
          style: MoneyWidgetStyle.secondary,
        ),
        const SizedBox(height: DimensSize.d12),
        _infoField(),
      ],
    );
  }

  Widget _inputField() {
    return Builder(
      builder: (context) {
        final colors = context.themeStyle.colors;

        return CommonInput(
          titleChild: TonWalletIconWidget(
            path: imagePath,
            size: DimensSize.d16,
          ),
          titleText:
              LocaleKeys.tokenAmount.tr(args: [currentBalance.currency.code]),
          controller: inputController,
          hintText: '0.0',
          inputFormatters: [
            CurrencyTextInputFormatter(currentBalance.currency),
          ],
          suffixIconConstraints: const BoxConstraints(
            minHeight: commonInputHeight,
            minWidth: DimensSize.d56,
          ),
          suffixIcon: SmallButton(
            onPressed: () => context
                .read<StakingBloc>()
                .add(const StakingBlocEvent.selectMax()),
            buttonType: EverButtonType.ghost,
            contentColor: colors.blue,
            text: LocaleKeys.maxWord.tr(),
          ),
        );
      },
    );
  }

  Widget _infoField() {
    return ShapedContainerColumn(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      children: [
        CommonListTile(
          invertTitleSubtitleStyles: true,
          titleText: LocaleKeys.exchangeRate.tr(),
          subtitleText:
              // ignore: lines_longer_than_80_chars, no-magic-number, binary-expression-operand-order
              '1 ${currentBalance.currency.code} ≈ ${(1 * (exchangeRate ?? 1)).toStringAsFixed(4)} ${receiveCurrency.code}',
        ),
        CommonListTile(
          invertTitleSubtitleStyles: true,
          titleText: LocaleKeys.attachedAmount.tr(),
          subtitleChild: MoneyWidget(
            money: Money.fromBigIntWithCurrency(
              attachedAmount,
              Currencies()[inject<NekotonRepository>()
                  .currentTransport
                  .nativeTokenTicker]!,
            ),
            style: MoneyWidgetStyle.primary,
          ),
        ),
        if (receiveBalance != null)
          CommonListTile(
            invertTitleSubtitleStyles: true,
            titleText: LocaleKeys.receiveWord.tr(),
            subtitleChild: MoneyWidget(
              money: receiveBalance!,
              style: MoneyWidgetStyle.primary,
              signValue: receiveBalance!.amount == Fixed.zero ? '' : '~',
            ),
          ),
        if (apy != null)
          CommonListTile(
            invertTitleSubtitleStyles: true,
            titleText: LocaleKeys.averageApy.tr(),
            // ignore: no-magic-number
            subtitleText: '${apy!.toStringAsFixed(2)} %',
          ),
      ],
    );
  }
}
