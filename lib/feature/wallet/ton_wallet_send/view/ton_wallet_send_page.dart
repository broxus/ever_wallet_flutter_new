import 'package:app/app/router/router.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/ton_wallet_send/view/ton_wallet_send_confirm_view.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Page that allows send funds from TonWalelt (native token).
class TonWalletSendPage extends StatelessWidget {
  const TonWalletSendPage({
    required this.address,
    required this.publicKey,
    required this.destination,
    required this.amount,
    required this.comment,
    super.key,
  });

  /// Address of TonWallet that will be used to send funds
  final Address address;

  /// Custodian of [address] that will be initiator of transaction (for not
  /// multisig this is main key).
  final PublicKey publicKey;

  /// Address where funds should be sent
  final Address destination;

  /// Amount of tokens that should be sent, to convert Fixed to BigInt, use
  /// [Fixed.minorUnits].
  final BigInt amount;

  /// Comment for transaction
  final String? comment;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TonWalletSendBloc>(
      create: (_) => TonWalletSendBloc(
        destination: destination,
        amount: amount,
        address: address,
        comment: comment,
        publicKey: publicKey,
        nekotonRepository: inject(),
      )..add(const TonWalletSendEvent.prepare()),
      child: BlocConsumer<TonWalletSendBloc, TonWalletSendState>(
        listener: (context, state) {
          state.whenOrNull(
            sent: (_, __) => context.goNamed(AppRoute.wallet.name),
          );
        },
        builder: (context, state) {
          return state.when(
            loading: _confirmPage,
            calculatingError: (error, fee) =>
                _confirmPage(fee: fee, error: error),
            readyToSend: (fee) => _confirmPage(fee: fee),
            sending: (canClose) => Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(DimensSize.d16),
                child: TransactionSendingWidget(canClose: canClose),
              ),
            ),
            sent: (fee, _) => _confirmPage(fee: fee),
          );
        },
      ),
    );
  }

  Widget _confirmPage({BigInt? fee, String? error}) {
    return Scaffold(
      appBar: DefaultAppBar(
        onClosePressed: (context) => context.pop(),
        titleText: LocaleKeys.confirmTransaction.tr(),
      ),
      body: TonWalletSendConfirmView(
        recipient: destination,
        amount: amount,
        comment: comment,
        publicKey: publicKey,
        fee: fee,
        feeError: error,
      ),
    );
  }
}
