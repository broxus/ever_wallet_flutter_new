import 'package:app/di/di.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/components/common/common.dart';
import 'package:ui_components_lib/dimens.dart';

/// Page that displays information about multisig ordinary transaction for
/// TonWallet
class TonWalletMultisigOrdinaryTransactionDetailsPage extends StatelessWidget {
  const TonWalletMultisigOrdinaryTransactionDetailsPage({
    required this.transaction,
    super.key,
  });

  final TonWalletMultisigOrdinaryTransaction transaction;

  @override
  Widget build(BuildContext context) {
    final ticker =
        inject<NekotonRepository>().currentTransport.nativeTokenTicker;

    final dePoolOnRoundComplete =
        transaction.dePoolOnRoundCompleteNotification?.toRepresentableData();

    final dePoolReceiveAnswer =
        transaction.dePoolReceiveAnswerNotification?.toRepresentableData();

    final tokenWalletDeployed =
        transaction.tokenWalletDeployedNotification?.toRepresentableData();

    final walletInteraction =
        transaction.walletInteractionInfo?.toRepresentableData();

    return Scaffold(
      appBar: const DefaultAppBar(),
      body: TonWalletTransactionDetailsBodyWithExplorerButton(
        transactionHash: transaction.hash,
        body: SeparatedColumn(
          separatorSize: DimensSize.d16,
          children: [
            TonWalletTransactionDetailsDefaultBody(
              date: transaction.date,
              isIncoming: !transaction.isOutgoing,
              status: TonWalletTransactionStatus.completed,
              fee: Money.fromBigIntWithCurrency(
                transaction.fees,
                Currencies()[ticker]!,
              ),
              value: Money.fromBigIntWithCurrency(
                transaction.value,
                Currencies()[ticker]!,
              ),
              hash: transaction.hash,
              recipientOrSender: transaction.address,
              comment: transaction.comment,
            ),
            if (dePoolOnRoundComplete != null)
              TonWalletTransactionAdditionalBody(
                type: LocaleKeys.depoolRoundComplete.tr(),
                children: dePoolOnRoundComplete,
              ),
            if (dePoolReceiveAnswer != null)
              TonWalletTransactionAdditionalBody(
                type: LocaleKeys.depoolReceiveAnswer.tr(),
                children: dePoolReceiveAnswer,
              ),
            if (tokenWalletDeployed != null)
              TonWalletTransactionAdditionalBody(
                type: LocaleKeys.tokenWalletDeployed.tr(),
                children: [tokenWalletDeployed],
              ),
            if (walletInteraction != null)
              TonWalletTransactionAdditionalBody(
                type: LocaleKeys.walletInteraction.tr(),
                children: walletInteraction,
              ),
            TonWalletTransactionCustodiansDetails(
              confirmations: transaction.confirmations,
              custodians: transaction.custodians,
              initiator: transaction.creator,
            ),
          ],
        ),
      ),
    );
  }
}
