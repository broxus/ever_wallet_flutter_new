import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/models.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/token_wallet_details/widgets/detail/token_wallet_ordinary_transaction_details_screen.dart';
import 'package:app/feature/wallet/token_wallet_details/widgets/detail/token_wallet_ordinary_transaction_details_screen_model.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Factory method for creating [TokenWalletOrdinaryTransactionDetailsScreenWidgetModel]
TokenWalletOrdinaryTransactionDetailsScreenWidgetModel
    defaultTokenWalletOrdinaryTransactionDetailsScreenWidgetModelFactory(
  BuildContext context,
) {
  return TokenWalletOrdinaryTransactionDetailsScreenWidgetModel(
    TokenWalletOrdinaryTransactionDetailsScreenModel(
      createPrimaryErrorHandler(context),
      inject(),
      inject(),
    ),
  );
}

/// [WidgetModel] для [TokenWalletOrdinaryTransactionDetailsScreen]
class TokenWalletOrdinaryTransactionDetailsScreenWidgetModel
    extends CustomWidgetModel<TokenWalletOrdinaryTransactionDetailsScreen,
        TokenWalletOrdinaryTransactionDetailsScreenModel> {
  TokenWalletOrdinaryTransactionDetailsScreenWidgetModel(
    super.model,
  );

  late final moneyFee = Money.fromBigIntWithCurrency(
    widget.transaction.fees,
    Currencies()[model.nativeTokenTicker]!,
  );

  late final moneyValue = Money.fromBigIntWithCurrency(
    widget.transaction.value,
    widget.tokenCurrency,
  );

  late final tonIconPath = model.nativeTokenIcon;

  ThemeStyleV2 get theme => context.themeStyleV2;

  String? get logoURI => _asset?.logoURI;

  TokenContractAsset? get _asset => model.getMaybeGetTokenContract(
        widget.rootTokenContract,
      );
}
