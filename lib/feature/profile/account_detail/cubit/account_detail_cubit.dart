import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/core/bloc/bloc_mixin.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'account_detail_cubit.freezed.dart';

part 'account_detail_state.dart';

/// Cubit for account detail page
class AccountDetailCubit extends Cubit<AccountDetailState> with BlocBaseMixin {
  AccountDetailCubit({
    required this.address,
    required this.nekotonRepository,
    required this.balanceService,
    required this.convertService,
  }) : super(const AccountDetailState.initial());

  final _logger = Logger('AccountDetailCubit');

  final Address address;
  final NekotonRepository nekotonRepository;
  final BalanceService balanceService;
  final CurrencyConvertService convertService;

  late StreamSubscription<SeedList> _seedListSubscription;
  StreamSubscription<dynamic>? _balanceSub;
  List<PublicKey> _custodianKeys = [];
  List<SeedKey> _custodians = [];

  void init() {
    _seedListSubscription =
        nekotonRepository.seedListStream.listen(_updateSeedState);
    _findCustodians();
  }

  void _updateSeedState(SeedList list) {
    final account = list.findAccountByAddress(address);

    if (_custodianKeys.isNotEmpty) {
      _custodians = _custodianKeys
          .map((e) => nekotonRepository.seedList.findSeedKey(e))
          .nonNulls
          .toList();
    }

    if (account == null) {
      _cachedAccount = null;
      _closeBalanceSubs();
      emitSafe(const AccountDetailState.empty());
    } else {
      _cachedAccount = account;
      _checkBalanceSub(account);
      _updateDataState();
    }
  }

  void _updateDataState() {
    if (isClosed) return;
    emitSafe(
      AccountDetailState.data(
        _cachedAccount!,
        _cachedBalance,
        _custodians,
      ),
    );
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

      _balanceSub =
          balanceService.accountOverallBalance(address).listen((balance) {
        if (balance == null) {
          return;
        }
        _cachedBalance = convertBalance(balance);
        _updateDataState();
      });

      // if we explore not current account for which subscriptions are created
      // automatically, create subs
      if (!nekotonRepository.walletsMap.containsKey(address)) {
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
    try {
      final wallet =
          (await nekotonRepository.subscribeByAddress(address)).wallet;
      // for cases, when screen was closed before sub completed
      if (isClosed) {
        nekotonRepository.unsubscribe(address);
      } else {
        _tonWallet = wallet;
      }
    } catch (_) {}
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
    _balanceSub?.cancel();

    return super.close();
  }

  Future<void> _findCustodians() async {
    try {
      final account = nekotonRepository.seedList.findAccountByAddress(address);
      final custodians =
          await nekotonRepository.getLocalCustodiansAsync(address);

      if (custodians != null && custodians.isNotEmpty) {
        _custodianKeys = custodians
          ..removeWhere((k) => k == account?.publicKey);
        _updateSeedState(nekotonRepository.seedList);
      }
    } catch (e, t) {
      _logger.severe('_findCustodians', e, t);
    }
  }
}
