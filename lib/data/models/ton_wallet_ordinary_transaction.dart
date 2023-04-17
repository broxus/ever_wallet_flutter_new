import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'ton_wallet_ordinary_transaction.freezed.dart';

@freezed
class TonWalletOrdinaryTransaction with _$TonWalletOrdinaryTransaction {
  const factory TonWalletOrdinaryTransaction({
    required String lt,
    String? prevTransactionLt,
    required bool isOutgoing,
    required String value,
    required String address,
    required DateTime date,
    required String fees,
    required String hash,
    String? comment,
    DePoolOnRoundCompleteNotification? dePoolOnRoundCompleteNotification,
    DePoolReceiveAnswerNotification? dePoolReceiveAnswerNotification,
    TokenWalletDeployedNotification? tokenWalletDeployedNotification,
    WalletInteractionInfo? walletInteractionInfo,
  }) = _TonWalletOrdinaryTransaction;
}
