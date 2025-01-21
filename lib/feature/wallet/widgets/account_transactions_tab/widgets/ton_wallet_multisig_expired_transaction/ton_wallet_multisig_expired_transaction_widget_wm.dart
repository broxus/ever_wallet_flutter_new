import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/ton_wallet_multisig_expired_transaction_details.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_multisig_expired_transaction/ton_wallet_multisig_expired_transaction_model.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_multisig_expired_transaction/ton_wallet_multisig_expired_transaction_widget.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

  String get nativeTokenTicker => model.nativeTokenTicker;

  TextStylesV2 get textStyles => _theme.textStyles;

  ColorsPaletteV2 get colors => _theme.colors;

  ThemeStyleV2 get _theme => context.themeStyleV2;

  void onPressedDetailed() {
    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute<void>(
        builder: (_) => TonWalletMultisigExpiredTransactionDetailsPage(
          transaction: widget.transaction,
          price: widget.price,
          account: widget.account,
        ),
      ),
    );
  }
}
