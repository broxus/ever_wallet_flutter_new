import 'package:app/app/router/router.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Page that allows to send not native token from [TokenWallet] to
/// [destination].
/// For correct work subscription for [TokenWallet] and [TonWallet] with
/// address=[owner] must be created.
class TokenWalletSendPage extends StatelessWidget {
  const TokenWalletSendPage({
    required this.owner,
    required this.rootTokenContract,
    required this.publicKey,
    required this.destination,
    required this.amount,
    required this.attachedAmount,
    required this.comment,
    required this.resultMessage,
    super.key,
  });

  /// Address of account for token.
  final Address owner;

  /// Address of contract for token
  final Address rootTokenContract;

  /// Local custodian of account, that will be initiator of transaction (for not
  /// multisig this is main key).
  final PublicKey publicKey;

  /// Address where tokens must be sent
  final Address destination;

  /// How many tokens must be sent, to convert Fixed to BigInt, use
  /// [Fixed.minorUnits].
  final BigInt amount;

  /// Attached amount in native tokens, that should be added to transaction.
  /// If null, then default value will be used.
  final BigInt? attachedAmount;

  /// Comment for transaction
  final String? comment;

  /// Message that will be shown when transaction completed
  final String? resultMessage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TokenWalletSendBloc>(
      create: (_) => TokenWalletSendBloc(
        context: context,
        destination: destination,
        tokenAmount: amount,
        owner: owner,
        rootTokenContract: rootTokenContract,
        attachedAmount: attachedAmount,
        comment: comment,
        publicKey: publicKey,
        nekotonRepository: inject(),
        messengerService: inject(),
        resultMessage:
            resultMessage ?? LocaleKeys.transactionSentSuccessfully.tr(),
      )..add(const TokenWalletSendEvent.prepare()),
      child: BlocConsumer<TokenWalletSendBloc, TokenWalletSendState>(
        listener: (context, state) {
          state.whenOrNull(
            sent: (_, __) => context.goNamed(AppRoute.wallet.name),
          );
        },
        builder: (context, state) {
          return state.when(
            init: () => const SizedBox.shrink(),
            subscribeError: (error) => Scaffold(
              appBar: const DefaultAppBar(),
              body: Center(
                child: WalletSubscribeErrorWidget(error: error),
              ),
            ),
            loading: _confirmPage,
            calculatingError: (error, fee) => _confirmPage(
              fee: fee,
              error: error,
            ),
            readyToSend: (fee, attachedAmount, txErrors) => _confirmPage(
              fee: fee,
              attachedAmount: attachedAmount,
              txErrors: txErrors,
            ),
            sending: _sendingPage,
            sent: (_, __) => _sendingPage(false),
          );
        },
      ),
    );
  }

  Widget _confirmPage({
    BigInt? fee,
    String? error,
    BigInt? attachedAmount,
    List<TxTreeSimulationErrorItem>? txErrors,
  }) =>
      Scaffold(
        appBar: DefaultAppBar(
          onClosePressed: (context) => context.pop(),
          titleText: LocaleKeys.confirmTransaction.tr(),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DimensSizeV2.d16,
          ),
          child: TokenWalletSendConfirmView(
            recipient: destination,
            amount: amount,
            comment: comment,
            publicKey: publicKey,
            fee: fee,
            feeError: error,
            attachedAmount: attachedAmount ?? this.attachedAmount,
            txErrors: txErrors,
          ),
        ),
      );

  Widget _sendingPage(bool canClose) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(DimensSizeV2.d16),
          child: TransactionSendingWidget(canClose: canClose),
        ),
      );
}
