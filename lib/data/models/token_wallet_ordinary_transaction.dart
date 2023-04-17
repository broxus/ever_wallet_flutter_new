import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'token_wallet_ordinary_transaction.freezed.dart';

@freezed
class TokenWalletOrdinaryTransaction with _$TokenWalletOrdinaryTransaction {
  const factory TokenWalletOrdinaryTransaction({
    required String lt,
    String? prevTransactionLt,
    required bool isOutgoing,
    required String value,
    required String address,
    required DateTime date,
    required String fees,
    required String hash,
    TokenIncomingTransfer? incomingTransfer,
    TokenOutgoingTransfer? outgoingTransfer,
    TokenSwapBack? swapBack,
    String? accept,
    String? transferBounced,
    String? swapBackBounced,
  }) = _TokenWalletOrdinaryTransaction;
}
