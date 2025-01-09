import 'dart:async';

import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/models.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/staking/models/models.dart';
import 'package:app/feature/wallet/staking/staking.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:app/widgets/amount_input/amount_input_asset.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

final _maxPossibleStakeComission = BigInt.parse('100000000'); // 0.1 EVER

StakingPageWidgetModel defaultStakingPageWidgetModelFactory(
  BuildContext context,
) =>
    StakingPageWidgetModel(
      StakingPageModel(
        createPrimaryErrorHandler(context),
        inject(),
        inject(),
        inject(),
        inject(),
        inject(),
      ),
    );

class StakingPageWidgetModel
    extends CustomWidgetModel<StakingPageWidget, StakingPageModel> {
  StakingPageWidgetModel(super.model);

  late final inputController = createTextEditingController();

  final _logger = Logger('StakingPageWidgetModel');
  late final _tab = createValueNotifier(StakingTab.stake);
  late final _info = createEntityNotifier<StakingInfo>()..loading();
  late final _data = createNotifier<StakingData>();
  late final _requests = createNotifierFromStream(
    model.getWithdrawRequests(widget.accountAddress),
  );
  late final _receive = createNotifierFromStream(
    Rx.combineLatestList(
      [_tab.asStream(), inputController.asStream()],
    ).switchMap(
      (_) => _getReceive().asStream().whereNotNull(),
    ),
  );
  late final _isValid = createNotifierFromStream(
    Rx.combineLatestList(
      [_tab.asStream(), _info.asStream(), inputController.asStream()],
    ).map(
      (_) => _validate(),
    ),
  );

  ValueListenable<StakingTab> get tab => _tab;

  ListenableState<List<StEverWithdrawRequest>> get requests => _requests;

  ListenableState<Money> get receive => _receive;

  ListenableState<bool> get isValid => _isValid;

  EntityValueListenable<StakingInfo> get info => _info;

  ListenableState<StakingData> get data => _data;

  ThemeStyleV2 get theme => context.themeStyleV2;

  Currency get nativeCurrency => model.nativeCurrency;

  Currency? get tokenCurrency => _info.value.data?.tokenWallet.currency;

  Fixed get _currentValue =>
      Fixed.tryParse(
        inputController.text.trim().replaceAll(',', '.'),
        scale: _currentCurrency?.decimalDigits ?? 0,
      ) ??
      Fixed.zero;

  Currency? get _currentCurrency => _tab.value == StakingTab.stake
      ? model.nativeCurrency
      : _info.value.data?.tokenWallet.currency;

  Money get _comissionMoney => Money.fromBigIntWithCurrency(
        // around 2.1 EVER
        model.staking.stakeDepositAttachedFee + _maxPossibleStakeComission,
        model.nativeCurrency,
      );

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _init();
  }

  void unfocus() => FocusScope.of(context).unfocus();

  void showHowItWorksSheet() => showStEverHowItWorksSheet(
        context: context,
        info: _info.value.data!,
        nativeTokenTicker: model.transport.nativeTokenTicker,
        nativeTokenIcon: model.transport.nativeTokenIcon,
      );

  // ignore: use_setters_to_change_properties
  void onTabChanged(StakingTab value) {
    _tab.value = value;
    inputController.clear();
    _updateData();
  }

  void onMaxAmount() {
    var max = _data.value?.asset?.balance;

    if (max == null) return;

    if (_tab.value == StakingTab.stake) {
      max = max - _comissionMoney;

      if (max.amount < Fixed.zero) {
        model.showError(
          context,
          LocaleKeys.stakingNotEnoughBalanceToStake.tr(
            args: [
              _comissionMoney.formatImproved(),
              _comissionMoney.currency.isoCode,
            ],
          ),
        );
        return;
      }
    }

    inputController.text = max.formatImproved();
  }

  void onSubmit(ActionStakingBloc bloc) {
    final info = _info.value.data;

    if (info == null) return;

    switch (_tab.value) {
      case StakingTab.stake:
        bloc.addSafe(
          ActionStakingBlocEvent.stake(
            amount: _currentValue.minorUnits,
            accountKey: info.wallet.publicKey,
          ),
        );
      case StakingTab.unstake:
        bloc.addSafe(
          ActionStakingBlocEvent.unstake(
            amount: _currentValue.minorUnits,
            accountKey: info.wallet.publicKey,
            withdrawHours: info.withdrawHours,
          ),
        );
      case StakingTab.inProgress:
        // do nothing
        break;
    }
  }

  Future<void> _init() async {
    try {
      final (ever, token) = await FutureExt.wait2(
        model.getWallet(widget.accountAddress),
        model.getTokenWallet(widget.accountAddress),
      );

      if (ever.hasError || token.hasError) {
        _info.error();
        return;
      }

      final (
        tokenCurrency,
        currency,
        apyValue,
        details,
        tokenContractAsset,
      ) = await FutureExt.wait5(
        model.getTokenCurrency(),
        model.getEverCurrency(),
        model.getAverageAPYPercent(),
        model.getStEverDetails(),
        model.getTokenContractAsset(),
      );

      final time = Duration(
        seconds: int.tryParse(details.withdrawHoldTime) ?? 0,
      ).inHours;

      _info.content(
        StakingInfo(
          wallet: ever.wallet!,
          tokenWallet: token.wallet!,
          currency: currency!,
          tokenCurrency: tokenCurrency!,
          details: details,
          apy: apyValue,
          withdrawHours: 0 <= time && time <= 24 ? time + 36 : time + 18,
          tokenContractAsset: tokenContractAsset,
        ),
      );

      _updateData();
    } on Exception catch (e, t) {
      _logger.severe('init', e, t);
      _info.error(e);
    }
  }

  void _updateData() {
    final info = _info.value.data;

    if (info == null) return;

    final data = switch (_tab.value) {
      StakingTab.stake => StakingData(
          tab: StakingTab.stake,
          attachedAmount: Money.fromBigIntWithCurrency(
            model.staking.stakeDepositAttachedFee,
            model.nativeCurrency,
          ),
          exchangeRate: info.details.stEverSupply / info.details.totalAssets,
          receiveCurrency: info.tokenWallet.currency,
          asset: AmountInputAsset(
            rootTokenContract: model.transport.nativeTokenAddress,
            isNative: true,
            balance: Money.fromBigIntWithCurrency(
              info.wallet.contractState.balance,
              model.nativeCurrency,
            ),
            logoURI: model.transport.nativeTokenIcon,
            title: model.transport.nativeTokenTicker,
            tokenSymbol: model.transport.nativeTokenTicker,
            currency: info.currency,
          ),
        ),
      StakingTab.unstake => StakingData(
          tab: StakingTab.unstake,
          attachedAmount: Money.fromBigIntWithCurrency(
            model.staking.stakeWithdrawAttachedFee,
            model.nativeCurrency,
          ),
          exchangeRate: info.details.totalAssets / info.details.stEverSupply,
          receiveCurrency: model.nativeCurrency,
          asset: AmountInputAsset(
            rootTokenContract: info.tokenWallet.symbol.rootTokenContract,
            isNative: false,
            balance: info.tokenWallet.moneyBalance,
            logoURI: info.tokenContractAsset?.logoURI ??
                Assets.images.tokenDefaultIcon.path,
            title: info.tokenWallet.symbol.fullName,
            tokenSymbol: info.tokenWallet.symbol.name,
            currency: info.tokenCurrency,
          ),
        ),
      StakingTab.inProgress => StakingData(
          tab: StakingTab.inProgress,
          attachedAmount: Money.fromBigIntWithCurrency(
            model.staking.stakeRemovePendingWithdrawAttachedFee,
            model.nativeCurrency,
          ),
          exchangeRate: info.details.totalAssets / info.details.stEverSupply,
          receiveCurrency: info.tokenWallet.currency,
        ),
    };

    _data.accept(data);
  }

  Future<Money?> _getReceive() async {
    final tab = _tab.value;
    final currency = _currentCurrency;
    final value = _currentValue;

    if (currency == null) return null;

    if (value.isZero) {
      return Money.fromBigIntWithCurrency(BigInt.zero, currency);
    }

    final amount = tab == StakingTab.stake
        ? await model.getDepositTokenAmount(value.minorUnits)
        : await model.getWithdrawEverAmount(value.minorUnits);

    return Money.fromBigIntWithCurrency(amount, currency);
  }

  bool _validate() {
    final info = _info.value.data;
    final value = _currentValue;

    if (info == null) return false;

    final balance = switch (_tab.value) {
      StakingTab.stake => Money.fromBigIntWithCurrency(
          info.wallet.contractState.balance,
          model.nativeCurrency,
        ),
      StakingTab.unstake => info.tokenWallet.moneyBalance,
      StakingTab.inProgress => Money.fromBigIntWithCurrency(
          BigInt.zero,
          Currency.create('-', 0),
        ),
    };

    return value != Fixed.zero &&
        value <= balance.amount &&
        // ignore: avoid_bool_literals_in_conditional_expressions
        (_tab.value == StakingTab.stake
            ? balance.amount >= _comissionMoney.amount + value
            : true);
  }
}
