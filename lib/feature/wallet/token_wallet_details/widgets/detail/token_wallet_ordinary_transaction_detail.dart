import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/components/common/common.dart';
import 'package:ui_components_lib/dimens.dart';

/// Page that displays information about ordinary transaction for TonWallet
class TokenWalletOrdinaryTransactionDetailsPage extends StatelessWidget {
  const TokenWalletOrdinaryTransactionDetailsPage({
    required this.transaction,
    required this.tokenCurrency,
    super.key,
  });

  final TokenWalletOrdinaryTransaction transaction;
  final Currency tokenCurrency;

  @override
  Widget build(BuildContext context) {
    final ticker =
        inject<NekotonRepository>().currentTransport.nativeTokenTicker;

    String? type;

    if (transaction.incomingTransfer != null) {
      type = LocaleKeys.tokenIncomingTransfer.tr();
    }
    if (transaction.outgoingTransfer != null) {
      type = LocaleKeys.tokenOutgoingTransfer.tr();
    }
    if (transaction.swapBack != null) {
      type = LocaleKeys.swapBack.tr();
    }
    if (transaction.accept != null) {
      type = LocaleKeys.acceptWord.tr();
    }
    if (transaction.transferBounced != null) {
      type = LocaleKeys.transferBounced.tr();
    }
    if (transaction.swapBackBounced != null) {
      type = LocaleKeys.swapBackBounced.tr();
    }

    return Scaffold(
      appBar: const DefaultAppBar(),
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
                tokenCurrency,
              ),
              hash: transaction.hash,
              recipientOrSender: transaction.address,
              type: type,
            ),
          ],
        ),
      ),
    );
  }
}
