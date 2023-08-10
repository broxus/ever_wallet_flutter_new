import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'token_wallet_transactions_state.dart';

part 'token_wallet_transactions_cubit.freezed.dart';

/// Cubit that allows mapping transactions for [TokenWallet] from storage to UI
/// elements.
class TokenWalletTransactionsCubit extends Cubit<TokenWalletTransactionsState> {
  TokenWalletTransactionsCubit({
    required this.owner,
    required this.rootTokenContract,
    required this.nekotonRepository,
    required this.walletStorage,
  }) : super(const TokenWalletTransactionsState.loading()) {
    _walletSubscription = Rx.combineLatest2<TokenWallet?, TransportStrategy,
        (TokenWallet?, TransportStrategy)>(
      nekotonRepository.tokenWalletsStream.map(
        (wallets) => wallets.firstWhereOrNull(
          (w) => w.owner == owner && w.rootTokenContract == rootTokenContract,
        ),
      ),
      nekotonRepository.currentTransportStream,
      (a, b) => (a, b),
    ).listen(
      (value) {
        final wallet = value.$1;
        final transport = value.$2.transport;

        if (wallet == null) {
          _closeSubs();

          return;
        }

        _createSubs(wallet, transport);
      },
    );
  }

  final Address owner;
  final Address rootTokenContract;
  final NekotonRepository nekotonRepository;
  final TokenWalletStorageService walletStorage;

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

  void _createSubs(TokenWallet wallet, Transport transport) {
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
      _transactionsState(currency);
    } else {
      emit(const TokenWalletTransactionsState.loading());
    }
  }

  void _transactionsState(Currency currency) {
    if (_ordinary.isEmpty) {
      emit(const TokenWalletTransactionsState.empty());
    } else {
      final transactions = [..._ordinary]
        ..sort((a, b) => b.date.compareTo(a.date));

      emit(TokenWalletTransactionsState.transactions(transactions, currency));
    }
  }
}
