import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'ton_wallet_multisig_expired_transaction.freezed.dart';

@freezed
class TonWalletMultisigExpiredTransaction
    with _$TonWalletMultisigExpiredTransaction {
  const factory TonWalletMultisigExpiredTransaction({
    required String lt,
    required String creator,
    required List<String> confirmations,
    required List<String> custodians,
    required bool isOutgoing,
    @amountJsonConverter required BigInt value,
    required Address address,
    required DateTime date,
    @amountJsonConverter required BigInt fees,
    required String hash,
    String? prevTransactionLt,
    String? comment,
    DePoolOnRoundCompleteNotification? dePoolOnRoundCompleteNotification,
    DePoolReceiveAnswerNotification? dePoolReceiveAnswerNotification,
    TokenWalletDeployedNotification? tokenWalletDeployedNotification,
    WalletInteractionInfo? walletInteractionInfo,
  }) = _TonWalletMultisigExpiredTransaction;
}
