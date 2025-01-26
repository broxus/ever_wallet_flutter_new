// ignore_for_file: use_build_context_synchronously

import 'package:app/app/service/service.dart';
import 'package:app/core/bloc/bloc_mixin.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

part 'ton_confirm_transaction_bloc.freezed.dart';

part 'ton_confirm_transaction_event.dart';

part 'ton_confirm_transaction_state.dart';

/// Bloc that allows prepare transaction confirmation for multisig wallet.
/// If [localCustodians] more than 1, then user will prepare transaction by
/// selecting custodian for confirmation, else it will calculate transaction.
// TODO(knightforce): use Elementary instead Bloc
class TonConfirmTransactionBloc
    extends Bloc<TonConfirmTransactionEvent, TonConfirmTransactionState>
    with BlocBaseMixin {
  TonConfirmTransactionBloc({
    required this.context,
    required this.nekotonRepository,
    required this.walletAddress,
    required this.localCustodians,
    required this.transactionId,
    required this.amount,
    required this.destination,
    required this.comment,
  }) : super(
          localCustodians.length > 1
              ? const TonConfirmTransactionState.prepare()
              : TonConfirmTransactionState.loading(localCustodians.first),
        ) {
    account ??= nekotonRepository.seedList.findAccountByAddress(walletAddress);

    final currentTransport = nekotonRepository.currentTransport;

    final currency = Currencies()[currentTransport.nativeTokenTicker];

    if (currency != null) {
      money = Money.fromBigIntWithCurrency(
        amount,
        currency,
      );
    }

    _registerHandlers();
    if (localCustodians.length == 1) {
      add(TonConfirmTransactionEvent.prepare(localCustodians.first));
    }
  }

  final _logger = Logger('TonConfirmTransactionBloc');
  final BuildContext context;
  final NekotonRepository nekotonRepository;

  /// Address of wallet which will be used to confirm transaction
  final Address walletAddress;

  /// Local custodians that CAN CONFIRM transaction (not all)
  final List<PublicKey> localCustodians;

  /// Transaction that should be confirmed
  final String transactionId;

  /// Amount of transaction
  final BigInt amount;

  /// Destination where funds should be sent (this page won't displayed for
  /// incoming transaction)
  final Address destination;

  /// Comment of transaction
  final String? comment;

  KeyAccount? account;

  Money? money;

  /// Fee for transaction after calculating it in [_handlePrepare]
  BigInt? fees;

  late PublicKey selectedCustodian;

  void _registerHandlers() {
    on<_Prepare>((event, emit) => _handlePrepare(emit, event.custodian));
    on<_Send>((event, emit) => _handleSend(emit, event.password));
    on<_CompleteSend>(
      (event, emit) => emitSafe(
        TonConfirmTransactionState.sent(
          fees!,
          event.transaction,
          selectedCustodian,
        ),
      ),
    );
    on<_AllowCloseSend>(
      (event, emit) =>
          emitSafe(const TonConfirmTransactionState.sending(canClose: true)),
    );
  }

  // ignore: long-method
  Future<void> _handlePrepare(
    Emitter<TonConfirmTransactionState> emit,
    PublicKey custodian,
  ) async {
    UnsignedMessage? unsignedMessage;
    try {
      selectedCustodian = custodian;
      unsignedMessage = await _prepareConfirmTransaction();
      fees = await nekotonRepository.estimateFees(
        address: walletAddress,
        message: unsignedMessage,
      );

      final walletState = await nekotonRepository.walletsStream
          .expand((e) => e)
          .firstWhere((wallets) => wallets.address == walletAddress);

      if (walletState.hasError) {
        emitSafe(TonConfirmTransactionState.subscribeError(walletState.error!));

        return;
      }

      final wallet = walletState.wallet!;

      final balance = wallet.contractState.balance;

      final isPossibleToSendMessage = balance > (fees! + amount);

      if (!isPossibleToSendMessage) {
        emitSafe(
          TonConfirmTransactionState.calculatingError(
            LocaleKeys.insufficientFunds.tr(),
            selectedCustodian,
            fees,
          ),
        );

        return;
      }

      emitSafe(
        TonConfirmTransactionState.readyToSend(
          fees!,
          selectedCustodian,
        ),
      );
    } on Exception catch (e, t) {
      _logger.severe('_handlePrepare', e, t);
      emitSafe(
        TonConfirmTransactionState.calculatingError(
          e.toString(),
          selectedCustodian,
        ),
      );
    } finally {
      unsignedMessage?.dispose();
    }
  }

  Future<void> _handleSend(
    Emitter<TonConfirmTransactionState> emit,
    String password,
  ) async {
    UnsignedMessage? unsignedMessage;
    try {
      emitSafe(const TonConfirmTransactionState.sending(canClose: false));
      // await unsignedMessage.refreshTimeout();
      // TODO(komarov): fix refresh_timeout in nekoton
      unsignedMessage = await _prepareConfirmTransaction();

      final hash = unsignedMessage.hash;
      final transport = nekotonRepository.currentTransport.transport;

      final signature = await nekotonRepository.seedList.sign(
        data: hash,
        publicKey: selectedCustodian,
        password: password,
        signatureId: await transport.getSignatureId(),
      );

      final signedMessage = await unsignedMessage.sign(signature: signature);

      emitSafe(const TonConfirmTransactionState.sending(canClose: true));

      final transaction = await nekotonRepository.send(
        address: walletAddress,
        signedMessage: signedMessage,
        amount: amount,
        destination: destination,
      );

      inject<MessengerService>().show(
        Message.successful(
          context: context,
          message: LocaleKeys.transactionSentSuccessfully.tr(),
        ),
      );
      if (!isClosed) {
        add(TonConfirmTransactionEvent.completeSend(transaction));
      }
    } on OperationCanceledException catch (_) {
    } on Exception catch (e, t) {
      _logger.severe('_handleSend', e, t);
      inject<MessengerService>()
          .show(Message.error(context: context, message: e.toString()));
      emitSafe(
        TonConfirmTransactionState.readyToSend(
          fees!,
          selectedCustodian,
        ),
      );
    } finally {
      unsignedMessage?.dispose();
    }
  }

  Future<UnsignedMessage> _prepareConfirmTransaction() =>
      nekotonRepository.prepareConfirmTransaction(
        address: walletAddress,
        publicKey: selectedCustodian,
        transactionId: transactionId,
        expiration: defaultSendTimeout,
      );
}
