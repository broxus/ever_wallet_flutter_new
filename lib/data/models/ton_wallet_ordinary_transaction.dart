import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'ton_wallet_ordinary_transaction.freezed.dart';

@freezed
class TonWalletOrdinaryTransaction with _$TonWalletOrdinaryTransaction {
  const factory TonWalletOrdinaryTransaction({
    required String lt,
    required bool isOutgoing,
    @amountJsonConverter required Fixed value,
    required String address,
    required DateTime date,
    @amountJsonConverter required Fixed fees,
    required String hash,
    String? prevTransactionLt,
    String? comment,
    DePoolOnRoundCompleteNotification? dePoolOnRoundCompleteNotification,
    DePoolReceiveAnswerNotification? dePoolReceiveAnswerNotification,
    TokenWalletDeployedNotification? tokenWalletDeployedNotification,
    WalletInteractionInfo? walletInteractionInfo,
  }) = _TonWalletOrdinaryTransaction;
}
