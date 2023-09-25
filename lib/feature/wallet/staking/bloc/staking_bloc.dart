// ignore_for_file: no-magic-number
import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/wallet/staking/staking.dart';
import 'package:app/generated/generated.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_event_transformers/bloc_event_transformers.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'staking_bloc_state.dart';
part 'staking_bloc_event.dart';
part 'staking_bloc.freezed.dart';

const _defaultWithdrawHours = 36;

enum StakingPageType { stake, unstake, inProgress }

class StakingBloc extends Bloc<StakingBlocEvent, StakingBlocState> {
  StakingBloc({
    required this.accountAddress,
    required this.nekotonRepository,
    required this.currencyConvert,
    required this.currenciesService,
    required this.stakingService,
    required this.actionBloc,
  }) : super(const StakingBlocState.preparing()) {
    _registerHandlers();
    _inputController
        .addListener(() => add(StakingBlocEvent.updateReceive(_currentValue)));
  }

  final _logger = Logger('StakingBloc');
  final Address accountAddress;
  final NekotonRepository nekotonRepository;
  final CurrencyConvertService currencyConvert;
  final CurrenciesService currenciesService;
  final StakingService stakingService;
  final ActionStakingBloc actionBloc;

  /// Withdraw time of stever in hours.
  /// if original time from 0 to 24, we add 36
  /// if original time > 24, we add 18
  int withdrawHours = _defaultWithdrawHours;

  StakingPageType _type = StakingPageType.stake;
  final _inputController = TextEditingController();

  /// Wallet is used to get balance and currency
  late TonWallet _everWallet;
  late CustomCurrency _everWalletCurrency;

  late TokenWallet _stEverWallet;
  late CustomCurrency _stEverWalletCurrency;

  late StEverDetails _details;
  Money? _receive;
  List<StEverWithdrawRequest> _requests = [];
  StreamSubscription<dynamic>? _requestsSub;

  /// Public key that is related to [accountAddress]
  late PublicKey accountPublicKey;
  double apy = 0;

  StakingInformation get staking =>
      nekotonRepository.currentTransport.stakeInformation!;

  void _registerHandlers() {
    on<_Init>((_, emit) => _init(emit));
    on<_SelectMax>((_, emit) => _selectMax());
    on<_UpdateReceive>(
      (event, emit) => _updateReceive(event.value, emit),
      transformer: debounce(const Duration(seconds: 1)),
    );
    on<_UpdateRequests>((event, emit) {
      _requests = event.requests;

      if (_requests.isEmpty && _type == StakingPageType.inProgress) {
        // avoid ui lag
        _type = StakingPageType.stake;
        _inputController.text = '0';
        _emitDataState(emit);
      } else {
        emit(_dataState.copyWith(requests: _requests));
      }
    });

    on<_ChangeTab>(
      (event, emit) {
        if (_type == event.type) return;
        _type = event.type;
        _receive = null;
        _inputController.clear();
        _emitDataState(emit);
        add(StakingBlocEvent.updateReceive(Fixed.zero));
      },
    );
    on<_DoAction>(
      (event, emit) {
        switch (_type) {
          case StakingPageType.stake:
            actionBloc.add(
              ActionStakingBlocEvent.stake(
                amount: _currentValue.minorUnits,
                accountKey: accountPublicKey,
              ),
            );
          case StakingPageType.unstake:
            actionBloc.add(
              ActionStakingBlocEvent.unstake(
                amount: _currentValue.minorUnits,
                accountKey: accountPublicKey,
                withdrawHours: withdrawHours,
              ),
            );
          case StakingPageType.inProgress:
            // do nothing
            break;
        }
      },
    );
  }

  Future<void> _init(Emitter<StakingBlocState> emit) async {
    try {
      final pair = (accountAddress, staking.stakingRootContractAddress);
      final transport = nekotonRepository.currentTransport;
      _everWallet = nekotonRepository.getWallet(accountAddress);

      if (nekotonRepository.tokenWalletsMap[pair] == null) {
        await nekotonRepository.subscribeToken(
          owner: pair.$1,
          rootTokenContract: pair.$2,
        );
      }
      _stEverWallet = nekotonRepository.getTokenWallet(pair.$1, pair.$2);

      _stEverWalletCurrency = (await currenciesService.getCurrencyForContract(
        transport,
        pair.$2,
      ))!;
      _everWalletCurrency = (await currenciesService.getCurrencyForContract(
        transport,
        transport.nativeTokenAddress,
      ))!;
      apy = await stakingService.getAverageAPYPercent();
      _details = await stakingService.getStEverDetails();
      final time =
          Duration(seconds: int.tryParse(_details.withdrawHoldTime) ?? 0)
              .inHours;
      withdrawHours = 0 <= time && time <= 24 ? time + 36 : time + 18;
      final local = nekotonRepository.getLocalCustodians(accountAddress)?.first;
      if (local == null) {
        throw Exception();
      }
      accountPublicKey = local;

      // Do it last because if user don't have address, then method can throw
      // error
      _requestsSub = stakingService
          .withdrawRequestsStream(accountAddress)
          .listen((requests) {
        add(StakingBlocEvent.updateResuests(requests));
      });

      // trigger updating of balances
      _emitDataState(emit);
      add(StakingBlocEvent.updateReceive(Fixed.zero));
    } catch (e, t) {
      _logger.severe('init', e, t);
      emit(const StakingBlocState.initError());
    }
  }

