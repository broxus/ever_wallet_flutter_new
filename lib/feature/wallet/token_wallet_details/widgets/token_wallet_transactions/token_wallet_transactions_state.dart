part of 'token_wallet_transactions_cubit.dart';

@freezed
class TokenWalletTransactionsState with _$TokenWalletTransactionsState {
  const factory TokenWalletTransactionsState.empty() = _Empty;

  const factory TokenWalletTransactionsState.loading() = _Loading;

  const factory TokenWalletTransactionsState.transactions(
    List<TokenWalletOrdinaryTransaction> transactions,
    Currency tokenCurrency,
  ) = _Transactions;
}
