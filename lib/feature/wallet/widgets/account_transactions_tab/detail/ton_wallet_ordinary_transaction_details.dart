import 'package:app/di/di.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/details.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_status_body.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Page that displays information about ordinary transaction for TonWallet
class TonWalletOrdinaryTransactionDetailsPage extends StatelessWidget {
  const TonWalletOrdinaryTransactionDetailsPage({
    required this.transaction,
    required this.price,
    super.key,
  });

  final TonWalletOrdinaryTransaction transaction;
  final Fixed price;

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
      body: WalletTransactionDetailsBodyWithExplorerButton(
        transactionHash: transaction.hash,
        body: SeparatedColumn(
          separatorSize: DimensSize.d16,
          children: [
            WalletTransactionDetailsDefaultBody(
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
              info: methodData?.$1,
              type: LocaleKeys.ordinaryWord.tr(),
              tonIconPath: tonIconPath,
              price: price,
            ),
          ],
        ),
      ),
    );
  }
}
