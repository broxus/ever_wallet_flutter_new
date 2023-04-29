import 'package:freezed_annotation/freezed_annotation.dart';

part 'ton_wallet_expired_transaction.freezed.dart';

@freezed
class TonWalletExpiredTransaction with _$TonWalletExpiredTransaction {
  const factory TonWalletExpiredTransaction({
    required String address,
    required DateTime date,
    required DateTime expireAt,
  }) = _TonWalletExpiredTransaction;
}
