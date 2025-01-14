import 'package:app/app/service/service.dart';
import 'package:app/app/service/storage_service/ton_wallet_storage_service/ton_wallet_storage_info.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

/// Implementation of storage that stores TonWallet transactions and information
/// about it.
@singleton
class TonWalletStorageService extends TonWalletTransactionsStorage
    implements AbstractStorageService {
  /// Transactions for TonWallet, where key - wallet information, value - list
  /// of all completed.
  final _transactionsSubject = BehaviorSubject<
      Map<TonWalletStorageInfo,
          List<TransactionWithData<TransactionAdditionalInfo?>>>>.seeded({});

  /// Get stream of transactions for TonWallet specified by address and network
  Stream<List<TransactionWithData<TransactionAdditionalInfo?>>?>
      transactionsStream({
    required int networkId,
    required String group,
    required Address address,
  }) =>
          _transactionsSubject.map(
            (event) => event[TonWalletStorageInfo(
              networkId: networkId,
              group: group,
              address: address,
            )],
          );

  /// Transactions for TonWallet, where key - wallet information, value - list
  /// of pended transactions.
  final _pendingTransactionsSubject = BehaviorSubject<
      Map<TonWalletStorageInfo, List<PendingTransactionWithData>>>.seeded({});

  /// Get stream of transactions for TonWallet specified by address and network
  Stream<List<PendingTransactionWithData>?> pendingTransactionsStream({
    required int networkId,
    required String group,
    required Address address,
  }) =>
      _pendingTransactionsSubject.map(
        (event) => event[TonWalletStorageInfo(
          networkId: networkId,
          group: group,
          address: address,
        )],
      );

  /// Transactions for TonWallet, where key - wallet information, value - list
  /// of expired transactions.
  final _expiredTransactionsSubject = BehaviorSubject<
      Map<TonWalletStorageInfo, List<PendingTransactionWithData>>>.seeded({});

  /// Get stream of transactions for TonWallet specified by address and network
  Stream<List<PendingTransactionWithData>?> expiredTransactionsStream({
    required int networkId,
    required String group,
    required Address address,
  }) =>
      _expiredTransactionsSubject.map(
        (event) => event[TonWalletStorageInfo(
          networkId: networkId,
          group: group,
          address: address,
        )],
      );

  /// Right now this method is not needed, it will be used later
  @override
  // ignore: no-empty-block
  Future<void> init() async {}

  @override
  Future<void> clear() async {
    _transactionsSubject.add({});
    _pendingTransactionsSubject.add({});
    _expiredTransactionsSubject.add({});
  }

  @override
  Future<void> addExpiredTransaction({
    required int networkId,
    required String group,
    required Address address,
    required PendingTransactionWithData transaction,
  }) async {
    final info = TonWalletStorageInfo(
      networkId: networkId,
      group: group,
      address: address,
    );
    final values = _expiredTransactionsSubject.value;
    final existed = values[info];
    values[info] = {...?existed, transaction}.toList()
      ..sort(
        // new transactions in the beginning
        (a, b) => b.createdAt.compareTo(a.createdAt),
      );
    _expiredTransactionsSubject.add(values);
  }

  @override
  Future<void> addFoundTransactions({
    required int networkId,
    required String group,
    required Address address,
    required List<TransactionWithData<TransactionAdditionalInfo?>> transaction,
  }) async {
    final info = TonWalletStorageInfo(
      networkId: networkId,
      group: group,
      address: address,
    );
    final values = _transactionsSubject.value;
    final existed = values[info];
    values[info] = {...?existed, ...transaction}.toList()
      ..sort(
        // new transactions in the beginning
        (a, b) => b.transaction.createdAt.compareTo(a.transaction.createdAt),
      );
    _transactionsSubject.add(values);
  }

  @override
  Future<void> addPendingTransaction({
    required int networkId,
    required String group,
    required Address address,
    required PendingTransactionWithData transaction,
  }) async {
    final info = TonWalletStorageInfo(
      networkId: networkId,
      group: group,
      address: address,
    );
    final values = _pendingTransactionsSubject.value;
    final existed = values[info];
    values[info] = {...?existed, transaction}.toList()
      ..sort(
        // new transactions in the beginning
        (a, b) => b.createdAt.compareTo(a.createdAt),
      );
    _pendingTransactionsSubject.add(values);
  }

  @override
  Future<PendingTransactionWithData?> deletePendingTransaction({
    required int networkId,
    required String group,
    required Address address,
    required String messageHash,
  }) async {
    final info = TonWalletStorageInfo(
      networkId: networkId,
      group: group,
      address: address,
    );
    final values = _pendingTransactionsSubject.value;
    final existed = values[info];
    final index =
        existed?.indexWhere((t) => t.transaction.messageHash == messageHash);
    if (index != null && index != -1 && existed != null) {
      final removed = existed.removeAt(index);

      _pendingTransactionsSubject.add(values);

      return removed;
    }

    return null;
  }

  /// Add it later to storage
  @override
  Future<void> updateTonWalletDetails({
    required int networkId,
    required String group,
    required Address address,
    required ContractState contractState,
    required TonWalletDetails details,
    required List<PublicKey>? custodians,
    // ignore: no-empty-block
  }) async {}
}
