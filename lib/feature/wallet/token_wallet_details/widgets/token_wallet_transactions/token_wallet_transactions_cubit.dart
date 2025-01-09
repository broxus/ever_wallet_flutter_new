import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/core/bloc/bloc_mixin.dart';
import 'package:app/data/models/custom_currency.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'token_wallet_transactions_cubit.freezed.dart';
part 'token_wallet_transactions_state.dart';

/// Cubit that allows mapping transactions for [TokenWallet] from storage to UI
/// elements.
class TokenWalletTransactionsCubit extends Cubit<TokenWalletTransactionsState>
    with BlocBaseMixin {
  TokenWalletTransactionsCubit({
    required this.owner,
    required this.rootTokenContract,
    required this.nekotonRepository,
    required this.currenciesService,
    required this.walletStorage,
  }) : super(const TokenWalletTransactionsState.loading()) {
    _init();
    _walletSubscription = Rx.combineLatest2<TokenWalletState?,
        TransportStrategy, (TokenWalletState?, TransportStrategy)>(
      nekotonRepository.tokenWalletsStream.map(
        (wallets) => wallets.firstWhereOrNull(
          (w) => w.owner == owner && w.rootTokenContract == rootTokenContract,
        ),
      ),
      nekotonRepository.currentTransportStream,
      (a, b) => (a, b),
    ).listen(
      (value) async {
        final wallet = value.$1?.wallet;
        final transport = value.$2.transport;

        if (wallet == null) {
          _closeSubs();
          return;
        }

        if (!wallet.isTransactionsPreloaded) {
          await wallet.preloadTransactions();
        }

        _createSubs(wallet, transport);
      },
    );
  }

  final _logger = Logger('TokenWalletTransactionsCubit');

  final Address owner;
  final Address rootTokenContract;
  final NekotonRepository nekotonRepository;
  final CurrenciesService currenciesService;
  final TokenWalletStorageService walletStorage;

  TransportStrategy get _transport => nekotonRepository.currentTransport;

  /// If not null, then [_transactionsState] will check for coming new
  /// transactions and there is no new, then canLoadMore will be false.
  String? _lastLtWhenPreloaded;
  CustomCurrency? _tokenCustomCurrency;

  /// Called from UI when user scrolled to the end of the list.
  /// NOTE: this method may be called multiple times
  void tryPreloadTransactions() {
    final lastPrevLt = state.whenOrNull(
      transactions: (
        transactions,
        _,
        __,
        ___,
        ____,
      ) =>
          _lastLt(transactions),
    );
    final (isLoading, canLoadMore) = state.maybeWhen(
      transactions: (_, __, isLoading, canLoadMore, ___) =>
          (isLoading, canLoadMore),
      orElse: () => (true, false),
    );

    if (isLoading || !canLoadMore || lastPrevLt == null) {
      return;
    }

    _preloadTransactions(lastPrevLt);
  }

  // ignore: use_late_for_private_fields_and_variables
  Currency? _cachedCurrency;

  /// List of ordinary transactions and flag that sign that transactions was
  /// loaded and mapped.
  bool _ordinaryLoaded = false;
  List<TokenWalletOrdinaryTransaction> _ordinary = [];

  StreamSubscription<dynamic>? _ordinaryTransactionsSub;
  late StreamSubscription<dynamic> _walletSubscription;

  @override
  Future<void> close() {
    _closeSubs();
    _walletSubscription.cancel();

    return super.close();
  }

  void _closeSubs() {
    _ordinaryTransactionsSub?.cancel();
  }

  Future<void> _init() async {
    _tokenCustomCurrency = await currenciesService.getOrFetchCurrency(
      _transport,
      rootTokenContract,
    );
  }

  void _createSubs(GenericTokenWallet wallet, Transport transport) {
    _closeSubs();

    _ordinaryTransactionsSub = Rx.combineLatest2<
        void,
        List<TransactionWithData<TokenWalletTransaction?>>?,
        List<TransactionWithData<TokenWalletTransaction?>>>(
      wallet.fieldUpdatesStream,
      walletStorage.transactionsStream(
        networkId: transport.networkId,
        group: transport.group,
        owner: owner,
        rootTokenContract: rootTokenContract,
      ),
      (_, b) => b ?? [],
    ).listen(
      (transactions) {
        _ordinary = nekotonRepository.mapOrdinaryTokenTransactions(
          rootTokenContract: rootTokenContract,
          transactions: transactions,
        );

        _ordinaryLoaded = true;

        _checkState(wallet.moneyBalance.currency);
      },
    );
  }

  void _checkState(Currency currency) {
    if (_ordinaryLoaded) {
      _cachedCurrency = currency;
      _transactionsState(fromStream: true);
    } else {
      emitSafe(const TokenWalletTransactionsState.loading());
    }
  }

  void _transactionsState({
    bool fromStream = false,
    bool isLoading = false,
  }) {
    if (_ordinary.isEmpty) {
      emitSafe(const TokenWalletTransactionsState.empty());
    } else {
      final transactions = [..._ordinary]
        ..sort((a, b) => b.date.compareTo(a.date));

      var canLoadMore = state.maybeWhen(
        transactions: (_, __, ___, canLoadMore, ____) => canLoadMore,
        orElse: () => true,
      );
      final lastLt = _lastLt(transactions);
      if (_lastLtWhenPreloaded != null && !isLoading && fromStream) {
        // we must check this state every time, because we may have multiple
        // inputs for this method (different transactions streams, but not now,
        // just copied from <AccountTransactionsTabCubit>)
        // and this why we do not assign null to <_lastLtWhenPreloaded>
        canLoadMore = lastLt != _lastLtWhenPreloaded;
      }

      emitSafe(
        TokenWalletTransactionsState.transactions(
          transactions: transactions,
          tokenCurrency: _cachedCurrency!,
          isLoading: isLoading,
          canLoadMore: canLoadMore,
          tokenCustomCurrency: _tokenCustomCurrency,
        ),
      );
    }
  }

  /// Get last available prevTransactionLt
  String? _lastLt(
    List<TokenWalletOrdinaryTransaction> transactions,
  ) =>
      transactions
          .lastWhereOrNull((t) => t.prevTransactionLt != null)
          ?.prevTransactionLt;

  Future<void> _preloadTransactions(String lastPrevLt) async {
    _transactionsState(isLoading: true);
    _lastLtWhenPreloaded = lastPrevLt;

    try {
      await nekotonRepository.preloadTokenTransactions(
        owner: owner,
        rootTokenContract: rootTokenContract,
        fromLt: lastPrevLt,
      );
    } catch (e, t) {
      _logger.severe('_preloadTransactions', e, t);
    } finally {
      _transactionsState();
    }
  }
}
