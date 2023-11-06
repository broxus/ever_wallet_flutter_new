import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'account_detail_state.dart';

part 'account_detail_cubit.freezed.dart';

/// Cubit for account detail page
class AccountDetailCubit extends Cubit<AccountDetailState> {
  AccountDetailCubit({
    required this.address,
    required this.nekotonRepository,
    required this.balanceService,
    required this.convertService,
    required this.currentAccountsService,
  }) : super(const AccountDetailState.initial());

  final Address address;
  final NekotonRepository nekotonRepository;
  final BalanceService balanceService;
  final CurrencyConvertService convertService;
  final CurrentAccountsService currentAccountsService;

  late StreamSubscription<SeedList> _seedListSubscription;
  StreamSubscription<dynamic>? _balanceSub;

  void init() {
    _seedListSubscription =
        nekotonRepository.seedListStream.listen(_updateSeedState);
  }

  void _updateSeedState(SeedList list) {
    final account = list.findAccountByAddress(address);
    if (account == null) {
      _cachedAccount = null;
      _closeBalanceSubs();
      emit(const AccountDetailState.empty());
    } else {
      _cachedAccount = account;
      _checkBalanceSub(account);
      _updateDataState();
    }
  }

  void _updateDataState() {
    if (isClosed) return;
    emit(AccountDetailState.data(_cachedAccount!, _cachedBalance));
  }

  Transport? _lastTransport;
  KeyAccount? _cachedAccount;
  late Money _cachedBalance = convertBalance(Fixed.zero);

  bool _subCreatedManually = false;

  /// used to listen balances
  // ignore: unused_field
  TonWallet? _tonWallet;
  final List<TokenWalletState> _tokenWallets = [];

  void _checkBalanceSub(KeyAccount account) {
    // no transport or transport changed
    if (_lastTransport == null ||
        nekotonRepository.currentTransport.transport.name !=
            _lastTransport!.name) {
      _cachedBalance = convertBalance(Fixed.zero);
      _lastTransport = nekotonRepository.currentTransport.transport;
      final currentAccounts = currentAccountsService.currentAccounts;

      _balanceSub =
          balanceService.accountOverallBalance(address).listen((balance) {
        _cachedBalance = convertBalance(balance);
        _updateDataState();
      });

      // if we explore not current account for which subscriptions are created
      // automatically, create subs
      if (currentAccounts != null &&
          !currentAccounts.displayAccounts
              .map((e) => e.address)
              .contains(address)) {
        _subCreatedManually = true;
        _subscribeNative();

        final networkGroup = _lastTransport!.group;
        final wallets = account.additionalAssets[networkGroup]?.tokenWallets;

        if (wallets != null) {
          for (final wallet in wallets) {
            _subscribeToken(wallet.rootTokenContract);
          }
        }
      }
    }
  }

  Future<void> _subscribeNative() async {
    final wallet = (await nekotonRepository.subscribeByAddress(address)).wallet;
    // for cases, when screen was closed before sub completed
    if (isClosed) {
      nekotonRepository.unsubscribe(address);
    } else {
      _tonWallet = wallet;
    }
  }

  Future<void> _subscribeToken(Address rootTokenContract) async {
    final token = await nekotonRepository.subscribeToken(
      owner: address,
      rootTokenContract: rootTokenContract,
    );

    // for cases, when screen was closed before sub completed
    if (isClosed) {
      nekotonRepository.unsubscribeToken(
        token.owner,
        token.rootTokenContract,
      );
    } else {
      _tokenWallets.add(token);
    }
  }

  Money convertBalance(Fixed amount) {
    return convertService.convert(amount);
  }

  void _closeBalanceSubs() {
    _balanceSub?.cancel();
    if (_subCreatedManually) {
      _tonWallet = null;
      nekotonRepository.unsubscribe(address);
      _tokenWallets.removeWhere((token) {
        nekotonRepository.unsubscribeToken(
          token.owner,
          token.rootTokenContract,
        );

        return true;
      });
    }
  }

  @override
  Future<void> close() {
    _seedListSubscription.cancel();

    return super.close();
  }
}
