import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/core/bloc/bloc_mixin.dart';
import 'package:app/data/models/custom_currency.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/models/account_transaction_item.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'account_transactions_tab_cubit.freezed.dart';
part 'account_transactions_tab_state.dart';

/// Cubit for <AccountTransactionsTab> that allows displaying list of
/// transactions for TonWallet for [account].
class AccountTransactionsTabCubit extends Cubit<AccountTransactionsTabState>
    with BlocBaseMixin {
  AccountTransactionsTabCubit({
    required this.walletStorage,
    required this.nekotonRepository,
    required this.currenciesService,
    required this.account,
  }) : super(const AccountTransactionsTabState.loading()) {
    _walletSubscription = Rx.combineLatest2<TonWalletState?, TransportStrategy,
        (TonWalletState?, TransportStrategy)>(
      nekotonRepository.walletsStream.map(
        (wallets) =>
            wallets.firstWhereOrNull((w) => w.address == account.address),
      ),
      nekotonRepository.currentTransportStream,
      (a, b) => (a, b),
    ).listen(
      (value) {
        final wallet = value.$1?.wallet;
        final transport = value.$2.transport;

        if (wallet == null) {
          _closeSubs();

          return;
        }

        _createSubs(wallet, transport);
      },
    );
    _initNativeCurrency();
  }

  final _logger = Logger('AccountTransactionsTabCubit');
  final TonWalletStorageService walletStorage;
  final NekotonRepository nekotonRepository;
  final CurrenciesService currenciesService;
  final KeyAccount account;
  CustomCurrency? _nativeCurrency;

  TransportStrategy get _transport => nekotonRepository.currentTransport;

  /// If not null, then [_transactionsState] will check for coming new
  /// transactions and there is no new, then canLoadMore will be false.
  String? _lastLtWhenPreloaded;

  /// List of multisig transactions and flag that sign that multisig
  /// transactions was loaded and mapped.
  bool _multisigLoaded = false;
  List<TonWalletMultisigOrdinaryTransaction> _multisigOrdinary = [];
  List<TonWalletMultisigPendingTransaction> _multisigPending = [];
  List<TonWalletMultisigExpiredTransaction> _multisigExpired = [];

  bool _ordinaryLoaded = false;
  List<TonWalletOrdinaryTransaction> _ordinary = [];

  bool _pendingLoaded = false;
  List<TonWalletPendingTransaction> _pending = [];

  bool _expiredLoaded = false;
  List<TonWalletExpiredTransaction> _expired = [];

  StreamSubscription<dynamic>? _ordinaryTransactionsSub;
  StreamSubscription<dynamic>? _expiredTransactionsSub;
  StreamSubscription<dynamic>? _pendingTransactionsSub;
  StreamSubscription<dynamic>? _multisigTransactionsSub;
  StreamSubscription<dynamic>? _walletSubscription;

  /// Called from UI when user scrolled to the end of the list.
  /// NOTE: this method may be called multiple times
  void tryPreloadTransactions() {
    final lastPrevLt = state.whenOrNull(
      transactions: (transactions, _, __, ___) => _lastLt(transactions),
    );
    final (isLoading, canLoadMore) = state.maybeWhen(
      transactions: (_, isLoading, canLoadMore, ___) =>
          (isLoading, canLoadMore),
      orElse: () => (true, false),
    );
    if (isLoading || !canLoadMore || lastPrevLt == null) {
      return;
    }

    _preloadTransactions(lastPrevLt);
  }

  @override
  Future<void> close() {
    _closeSubs();
    _walletSubscription?.cancel();

    return super.close();
  }

  void _closeSubs() {
    _multisigTransactionsSub?.cancel();
    _ordinaryTransactionsSub?.cancel();
    _expiredTransactionsSub?.cancel();
    _pendingTransactionsSub?.cancel();
  }

  Future<void> _initNativeCurrency() async {
    _nativeCurrency =
        await currenciesService.getOrFetchNativeCurrency(_transport);
  }

  // ignore: long-method
  void _createSubs(TonWallet wallet, Transport transport) {
    _closeSubs();

    _multisigTransactionsSub = Rx.combineLatest2<
        void,
        List<TransactionWithData<TransactionAdditionalInfo?>>?,
        List<TransactionWithData<TransactionAdditionalInfo?>>>(
      wallet.fieldUpdatesStream,
      walletStorage.transactionsStream(
        networkId: transport.networkId,
        group: transport.group,
        address: wallet.address,
      ),
      (_, b) => b ?? [],
    ).listen(
      (transactions) async {
        final multisigTransactions = wallet.unconfirmedTransactions;

        try {
          _multisigExpired =
              await nekotonRepository.mapMultisigExpiredTransactions(
            walletAddress: wallet.address,
            transactions: transactions,
            multisigPendingTransactions: multisigTransactions,
          );
        } catch (_) {}
        try {
          _multisigOrdinary =
              await nekotonRepository.mapMultisigOrdinaryTransactions(
            walletAddress: wallet.address,
            transactions: transactions,
            multisigPendingTransactions: multisigTransactions,
          );
        } catch (_) {}

        try {
          _multisigPending =
              await nekotonRepository.mapMultisigPendingTransactions(
            walletAddress: wallet.address,
            transactions: transactions,
            multisigPendingTransactions: multisigTransactions,
          );
        } catch (_) {}

        _multisigLoaded = true;

        _checkState();
      },
    );

    _pendingTransactionsSub = walletStorage
        .pendingTransactionsStream(
      networkId: transport.networkId,
      group: transport.group,
      address: wallet.address,
    )
        .listen(
      (pending) {
        _pending = nekotonRepository.mapPendingTransactions(
          walletAddress: wallet.address,
          pendingTransactions: pending ?? [],
        );
        _pendingLoaded = true;

        _checkState();
      },
    );

    _expiredTransactionsSub = walletStorage
        .expiredTransactionsStream(
      networkId: transport.networkId,
      group: transport.group,
      address: wallet.address,
    )
        .listen(
      (expired) {
        _expired = nekotonRepository.mapExpiredTransactions(
          walletAddress: wallet.address,
          expiredTransactions: expired ?? [],
        );
        _expiredLoaded = true;

        _checkState();
      },
    );

    _ordinaryTransactionsSub = walletStorage
        .transactionsStream(
      networkId: transport.networkId,
      group: transport.group,
      address: wallet.address,
    )
        .listen(
      (ordinary) {
        _ordinary = nekotonRepository.mapOrdinaryTransactions(
          walletAddress: wallet.address,
          transactions: ordinary ?? [],
        );
        _ordinaryLoaded = true;

        _checkState();
      },
    );
  }

  void _checkState() {
    if (_multisigLoaded &&
        _pendingLoaded &&
        _expiredLoaded &&
        _ordinaryLoaded) {
      _transactionsState(fromStream: true);
    } else {
      emitSafe(const AccountTransactionsTabState.loading());
    }
  }

  // ignore: long-method
  void _transactionsState({
    bool fromStream = false,
    bool isLoading = false,
  }) {
    if (_multisigExpired.isEmpty &&
        _multisigPending.isEmpty &&
        _multisigOrdinary.isEmpty &&
        _expired.isEmpty &&
        _pending.isEmpty &&
        _ordinary.isEmpty) {
      emitSafe(const AccountTransactionsTabState.empty());
    } else {
      final transactions = [
        ..._multisigOrdinary.map(
          (e) => AccountTransactionItem(
            date: e.date,
            transaction: e,
            prevTransactionLt: e.prevTransactionLt,
            type: AccountTransactionType.multisigOrdinary,
          ),
        ),
        ..._multisigPending.map(
          (e) => AccountTransactionItem(
            date: e.date,
            transaction: e,
            prevTransactionLt: e.prevTransactionLt,
            type: AccountTransactionType.multisigPending,
          ),
        ),
        ..._multisigExpired.map(
          (e) => AccountTransactionItem(
            date: e.date,
            transaction: e,
            prevTransactionLt: e.prevTransactionLt,
            type: AccountTransactionType.multisigExpired,
          ),
        ),
        ..._ordinary.map(
          (e) => AccountTransactionItem(
            date: e.date,
            transaction: e,
            prevTransactionLt: e.prevTransactionLt,
            type: AccountTransactionType.ordinary,
          ),
        ),
        ..._pending.map(
          (e) => AccountTransactionItem(
            date: e.date,
            transaction: e,
            prevTransactionLt: null,
            type: AccountTransactionType.pending,
          ),
        ),
        ..._expired.map(
          (e) => AccountTransactionItem(
            date: e.date,
            transaction: e,
            prevTransactionLt: null,
            type: AccountTransactionType.expired,
          ),
        ),
      ]..sort((a, b) => b.compareTo(a));

      var canLoadMore = state.maybeWhen(
        transactions: (_, __, canLoadMore, ___) => canLoadMore,
        orElse: () => true,
      );
      final lastLt = _lastLt(transactions);

      if (_lastLtWhenPreloaded != null && !isLoading && fromStream) {
        // we must check this state every time, because we have multiple
        // inputs for this method (different transactions streams) and this why
        // we do not assign null to <_lastLtWhenPreloaded>
        canLoadMore = lastLt != _lastLtWhenPreloaded;
      }

      emitSafe(
        AccountTransactionsTabState.transactions(
          transactions: transactions,
          isLoading: isLoading,
          canLoadMore: canLoadMore,
          price: Fixed.parse(_nativeCurrency?.price ?? '0'),
        ),
      );
    }
  }

  /// Get last available prevTransactionLt
  String? _lastLt(
    List<AccountTransactionItem<dynamic>> transactions,
  ) =>
      transactions
          .lastWhereOrNull((t) => t.prevTransactionLt != null)
          ?.prevTransactionLt;

  Future<void> _preloadTransactions(String lastPrevLt) async {
    _transactionsState(isLoading: true);
    _lastLtWhenPreloaded = lastPrevLt;

    try {
      await nekotonRepository.preloadTransactions(
        address: account.address,
        fromLt: lastPrevLt,
      );
    } catch (e, t) {
      _logger.severe('_preloadTransactions', e, t);
    } finally {
      _transactionsState();
    }
  }
}
