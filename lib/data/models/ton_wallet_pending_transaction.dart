import 'package:freezed_annotation/freezed_annotation.dart';

part 'ton_wallet_pending_transaction.freezed.dart';

@freezed
class TonWalletPendingTransaction with _$TonWalletPendingTransaction {
  const factory TonWalletPendingTransaction({
    required String address,
    required DateTime date,
    required DateTime expireAt,
  }) = _TonWalletPendingTransaction;
}
