import 'package:app/app/service/storage_service/abstract_storage_service.dart';
import 'package:app/app/service/storage_service/token_wallet_storage_service/token_wallet_storage_info.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

/// Implementation of storage that stores TokenWallet transactions and
/// information about it.
@singleton
class TokenWalletStorageService extends TokenWalletTransactionsStorage
    implements AbstractStorageService {
  /// Transactions for TonWallet, where key - wallet information, value - list
  /// of all completed.
  final _transactionsSubject = BehaviorSubject<
      Map<TokenWalletStorageInfo,
          List<TransactionWithData<TokenWalletTransaction?>>>>.seeded({});

  /// Get stream of transactions for TonWallet specified by address and network
  Stream<List<TransactionWithData<TokenWalletTransaction?>>?>
      transactionsStream({
    required int networkId,
    required String group,
    required Address owner,
    required Address rootTokenContract,
  }) =>
          _transactionsSubject.map(
            (event) => event[TokenWalletStorageInfo(
              networkId: networkId,
              group: group,
              owner: owner,
              rootTokenContract: rootTokenContract,
            )],
          );

  @override
  Future<void> clear() async {
    _transactionsSubject.add({});
  }

  /// Right now this method is not needed, it will be used later
  @override
  // ignore: no-empty-block
  Future<void> init() async {}

  @override
  Future<void> addFoundTransactions({
    required int networkId,
    required String group,
    required Address owner,
    required Address rootTokenContract,
    required List<TransactionWithData<TokenWalletTransaction?>> transaction,
  }) async {
    final info = TokenWalletStorageInfo(
      networkId: networkId,
      group: group,
      owner: owner,
      rootTokenContract: rootTokenContract,
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

  /// Add it later to storage
  @override
  Future<void> updateTokenWalletDetails({
    required int networkId,
    required String group,
    required Address owner,
    required Address rootTokenContract,
    required Symbol symbol,
    required BigInt balance,
    required ContractState contractState,
    TokenWalletVersion? version,
    // ignore: no-empty-block
  }) async {}
}
