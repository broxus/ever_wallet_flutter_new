import 'dart:convert';

import 'package:app/app/router/router.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Page that displays information about multisig pending transaction for
/// TonWallet
class TonWalletMultisigPendingTransactionDetailsPage extends StatelessWidget {
  const TonWalletMultisigPendingTransactionDetailsPage({
    required this.transaction,
    super.key,
  });

  final TonWalletMultisigPendingTransaction transaction;

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
      body: WalletTransactionDetailsBodyWithExplorerButton(
        transactionHash: transaction.hash,
        action: transaction.canConfirm
            ? CommonButton.primary(
                fillWidth: true,
                onPressed: () {
                  Navigator.of(context).pop();
                  context.goFurther(
                    AppRoute.tonConfirmTransaction.pathWithData(
                      queryParameters: {
                        tonWalletConfirmTransactionWalletAddressQueryParam:
                            transaction.walletAddress.address,
                        tonWalletConfirmTransactionLocalCustodiansQueryParam:
                            jsonEncode(
                          transaction.nonConfirmedLocalCustodians
                              .map((e) => e.publicKey)
                              .toList(),
                        ),
                        tonWalletConfirmTransactionTransactionIdQueryParam:
                            transaction.transactionId,
                        tonWalletConfirmTransactionDestinationQueryParam:
                            transaction.address.address,
                        tonWalletConfirmTransactionAmountQueryParam:
                            transaction.value.toString(),
                        if (transaction.comment != null)
                          tonWalletConfirmTransactionCommentQueryParam:
                              transaction.comment!,
                      },
                    ),
                  );
                },
                text: LocaleKeys.confirmTransaction.tr(),
                leading: CommonButtonIconWidget.svg(
                  svg: Assets.images.check.path,
                ),
              )
            : null,
        body: SeparatedColumn(
          separatorSize: DimensSize.d16,
          children: [
            WalletTransactionDetailsDefaultBody(
              date: transaction.date,
              isIncoming: !transaction.isOutgoing,
              status: transaction.canConfirm
                  ? TonWalletTransactionStatus.waitingConfirmation
                  : TonWalletTransactionStatus.pending,
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
              WalletTransactionAdditionalBody(
                type: LocaleKeys.depoolRoundComplete.tr(),
                children: dePoolOnRoundComplete,
              ),
            if (dePoolReceiveAnswer != null)
              WalletTransactionAdditionalBody(
                type: LocaleKeys.depoolReceiveAnswer.tr(),
                children: dePoolReceiveAnswer,
              ),
            if (tokenWalletDeployed != null)
              WalletTransactionAdditionalBody(
                type: LocaleKeys.tokenWalletDeployed.tr(),
                children: [tokenWalletDeployed],
              ),
            if (walletInteraction != null)
              WalletTransactionAdditionalBody(
                type: LocaleKeys.walletInteraction.tr(),
                children: walletInteraction,
              ),
            TonWalletTransactionCustodiansDetails(
              confirmations: transaction.confirmations,
              requiredConfirmations: transaction.signsRequired,
              custodians: transaction.custodians,
              initiator: transaction.creator,
            ),
          ],
        ),
      ),
    );
  }
}
