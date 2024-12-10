import 'dart:convert';

import 'package:app/app/router/router.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser/utils.dart';
import 'package:app/feature/wallet/widgets/account_info.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/details.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_status_body.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/buttons/accent_button.dart';
import 'package:ui_components_lib/v2/widgets/buttons/button_shape.dart';
import 'package:ui_components_lib/v2/widgets/buttons/primary_button.dart';

/// Page that displays information about multisig pending transaction for
/// TonWallet
class TonWalletMultisigPendingTransactionDetailsPage extends StatelessWidget {
  const TonWalletMultisigPendingTransactionDetailsPage({
    required this.transaction,
    required this.price,
    required this.account,
    super.key,
  });

  final TonWalletMultisigPendingTransaction transaction;
  final Fixed price;
  final KeyAccount account;

  @override
  Widget build(BuildContext context) {
    // TODO(malochka): move it in widget_model or model, old implementation
    final ticker =
        inject<NekotonRepository>().currentTransport.nativeTokenTicker;

    final methodData =
        transaction.walletInteractionInfo?.method.toRepresentableData();
    final tonIconPath =
        inject<NekotonRepository>().currentTransport.nativeTokenIcon;

    final theme = context.themeStyleV2;
    return Scaffold(
      appBar: DefaultAppBar(
        titleWidget: Text(
          LocaleKeys.detailedInfo.tr(),
          style: theme.textStyles.headingMedium,
        ),
      ),
      backgroundColor: theme.colors.background0,
      body: SingleChildScrollView(
        child: SeparatedColumn(
          separatorSize: DimensSize.d12,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d16),
              child: AccountInfo(account: account),
            ),
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
              info: methodData?.$1,
              type: LocaleKeys.multisigWord.tr(),
              tonIconPath: tonIconPath,
              tokenIconPath: tonIconPath,
              price: price,
            ),
            TonWalletTransactionCustodiansDetails(
              confirmations: transaction.confirmations,
              requiredConfirmations: transaction.signsRequired,
              custodians: transaction.custodians,
              initiator: transaction.creator,
            ),
            const SizedBox.shrink(),
            if (transaction.canConfirm)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: DimensSizeV2.d16,
                ),
                child: AccentButton(
                  buttonShape: ButtonShape.pill,
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
                  title: LocaleKeys.confirmTransaction.tr(),
                  icon: LucideIcons.check,
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DimensSizeV2.d16,
              ),
              child: PrimaryButton(
                title: LocaleKeys.seeInExplorer.tr(),
                icon: LucideIcons.globe,
                onPressed: () {
                  Navigator.of(context).pop();
                  // TODO(oldVersion): extract inject from widget
                  browserNewTab(
                    context,
                    inject<NekotonRepository>()
                        .currentTransport
                        .transactionExplorerLink(transaction.hash),
                  );
                },
                buttonShape: ButtonShape.pill,
              ),
            ),
            const SizedBox(height: DimensSizeV2.d24),
          ],
        ),
      ),
    );
  }
}
