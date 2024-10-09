import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/details_body.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/details_body_with_see_explorer.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_status_body.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/components/common/common.dart';
import 'package:ui_components_lib/dimens.dart';
import 'package:ui_components_lib/v2/theme_style_v2.dart';

/// Page that displays information about ordinary transaction for TonWallet
class TokenWalletOrdinaryTransactionDetailsPage extends StatelessWidget {
  const TokenWalletOrdinaryTransactionDetailsPage({
    required this.transaction,
    required this.tokenCurrency,
    required this.price,
    required this.rootTokenContract,
    super.key,
  });

  final TokenWalletOrdinaryTransaction transaction;
  final Currency tokenCurrency;
  final Fixed price;
  final Address rootTokenContract;

  @override
  Widget build(BuildContext context) {
    // TODO(malochka): move it in widget_model or model, old implementation
    final nr = inject<NekotonRepository>();
    final ticker = nr.currentTransport.nativeTokenTicker;
    final tonIconPath = nr.currentTransport.nativeTokenIcon;
    final asset = inject<AssetsService>()
        .maybeGetTokenContract(rootTokenContract, nr.currentTransport);

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
                tokenCurrency,
              ),
              hash: transaction.hash,
              recipientOrSender: transaction.address,
              type: LocaleKeys.ordinaryWord.tr(),
              price: price,
              tonIconPath: tonIconPath,
              tokenIconPath: asset?.logoURI,
            ),
          ],
        ),
      ),
    );
  }
}
