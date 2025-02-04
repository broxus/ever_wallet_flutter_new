import 'package:app/feature/wallet/ton_confirm_transaction/data/ton_confirm_transaction_state.dart';
import 'package:app/feature/wallet/ton_confirm_transaction/ton_confirm_transaction_screen_wm.dart';
import 'package:app/feature/wallet/ton_confirm_transaction/widgets/confirm_view.dart';
import 'package:app/feature/wallet/ton_confirm_transaction/widgets/transaction_prepare.dart';
import 'package:app/feature/wallet/ton_wallet_send/widgets/transaction_sending_widget.dart';
import 'package:app/feature/wallet/widgets/wallet_subscribe_error_widget.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class TonConfirmTransactionScreen
    extends ElementaryWidget<TonConfirmTransactionScreenWidgetModel> {
  TonConfirmTransactionScreen({
    /// Address of wallet which will be used to confirm transaction
    required Address walletAddress,
    required BigInt amount,
    required String transactionId,
    required this.localCustodians,
    required this.destination,
    required this.comment,
    this.transactionIdHash,
    super.key,
    WidgetModelFactory<TonConfirmTransactionScreenWidgetModel>? wmFactory,
  }) : super(
          wmFactory ??
              (ctx) => defaultTonConfirmTransactionScreenWidgetModelFactory(
                    ctx,
                    walletAddress: walletAddress,
                    amount: amount,
                    transactionId: transactionId,
                  ),
        );

  /// Local custodians that CAN CONFIRM transaction (not all local)
  final List<PublicKey> localCustodians;

  final String? transactionIdHash;

  /// Destination where funds should be sent (this page won't displayed for
  /// incoming transaction)
  final Address destination;

  /// Comment of transaction
  final String? comment;

  @override
  Widget build(TonConfirmTransactionScreenWidgetModel wm) {
    return StateNotifierBuilder<TonConfirmTransactionState>(
      listenableState: wm.screenState,
      builder: (context, state) {
        if (state == null) {
          return const SizedBox.shrink();
        }
        return state.when(
          prepare: () => Scaffold(
            appBar: DefaultAppBar(
              titleText: LocaleKeys.confirmTransaction.tr(),
            ),
            body: TonWalletConfirmTransactionPrepare(
              localCustodians: localCustodians,
              onPressed: wm.onPressedPrepare,
            ),
          ),
          subscribeError: (error) => Scaffold(
            appBar: DefaultAppBar(
              titleText: LocaleKeys.confirmTransaction.tr(),
            ),
            body: Center(child: WalletSubscribeErrorWidget(error: error)),
          ),
          loading: (custodian) => _confirmPage(wm, custodian: custodian),
          calculatingError: (error, custodian, fee) =>
              _confirmPage(wm, fee: fee, error: error, custodian: custodian),
          readyToSend: (fee, custodian) =>
              _confirmPage(wm, fee: fee, custodian: custodian),
          sending: (canClose) => Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(DimensSize.d16),
              child: TransactionSendingWidget(canClose: canClose),
            ),
          ),
          sent: (fee, transaction, custodian) =>
              _confirmPage(wm, fee: fee, custodian: custodian),
        );
      },
    );
  }

  Widget _confirmPage(
    TonConfirmTransactionScreenWidgetModel wm, {
    required PublicKey custodian,
    BigInt? fee,
    String? error,
  }) {
    // Получаем account и money из Widget Model
    final account = wm.account;
    final money = wm.money;
    return Scaffold(
      appBar: DefaultAppBar(titleText: LocaleKeys.confirmTransaction.tr()),
      body: TonWalletConfirmTransactionConfirmView(
        account: account,
        transactionIdHash: transactionIdHash,
        money: money,
        recipient: destination,
        amount: wm.amount,
        comment: comment,
        publicKey: custodian,
        fee: fee,
        feeError: error,
        onPasswordEntered: wm.onPasswordEntered,
      ),
    );
  }
}
