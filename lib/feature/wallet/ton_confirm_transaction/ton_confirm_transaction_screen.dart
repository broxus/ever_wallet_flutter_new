import 'package:app/feature/wallet/ton_confirm_transaction/data/ton_confirm_transaction_state.dart';
import 'package:app/feature/wallet/ton_confirm_transaction/ton_confirm_transaction_screen_wm.dart';
import 'package:app/feature/wallet/ton_confirm_transaction/widgets/confirm_view.dart';
import 'package:app/feature/wallet/ton_confirm_transaction/widgets/transaction_prepare.dart';
import 'package:app/feature/wallet/ton_wallet_send/widgets/transaction_sending_widget.dart';
import 'package:app/feature/wallet/widgets/wallet_subscribe_error_widget.dart';
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
    return Scaffold(
      appBar: _AppBar(appbarState: wm.appbarState),
      body: StateNotifierBuilder<TonConfirmTransactionState?>(
        listenableState: wm.screenState,
        builder: (_, TonConfirmTransactionState? state) {
          if (state == null) {
            return const SizedBox.shrink();
          }

          return switch (state) {
            PrepareState() => TonWalletConfirmTransactionPrepare(
                localCustodians: localCustodians,
                onPressed: wm.onPressedPrepare,
              ),
            SubscribeError(:final error) => Center(
                child: WalletSubscribeErrorWidget(error: error),
              ),
            Sending(:final canClose) => Padding(
                padding: const EdgeInsets.all(DimensSize.d16),
                child: TransactionSendingWidget(canClose: canClose),
              ),
            _ => _ConfirmPage(
                account: wm.account,
                amount: wm.amount,
                money: wm.money,
                comment: comment,
                transactionIdHash: transactionIdHash,
                destination: destination,
                custodian: switch (state) {
                  LoadingState(:final custodian) ||
                  CalculatingError(:final custodian) ||
                  Ready(:final custodian) ||
                  Sent(:final custodian) =>
                    custodian,
                  _ => null,
                },
                fee: switch (state) {
                  CalculatingError(:final fee) => fee,
                  Ready(:final fee) || Sent(:final fee) => fee,
                  _ => null,
                },
                error: switch (state) {
                  CalculatingError(:final error) => error,
                  _ => null,
                },
                onPasswordEntered: wm.onPasswordEntered,
              ),
          };
        },
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({
    required this.appbarState,
  });

  final ListenableState<String?> appbarState;

  @override
  Size get preferredSize => DefaultAppBar.size;

  @override
  Widget build(BuildContext context) {
    return StateNotifierBuilder<String?>(
      listenableState: appbarState,
      builder: (_, String? title) {
        if (title == null) {
          return const SizedBox.shrink();
        }

        return DefaultAppBar(
          titleText: title,
        );
      },
    );
  }
}

class _ConfirmPage extends StatelessWidget {
  const _ConfirmPage({
    required this.amount,
    required this.destination,
    required this.onPasswordEntered,
    this.account,
    this.money,
    this.transactionIdHash,
    this.comment,
    this.custodian,
    this.fee,
    this.error,
  });

  final KeyAccount? account;
  final BigInt amount;
  final Money? money;
  final String? transactionIdHash;
  final String? comment;
  final Address destination;
  final PublicKey? custodian;
  final BigInt? fee;
  final String? error;
  final ValueChanged<String> onPasswordEntered;

  @override
  Widget build(BuildContext context) {
    if (custodian == null) {
      return const SizedBox.shrink();
    }

    return TonWalletConfirmTransactionConfirmView(
      account: account,
      transactionIdHash: transactionIdHash,
      money: money,
      recipient: destination,
      amount: amount,
      comment: comment,
      publicKey: custodian!,
      fee: fee,
      feeError: error,
      onPasswordEntered: onPasswordEntered,
    );
  }
}
