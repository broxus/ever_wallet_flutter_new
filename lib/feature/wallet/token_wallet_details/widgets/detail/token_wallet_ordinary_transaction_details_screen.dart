import 'package:app/feature/wallet/token_wallet_details/widgets/detail/token_wallet_ordinary_transaction_details_screen_wm.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/details_body.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/details_body_with_see_explorer.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_status_body.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class TokenWalletOrdinaryTransactionDetailsScreen extends ElementaryWidget<
    TokenWalletOrdinaryTransactionDetailsScreenWidgetModel> {
  const TokenWalletOrdinaryTransactionDetailsScreen({
    required this.transaction,
    required this.tokenCurrency,
    required this.price,
    required this.rootTokenContract,
    super.key,
    WidgetModelFactory<TokenWalletOrdinaryTransactionDetailsScreenWidgetModel>
        wmFactory = defaultTokenWalletOrdinaryTransactionDetailsScreenWidgetModelFactory,
  }) : super(wmFactory);

  final TokenWalletOrdinaryTransaction transaction;
  final Currency tokenCurrency;
  final Fixed price;
  final Address rootTokenContract;

  @override
  Widget build(TokenWalletOrdinaryTransactionDetailsScreenWidgetModel wm) {
    return Scaffold(
      appBar: DefaultAppBar(
        titleWidget: Text(
          LocaleKeys.detailedInfo.tr(),
          style: wm.theme.textStyles.headingMedium,
        ),
      ),
      backgroundColor: wm.theme.colors.background0,
      body: WalletTransactionDetailsBodyWithExplorerButton(
        transactionHash: transaction.hash,
        body: SeparatedColumn(
          separatorSize: DimensSize.d16,
          children: [
            WalletTransactionDetailsDefaultBody(
              date: transaction.date,
              isIncoming: !transaction.isOutgoing,
              status: TonWalletTransactionStatus.completed,
              fee: wm.moneyFee,
              value: wm.moneyValue,
              hash: transaction.hash,
              recipientOrSender: transaction.address,
              type: LocaleKeys.ordinaryWord.tr(),
              price: price,
              tonIconPath: wm.tonIconPath,
              tokenIconPath: wm.logoURI,
            ),
          ],
        ),
      ),
    );
  }
}
