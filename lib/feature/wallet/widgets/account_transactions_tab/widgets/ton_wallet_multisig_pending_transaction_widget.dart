import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Widget that displays pending multisig transaction for ton wallet
class TonWalletMultisigPendingTransactionWidget extends StatelessWidget {
  const TonWalletMultisigPendingTransactionWidget({
    required this.transaction,
    required this.displayDate,
    super.key,
  });

  final TonWalletMultisigPendingTransaction transaction;
  final bool displayDate;

  @override
  Widget build(BuildContext context) {
    final ticker =
        inject<NekotonRepository>().currentTransport.nativeTokenTicker;
    final expireAtFormat = DateFormat('HH:mm:ss', context.locale.languageCode);

    return TonWalletTransactionWidget(
      displayDate: displayDate,
      onPressed: () => Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute<void>(
          builder: (_) => TonWalletMultisigPendingTransactionDetailsPage(
            transaction: transaction,
          ),
        ),
      ),
      address: transaction.address,
      isIncoming: !transaction.isOutgoing,
      status: transaction.canConfirm
          ? TonWalletTransactionStatus.waitingConfirmation
          : TonWalletTransactionStatus.pending,
      transactionFee: Money.fromBigIntWithCurrency(
        transaction.fees,
        Currencies()[ticker]!,
      ),
      transactionDateTime: transaction.date,
      transactionValue: Money.fromBigIntWithCurrency(
        transaction.value,
        Currencies()[ticker]!,
      ),
      additionalInformation: Padding(
        padding: const EdgeInsets.all(DimensSize.d16),
        child: Text(
          LocaleKeys.leftForConfirmation.tr(
            args: [
              expireAtFormat.format(transaction.expireAt),
              transaction.signsReceived.toString(),
              transaction.signsRequired.toString(),
            ],
          ),
          style: StyleRes.addRegular.copyWith(
            color: context.themeStyle.colors.textSecondary,
          ),
        ),
      ),
    );
  }
}
