import 'package:app/di/di.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/details.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_status_body.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/components/common/common.dart';
import 'package:ui_components_lib/dimens.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Page that displays information about multisig expired transaction for
/// TonWallet
class TonWalletMultisigExpiredTransactionDetailsPage extends StatelessWidget {
  const TonWalletMultisigExpiredTransactionDetailsPage({
    required this.transaction,
    required this.price,
    required this.account,
    required this.transactionFee,
    required this.transactionValue,
    required this.tonIconPath,
    required this.onPressedSeeInExplorer,
    this.methodData,
    super.key,
  });

  final TonWalletMultisigExpiredTransaction transaction;
  final Fixed price;
  final KeyAccount account;
  final Money transactionFee;
  final Money transactionValue;
  final String tonIconPath;
  final VoidCallback onPressedSeeInExplorer;
  final DetailsTitleAndBody? methodData;

  @override
  Widget build(BuildContext context) {
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
          separatorSize: DimensSize.d16,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d16),
              child: AccountInfo(account: account),
            ),
            WalletTransactionDetailsDefaultBody(
              date: transaction.date,
              isIncoming: !transaction.isOutgoing,
              status: TonWalletTransactionStatus.expired,
              fee: transactionFee,
              value: transactionValue,
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
              custodians: transaction.custodians,
              initiator: transaction.creator,
            ),
            const SizedBox(height: DimensSizeV2.d32),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DimensSizeV2.d16,
              ),
              child: PrimaryButton(
                title: LocaleKeys.seeInExplorer.tr(),
                icon: LucideIcons.globe,
                onPressed: () {
                  Navigator.of(context).pop();
                  onPressedSeeInExplorer();
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
