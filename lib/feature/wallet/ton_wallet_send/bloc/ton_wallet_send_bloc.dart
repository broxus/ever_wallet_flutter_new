// ignore_for_file: use_build_context_synchronously

import 'package:app/app/service/service.dart';
import 'package:app/core/bloc/bloc_mixin.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

part 'ton_wallet_send_bloc.freezed.dart';
part 'ton_wallet_send_event.dart';
part 'ton_wallet_send_state.dart';

/// Bloc that allows prepare transaction to send native funds from [TonWallet]
/// for confirmation and send transaction.
class TonWalletSendBloc extends Bloc<TonWalletSendEvent, TonWalletSendState>
    with BlocBaseMixin {
  TonWalletSendBloc({
    required this.context,
    required this.nekotonRepository,
    required this.messengerService,
    required this.address,
    required this.publicKey,
    required this.destination,
    required this.amount,
    required this.comment,
    required this.resultMessage,
  }) : super(const TonWalletSendState.loading()) {
    _registerHandlers();
  }

  final _logger = Logger('TonWalletSendBloc');
  final BuildContext context;
  final NekotonRepository nekotonRepository;
  final MessengerService messengerService;

  /// Address of TonWallet that will be used to send funds
  final Address address;

  /// Custodian of [address] that will be initiator of transaction (for not
  /// multisig this is main key).
  final PublicKey publicKey;

  /// Address where funds should be sent
  final Address destination;

  /// Amount of tokens that should be sent
  final BigInt amount;

  /// Comment for transaction
  final String? comment;

  /// Message that will be shown when transaction sending completed
  final String resultMessage;

  /// Fee for transaction after calculating it in [_handlePrepare]
  BigInt? fees;

  KeyAccount? account;

  List<TxTreeSimulationErrorItem>? txErrors;

  TransportStrategy get transport => nekotonRepository.currentTransport;

  Currency get currency => Currencies()[transport.nativeTokenTicker]!;

  void _registerHandlers() {
    on<_Prepare>((event, emit) => _handlePrepare(emit));
    on<_Send>((event, emit) => _handleSend(emit, event.password));
    on<_CompleteSend>(
      (event, emit) {
        if (fees != null) {
          emitSafe(TonWalletSendState.sent(fees!, event.transaction));
        }
      },
    );
    on<_AllowCloseSend>(
      (event, emit) =>
          emitSafe(const TonWalletSendState.sending(canClose: true)),
    );
  }

  Future<void> _handlePrepare(Emitter<TonWalletSendState> emit) async {
    UnsignedMessage? unsignedMessage;
    try {
      account = nekotonRepository.seedList.findAccountByAddress(address);
      unsignedMessage = await _prepareTransfer();

      final result = await FutureExt.wait2(
        nekotonRepository.estimateFees(
          address: address,
          message: unsignedMessage,
        ),
        // TODO(komarov): remove when fixed in nekoton
        transport.networkType == 'ton'
            ? Future<List<TxTreeSimulationErrorItem>>.value([])
            : nekotonRepository.simulateTransactionTree(
                address: address,
                message: unsignedMessage,
              ),
      );
      fees = result.$1;
      txErrors = result.$2;

      final walletState = await nekotonRepository.walletsStream
          .expand((e) => e)
          .firstWhere((wallets) => wallets.address == address);

      if (walletState.hasError) {
        emitSafe(TonWalletSendState.subscribeError(walletState.error!));
        return;
      }

      final wallet = walletState.wallet!;
      final balance = wallet.contractState.balance;

      final isPossibleToSendMessage =
          fees != null && balance > (fees! + amount);

      if (!isPossibleToSendMessage) {
        emitSafe(
          TonWalletSendState.calculatingError(
            LocaleKeys.insufficientFunds.tr(),
            fees,
          ),
        );

        return;
      }

      if (fees != null) {
        emitSafe(TonWalletSendState.readyToSend(fees!, txErrors));
      }
    } on Exception catch (e, t) {
      _logger.severe('_handlePrepare', e, t);
      emitSafe(TonWalletSendState.calculatingError(e.toString()));
    } finally {
      unsignedMessage?.dispose();
    }
  }

  Future<void> _handleSend(
    Emitter<TonWalletSendState> emit,
    String password,
  ) async {
    UnsignedMessage? unsignedMessage;
    try {
      emitSafe(const TonWalletSendState.sending(canClose: false));

      // await unsignedMessage.refreshTimeout();
      // TODO(komarov): fix refresh_timeout in nekoton
      unsignedMessage = await _prepareTransfer();

      final hash = unsignedMessage.hash;
      final transport = nekotonRepository.currentTransport.transport;

      final signature = await nekotonRepository.seedList.sign(
        data: hash,
        publicKey: publicKey,
        password: password,
        signatureId: await transport.getSignatureId(),
      );

      final signedMessage = await unsignedMessage.sign(signature: signature);

      emitSafe(const TonWalletSendState.sending(canClose: true));

      final transaction = await nekotonRepository.send(
        address: address,
        signedMessage: signedMessage,
        amount: amount,
        destination: repackAddress(destination),
      );

      messengerService
          .show(Message.successful(context: context, message: resultMessage));
      if (!isClosed) {
        add(TonWalletSendEvent.completeSend(transaction));
      }
    } on OperationCanceledException catch (_) {
    } on Exception catch (e, t) {
      _logger.severe('_handleSend', e, t);
      messengerService
          .show(Message.error(context: context, message: e.toString()));

      if (fees != null) {
        emitSafe(TonWalletSendState.readyToSend(fees!, txErrors));
      }
    } finally {
      unsignedMessage?.dispose();
    }
  }

  Future<UnsignedMessage> _prepareTransfer() =>
      nekotonRepository.prepareTransfer(
        address: address,
        publicKey: publicKey,
        destination: repackAddress(destination),
        amount: amount,
        body: comment,
        bounce: defaultMessageBounce,
        expiration: defaultSendTimeout,
      );
}
