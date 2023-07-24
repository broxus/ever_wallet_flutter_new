import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'token_wallet_ordinary_transaction.freezed.dart';

@freezed
class TokenWalletOrdinaryTransaction with _$TokenWalletOrdinaryTransaction {
  const factory TokenWalletOrdinaryTransaction({
    required String lt,
    required bool isOutgoing,
    required Address address,
    @amountJsonConverter required BigInt value,
    required DateTime date,
    @amountJsonConverter required BigInt fees,
    required String hash,
    String? prevTransactionLt,
    TokenIncomingTransfer? incomingTransfer,
    TokenOutgoingTransfer? outgoingTransfer,
    TokenSwapBack? swapBack,
    String? accept,
    String? transferBounced,
    String? swapBackBounced,
  }) = _TokenWalletOrdinaryTransaction;
}
