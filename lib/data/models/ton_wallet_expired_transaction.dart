import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'ton_wallet_expired_transaction.freezed.dart';

@freezed
class TonWalletExpiredTransaction with _$TonWalletExpiredTransaction {
  const factory TonWalletExpiredTransaction({
    required Address address,
    required DateTime date,
    required DateTime expireAt,
  }) = _TonWalletExpiredTransaction;
}
