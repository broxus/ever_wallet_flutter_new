part of 'account_transactions_tab_cubit.dart';

@freezed
class AccountTransactionsTabState with _$AccountTransactionsTabState {
  const factory AccountTransactionsTabState.empty() = _Empty;

  const factory AccountTransactionsTabState.loading() = _Loading;

  /// isLoading means that user scrolled to the end of list
  const factory AccountTransactionsTabState.transactions({
    required List<AccountTransactionItem<Object>> transactions,
    required bool isLoading,
    required bool canLoadMore,
    required Fixed price,
  }) = _Transactions;
}
