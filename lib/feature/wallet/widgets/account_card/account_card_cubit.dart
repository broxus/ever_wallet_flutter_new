import 'dart:async';

import 'package:app/app/service/connection/group.dart';
import 'package:app/app/service/service.dart';
import 'package:app/core/bloc/bloc_mixin.dart';
import 'package:app/di/di.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'account_card_cubit.freezed.dart';

part 'account_card_cubit_state.dart';

const _withdrawUpdateDebounce = Duration(seconds: 3);

/// Cubit that will be listen for subscriptions from [NekotonRepository] and
/// provides [TonWallet] to ui.
class AccountCardCubit extends Cubit<AccountCardState> with BlocBaseMixin {
  AccountCardCubit({
    required this.nekotonRepository,
    required this.account,
    required this.balanceService,
    required this.currencyConvertService,
    required this.balanceStorage,
  }) : super(
          AccountCardState.data(
            account: account,
            walletName: _walletName(nekotonRepository, account),
          ),
        ) {
    _walletsSubscription = nekotonRepository.currentTransportStream.switchMap(
      (transport) {
        _closeSubs();
        _cachedFiatBalance = balanceStorage.getOverallBalance(
              transport.transport.group,
            )[account.address] ??
            Fixed.zero;
        emitSafe(
          AccountCardState.data(
            account: account,
            walletName: _walletName(nekotonRepository, account),
            balance: currencyConvertService.convert(_cachedFiatBalance),
          ),
        );
        return nekotonRepository.walletsStream;
      },
    ).listen((wallets) {
      final wl = wallets.firstWhereOrNull((w) => w.address == account.address);
      if (wl != null) _initWallet(wl);
    });
  }

  final CurrencyConvertService currencyConvertService;
  final BalanceService balanceService;
  final NekotonRepository nekotonRepository;
  final BalanceStorageService balanceStorage;
  final KeyAccount account;

  late StreamSubscription<List<TonWalletState>> _walletsSubscription;
  StreamSubscription<void>? _thisWalletSubscription;
  StreamSubscription<void>? _withdrawRequestSubscription;
  StreamSubscription<Fixed?>? _balanceSubscription;

  Fixed _cachedFiatBalance = Fixed.zero;

  TonWalletState? walletState;

  NetworkGroup get _networkGroup =>
      nekotonRepository.currentTransport.transport.group;

  Future<void> retry() async {
    final st = state;
    if (st is _SubscribeError) {
      emitSafe(st.copyWith(isLoading: true));
      await nekotonRepository.retrySubscriptions(account.address);
      emitSafe(st.copyWith(isLoading: false));
    }
  }

  void _initWallet(TonWalletState wState) {
    _closeSubs();

    walletState = wState;

    if (wState.hasError) {
      emitSafe(
        AccountCardState.subscribeError(
          account: account,
          walletName: _walletName(nekotonRepository, account),
          error: wState.error!,
          isLoading: false,
        ),
      );
    } else {
      final wallet = wState.wallet!;

      _thisWalletSubscription =
          wallet.fieldUpdatesStream.listen((_) => _updateWalletData(wallet));
      _withdrawRequestSubscription = wallet.fieldUpdatesStream
          .debounceTime(_withdrawUpdateDebounce)
          .listen((_) {
        if (nekotonRepository.currentTransport.stakeInformation != null) {
          inject<StakingService>().tryUpdateWithdraws(account.address);
        }
      });
      _balanceSubscription =
          balanceService.accountOverallBalance(wState.address).listen((fiat) {
        if (fiat == null ||
            (fiat == Fixed.zero && _cachedFiatBalance == Fixed.zero)) {
          return;
        }
        _cachedFiatBalance = fiat;
        _updateWalletData(wallet);

        balanceStorage.setOverallBalance(
          group: _networkGroup,
          accountAddress: account.address,
          balance: fiat,
        );
      });

      _updateWalletData(wallet);
    }
  }

  void _updateWalletData(TonWallet w) {
    final balance = _cachedFiatBalance;
    final custodians = w.custodians;
    final confirms = w.details.requiredConfirmations;

    // count of custodians required to complete transaction, works
    // only for multisig wallets
    final custodiansString =
        custodians != null && custodians.length > 1 && confirms != null
            ? '$confirms/${custodians.length}'
            : null;

    final money = currencyConvertService.convert(balance);

    emitSafe(
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
