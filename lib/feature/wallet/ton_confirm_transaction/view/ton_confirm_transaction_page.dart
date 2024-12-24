import 'package:app/app/router/router.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/ton_confirm_transaction/view/ton_confirm_transaction_confirm_view.dart';
import 'package:app/feature/wallet/ton_confirm_transaction/view/ton_confirm_transaction_prepare.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Page that allows confirm multisig transaction for [TonWallet].
/// This pages displays only for outgoing transaction.
// TODO(knightforce): rename to Multisig or Custodian
class TonConfirmTransactionPage extends StatelessWidget {
  const TonConfirmTransactionPage({
    required this.walletAddress,
    required this.localCustodians,
    required this.transactionId,
    required this.amount,
    required this.destination,
    required this.comment,
    this.transactionIdHash,
    super.key,
  });

  /// Address of wallet which will be used to confirm transaction
  final Address walletAddress;

  /// Local custodians that CAN CONFIRM transaction (not all local)
  final List<PublicKey> localCustodians;

  /// Transaction that should be confirmed
  final String transactionId;

  final String? transactionIdHash;

  /// Amount of transaction
  final BigInt amount;

  /// Destination where funds should be sent (this page won't displayed for
  /// incoming transaction)
  final Address destination;

  /// Comment of transaction
  final String? comment;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TonConfirmTransactionBloc>(
      create: (_) => TonConfirmTransactionBloc(
        context: context,
        nekotonRepository: inject(),
        walletAddress: walletAddress,
        amount: amount,
        destination: destination,
        localCustodians: localCustodians,
        transactionId: transactionId,
        comment: comment,
      ),
      child:
          BlocConsumer<TonConfirmTransactionBloc, TonConfirmTransactionState>(
        listener: (context, state) {
          state.whenOrNull(
            sent: (_, __, ___) => context.goNamed(AppRoute.wallet.name),
          );
        },
        builder: (context, state) {
          final bloc = context.read<TonConfirmTransactionBloc>();

          return state.when(
            prepare: () => Scaffold(
              appBar: DefaultAppBar(
                titleText: LocaleKeys.confirmTransaction.tr(),
              ),
              body: TonWalletConfirmTransactionPrepare(
                localCustodians: localCustodians,
              ),
            ),
            subscribeError: (error) => Scaffold(
              appBar: DefaultAppBar(
                titleText: LocaleKeys.confirmTransaction.tr(),
              ),
              body: Center(child: WalletSubscribeErrorWidget(error: error)),
            ),
            loading: (c) => _confirmPage(bloc, custodian: c),
            calculatingError: (
              error,
              custodian,
              fee,
            ) =>
                _confirmPage(
              bloc,
              fee: fee,
              error: error,
              custodian: custodian,
            ),
            readyToSend: (fee, custodian) =>
                _confirmPage(bloc, fee: fee, custodian: custodian),
            sending: (canClose) => Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(DimensSize.d16),
                child: TransactionSendingWidget(canClose: canClose),
              ),
            ),
            sent: (fee, _, custodian) => _confirmPage(
              bloc,
              fee: fee,
              custodian: custodian,
            ),
          );
        },
      ),
    );
  }

  Widget _confirmPage(
    TonConfirmTransactionBloc bloc, {
    required PublicKey custodian,
    BigInt? fee,
    String? error,
  }) {
    return Scaffold(
      appBar: DefaultAppBar(titleText: LocaleKeys.confirmTransaction.tr()),
      body: TonWalletConfirmTransactionConfirmView(
        account: bloc.account,
        transactionIdHash: transactionIdHash,
        money: bloc.money,
        recipient: destination,
        amount: amount,
        comment: comment,
        publicKey: custodian,
        fee: fee,
        feeError: error,
      ),
    );
  }
}
