part of 'account_transactions_tab_cubit.dart';

@freezed
class AccountTransactionsTabState with _$AccountTransactionsTabState {
  const factory AccountTransactionsTabState.empty() = _Empty;

  const factory AccountTransactionsTabState.loading() = _Loading;

  const factory AccountTransactionsTabState.transactions(
    List<AccountTransactionItem<Object>> transactions,
  ) = _Transactions;
}
