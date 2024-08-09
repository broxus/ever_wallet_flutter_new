import 'package:equatable/equatable.dart';

/// Type of transaction for TonWallet that is used to identify transaction type
/// in UI by checking [runtimeType] by this type.
enum AccountTransactionType {
  multisigExpired,
  multisigPending,
  multisigOrdinary,
  expired,
  pending,
  ordinary,
}

/// Item that describes transaction for TonWallet.
/// This wrapper is used to allow sorting without checking real type and it's
/// easy in UI to make abstraction above any transaction.
class AccountTransactionItem<T> extends Equatable
    implements Comparable<AccountTransactionItem<Object>> {
  const AccountTransactionItem({
    required this.date,
    required this.transaction,
    required this.type,
    required this.prevTransactionLt,
  });

  final DateTime date;

  final T transaction;

  final String? prevTransactionLt;

  final AccountTransactionType type;

  @override
  int compareTo(AccountTransactionItem<Object> other) =>
      date.compareTo(other.date);

  @override
  List<Object?> get props => [date, transaction, type];
}
