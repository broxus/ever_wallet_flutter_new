import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/details.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_multisig_expired_transaction/ton_wallet_multisig_expired_transaction_model.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_multisig_expired_transaction/ton_wallet_multisig_expired_transaction_widget.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_multisig_expired_transaction/widgets/transaction_details.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Factory method for creating [TonWalletMultisigExpiredTransactionWidgetModel]
TonWalletMultisigExpiredTransactionWidgetModel
    defaultTonWalletMultisigExpiredTransactionWidgetModelFactory(
  BuildContext context,
) {
  return TonWalletMultisigExpiredTransactionWidgetModel(
    TonWalletMultisigExpiredTransactionModel(
      createPrimaryErrorHandler(context),
      inject(),
    ),
  );
}

/// [WidgetModel] для [TonWalletMultisigExpiredTransactionWidget]
class TonWalletMultisigExpiredTransactionWidgetModel extends CustomWidgetModel<
    TonWalletMultisigExpiredTransactionWidget,
    TonWalletMultisigExpiredTransactionModel> {
  TonWalletMultisigExpiredTransactionWidgetModel(
    super.model,
  );

  late final transactionTimeFormatter = DateFormat(
    'HH:mm',
    context.locale.languageCode,
  );

  late final transactionText =
      transactionTimeFormatter.format(widget.transaction.date);

  late final transactionFee = Money.fromBigIntWithCurrency(
    widget.transaction.fees,
    Currencies()[_nativeTokenTicker]!,
  );

  late final transactionValue = Money.fromBigIntWithCurrency(
    widget.transaction.value,
    Currencies()[_nativeTokenTicker]!,
  );

  TextStylesV2 get textStyles => _theme.textStyles;

  ColorsPaletteV2 get colors => _theme.colors;

  ThemeStyleV2 get _theme => context.themeStyleV2;

  String get _nativeTokenTicker => model.nativeTokenTicker;

  String get _tonIconPath => model.tonIconPath;

  void onPressedDetailed() {
    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute<void>(
        builder: (_) => TonWalletMultisigExpiredTransactionDetailsPage(
          transaction: widget.transaction,
          price: widget.price,
          account: widget.account,
          transactionFee: transactionFee,
          transactionValue: transactionValue,
          tonIconPath: _tonIconPath,
          methodData: widget.transaction.walletInteractionInfo?.method
              .toRepresentableData(),
          onPressedSeeInExplorer: _openBrowserNewTab,
        ),
      ),
    );
  }

  void _openBrowserNewTab() {
    browserNewTab(
      context,
      model.getTransactionExplorerLink(widget.transaction.hash),
    );
  }
}
