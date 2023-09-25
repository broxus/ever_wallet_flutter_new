import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'account_card_cubit_state.dart';

part 'account_card_cubit.freezed.dart';

const _withdrawUpdateDebounce = Duration(seconds: 3);

/// Cubit that will be listen for subscriptions from [NekotonRepository] and
/// provides [TonWallet] to ui.
class AccountCardCubit extends Cubit<AccountCardState> {
  AccountCardCubit(
    this.nekotonRepository,
    this.account,
    this.balanceService,
    this.currencyConvertService,
  ) : super(
          AccountCardState.data(
            account: account,
            walletName: _walletName(nekotonRepository, account),
          ),
        ) {
    _walletsSubscription = nekotonRepository.walletsStream.listen((wallets) {
      final wl = wallets.firstWhereOrNull((w) => w.address == account.address);
      if (wl != null) _initWallet(wl);
    });
  }

  final CurrencyConvertService currencyConvertService;
  final BalanceService balanceService;
  final NekotonRepository nekotonRepository;
  final KeyAccount account;

  late StreamSubscription<List<TonWallet>> _walletsSubscription;
  StreamSubscription<void>? _thisWalletSubscription;
  StreamSubscription<void>? _withdrawRequestSubscription;
  StreamSubscription<Fixed>? _balanceSubscription;

  Fixed _cachedFiatBalance = Fixed.zero;

  TonWallet? wallet;

  void _initWallet(TonWallet w) {
    if (wallet != null &&
        wallet!.transport.connectionParamsHash ==
            w.transport.connectionParamsHash) {
      return;
    }

    _closeSubs();

    wallet = w;
    _thisWalletSubscription =
        w.fieldUpdatesStream.listen((_) => _updateWalletData(w));
    _withdrawRequestSubscription =
        w.fieldUpdatesStream.debounceTime(_withdrawUpdateDebounce).listen((_) {
      if (nekotonRepository.currentTransport.stakeInformation != null) {
        inject<StakingService>().tryUpdateWithdraws(account.address);
      }
    });
    _balanceSubscription =
        balanceService.accountOverallBalance(w.address).listen((fiat) {
      if (fiat == Fixed.zero && _cachedFiatBalance == Fixed.zero) {
        return;
      }

      _cachedFiatBalance = fiat;
      _updateWalletData(w);
    });

    _updateWalletData(w);
  }

  void _updateWalletData(TonWallet w) {
    final balance = _cachedFiatBalance;
    final custodians = w.custodians;
    final localCustodians =
        nekotonRepository.getLocalCustodians(account.address);
    // count of local custodians of count of real custodians, works
    // only for multisig wallets
    final custodiansString =
        custodians != null && custodians.length > 1 && localCustodians != null
            ? '${localCustodians.length}/${custodians.length}'
            : null;

    final money = currencyConvertService.convert(balance);

    emit(
      AccountCardState.data(
        account: account,
        walletName: _walletName(nekotonRepository, account),
        balance: money,
        custodiansString: custodiansString,
      ),
    );
  }

  @override
  Future<void> close() {
    _walletsSubscription.cancel();
    _closeSubs();

    return super.close();
  }

  void _closeSubs() {
    _thisWalletSubscription?.cancel();
    _balanceSubscription?.cancel();
    _withdrawRequestSubscription?.cancel();
  }

  static String _walletName(NekotonRepository repo, KeyAccount account) {
    return repo.currentTransport
        .defaultAccountName(account.account.tonWallet.contract)
        .toLowerCase();
  }
}