  _StakingState get _dataState => state as _StakingState;

  void _emitDataState(Emitter<StakingBlocState> emit) {
    emit(_stateWithData(_currentValue));
  }

  /// Get input value as Fixed based on [_currentCurrency]
  Fixed get _currentValue {
    return Fixed.fromNum(
      num.tryParse(_inputController.text) ?? 0.0,
      scale: _currentCurrency.scale,
    );
  }

  /// Get currency for [_inputController].
  /// EVER for stake and stEVER for unstake
  Currency get _currentCurrency =>
      _type == StakingPageType.stake ? _nativeCurrency : _stEverWallet.currency;

  Future<void> _updateReceive(
    Fixed value,
    Emitter<StakingBlocState> emit,
  ) async {
    try {
      switch (_type) {
        case StakingPageType.stake:
          final amount =
              await stakingService.getDepositStEverAmount(value.minorUnits);
          _receive = Money.fromBigIntWithCurrency(
            amount,
            _stEverWallet.currency,
          );
        case StakingPageType.unstake:
          final amount =
              await stakingService.getWithdrawEverAmount(value.minorUnits);
          _receive = Money.fromBigIntWithCurrency(
            amount,
            Currencies()[nekotonRepository.currentTransport.nativeTokenTicker]!,
          );
        case StakingPageType.inProgress:
          _receive = null;
      }
    } catch (e, t) {
      _logger.severe('Loading data after updating value', e, t);
    }

    emit(_stateWithData(value));
  }

  // ignore: long-method
  StakingBlocState _stateWithData(Fixed value) {
    Money balance;
    Money enteredPrice;
    BigInt attachedAmount;
    double exchangeRate;
    Currency receiveCurrency;
    var imagePath = '';

    switch (_type) {
      case StakingPageType.stake:
        attachedAmount = staking.stakeDepositAttachedFee;
        balance = Money.fromBigIntWithCurrency(
          _everWallet.contractState.balance,
          _currentCurrency,
        );
        enteredPrice = currencyConvert.convert(
          value * Fixed.parse(_everWalletCurrency.price),
        );
        exchangeRate = _details.stEverSupply / _details.totalAssets;
        imagePath = nekotonRepository.currentTransport.nativeTokenIcon;
        receiveCurrency = _stEverWallet.moneyBalance.currency;
      case StakingPageType.unstake:
        attachedAmount = staking.stakeWithdrawAttachedFee;
        balance = _stEverWallet.moneyBalance;
        enteredPrice = currencyConvert.convert(
          value * Fixed.parse(_stEverWalletCurrency.price),
        );
        exchangeRate = _details.totalAssets / _details.stEverSupply;
        imagePath = Assets.images.stever.stever.path;
        receiveCurrency = _nativeCurrency;
      case StakingPageType.inProgress:
        attachedAmount = staking.stakeRemovePendingWithdrawAttachedFee;
        exchangeRate = _details.totalAssets / _details.stEverSupply;
        receiveCurrency = _stEverWallet.moneyBalance.currency;
        // fake balance
        balance =
            Money.fromBigIntWithCurrency(BigInt.zero, Currency.create('-', 0));
        enteredPrice = currencyConvert.convert(Fixed.zero);
    }

    final canPress = value != Fixed.zero && value < balance.amount;

    return StakingBlocState.data(
      type: _type,
      inputController: _inputController,
      currentBalance: balance,
      enteredPrice: enteredPrice,
      attachedAmount: attachedAmount,
      exchangeRate: exchangeRate,
      imagePath: imagePath,
      requests: _requests,
      receiveBalance: _receive,
      canSubmitAction: canPress,
      withdrawTime: withdrawHours,
      apy: apy,
      receiveCurrency: receiveCurrency,
      accountKey: accountPublicKey,
    );
  }

  void _selectMax() {
    final max = _dataState.currentBalance;
    _inputController.text = max.amount.toString();
  }

  Currency get _nativeCurrency =>
      Currencies()[nekotonRepository.currentTransport.nativeTokenTicker]!;

  @override
  Future<void> close() {
    _inputController.dispose();
    _requestsSub?.cancel();

    return super.close();
  }
}
