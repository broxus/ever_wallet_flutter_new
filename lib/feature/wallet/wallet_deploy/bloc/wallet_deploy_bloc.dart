// ignore_for_file: use_build_context_synchronously

import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

part 'wallet_deploy_bloc.freezed.dart';
part 'wallet_deploy_event.dart';
part 'wallet_deploy_state.dart';

enum WalletDeployType { standard, multisig }

const defaultRequireConfirmations = 3;

/// Bloc that allows select type of wallet (standard/multisig) and deploy it.
/// All custodians must be entered in UI.
///
/// This bloc has 2 big steps:
/// 1) Preparing for deploy (selecting deploy type/entering custodians data)
/// 2) Sending transaction to blockchain
class WalletDeployBloc extends Bloc<WalletDeployEvent, WalletDeployState> {
  WalletDeployBloc({
    required this.context,
    required this.nekotonRepository,
    required this.address,
    required this.publicKey,
  }) : super(const WalletDeployState.standard()) {
    _registerHandlers();
  }

  final _logger = Logger('WalletDeployBloc');
  final BuildContext context;
  final NekotonRepository nekotonRepository;

  final Address address;
  final PublicKey publicKey;

  /// Fee for transaction after calculating it in [_handlePrepareDeploy]
  BigInt? fees;
  BigInt? balance;
  late UnsignedMessage unsignedMessage;
  UnsignedMessage? _unsignedMessage;

  /// Last selected type of deploying.
  /// For [WalletDeployType.multisig] [_cachedRequireConfirmations] and
  /// [_cachedCustodians] will be provided.
  WalletDeployType _type = WalletDeployType.standard;

  /// Cached values for ui for [WalletDeployType.multisig], values will be
  /// updated in [_DeployMultisig] or [_UpdateMultisigData] events.
  List<PublicKey> _cachedCustodians = [];
  int _cachedRequireConfirmations = defaultRequireConfirmations;

  // ignore: long-method
  void _registerHandlers() {
    on<_PrevStep>((_, emit) {
      fees = null;
      emit(
        switch (_type) {
          WalletDeployType.standard => const WalletDeployState.standard(),
          WalletDeployType.multisig => WalletDeployState.multisig(
              _cachedCustodians,
              _cachedRequireConfirmations,
            ),
        },
      );
    });
    on<_ChangeType>((event, emit) {
      if (event.type == _type) return;

      _type = event.type;
      emit(
        switch (event.type) {
          WalletDeployType.standard => const WalletDeployState.standard(),
          WalletDeployType.multisig => WalletDeployState.multisig(
              _cachedCustodians,
              _cachedRequireConfirmations,
            ),
        },
      );
    });
    on<_UpdateMultisigData>((event, _) {
      _cachedCustodians = event.custodians;
      _cachedRequireConfirmations = event.requireConfirmations;
    });
    on<_DeployStandard>((event, emit) => _handlePrepareStandard(emit));
    on<_DeployMultisig>(
      (event, emit) => _handlePrepareMultisig(
        emit,
        event.custodians,
        event.requireConfirmations,
      ),
    );
    on<_ConfirmDeploy>((event, emit) => _handleSend(emit, event.password));
    on<_AllowCloseDeploy>(
      (event, emit) => emit(const WalletDeployState.deploying(canClose: true)),
    );
    on<_CompleteDeploy>(
      (event, emit) => emit(
        WalletDeployState.deployed(
          fee: fees!,
          balance: balance!,
          transaction: event.transaction,
          custodians:
              _type == WalletDeployType.standard ? null : _cachedCustodians,
          requireConfirmations: _type == WalletDeployType.standard
              ? null
              : _cachedRequireConfirmations,
        ),
      ),
    );
  }

  Future<void> _handlePrepareStandard(
    Emitter<WalletDeployState> emit,
  ) async {
    try {
      unsignedMessage = await nekotonRepository.prepareDeploy(
        address,
        defaultSendTimeout,
      );
      _unsignedMessage = unsignedMessage;

      await _handlePrepareDeploy(emit);
    } on FfiException catch (e, t) {
      _logger.severe('_handlePrepareStandard', e, t);
      inject<MessengerService>()
          .show(Message.error(context: context, message: e.message));
    }
  }

  Future<void> _handlePrepareMultisig(
    Emitter<WalletDeployState> emit,
    List<PublicKey> custodians,
    int requireConfirmations,
  ) async {
    _cachedCustodians = custodians;
    _cachedRequireConfirmations = requireConfirmations;

    try {
      unsignedMessage = await nekotonRepository.prepareDeployWithMultipleOwners(
        address: address,
        custodians: custodians,
        reqConfirms: requireConfirmations,
        expiration: defaultSendTimeout,
        hours: null,
      );
      await _handlePrepareDeploy(emit, custodians, requireConfirmations);
    } on FfiException catch (e, t) {
      _logger.severe('_handlePrepareMultisig', e, t);
      inject<MessengerService>()
          .show(Message.error(context: context, message: e.message));
    }
  }

  // ignore: long-method
  Future<void> _handlePrepareDeploy(
    Emitter<WalletDeployState> emit, [
    List<PublicKey>? custodians,
    int? requireConfirmations,
  ]) async {
    try {
      final wallet = await nekotonRepository.walletsStream
          .expand((e) => e)
          .firstWhere((wallets) => wallets.address == address);

      if (wallet.hasError) {
        emit(WalletDeployState.subscribeError(wallet.error!));

        return;
      }

      balance = wallet.wallet!.contractState.balance;

      fees = await nekotonRepository.estimateFees(
        address: address,
        message: unsignedMessage,
      );

      final isPossibleToSendMessage = balance! > fees!;

      if (!isPossibleToSendMessage) {
        emit(
          WalletDeployState.calculatingError(
            error: LocaleKeys.insufficientFunds.tr(),
            fee: fees,
            requireConfirmations: requireConfirmations,
            custodians: custodians,
          ),
        );

        return;
      }

      emit(
        WalletDeployState.readyToDeploy(
          fee: fees!,
          balance: balance!,
          requireConfirmations: requireConfirmations,
          custodians: custodians,
        ),
      );
    } on FfiException catch (e, t) {
      _logger.severe('_handlePrepareDeploy', e, t);
      emit(
        WalletDeployState.calculatingError(
          error: e.message,
          balance: balance,
          fee: fees,
          requireConfirmations: requireConfirmations,
          custodians: custodians,
        ),
      );
    } on Exception catch (e, t) {
      _logger.severe('_handlePrepareDeploy', e, t);
      emit(
        WalletDeployState.calculatingError(
          error: e.toString(),
          fee: fees,
          balance: balance,
          requireConfirmations: requireConfirmations,
          custodians: custodians,
        ),
      );
    }
  }

  // ignore: long-method
  Future<void> _handleSend(
    Emitter<WalletDeployState> emit,
    String password,
  ) async {
    try {
      emit(const WalletDeployState.deploying(canClose: false));
      await unsignedMessage.refreshTimeout();

      final hash = unsignedMessage.hash;
      final transport = nekotonRepository.currentTransport.transport;

      final signature = await nekotonRepository.seedList.sign(
        data: hash,
        publicKey: publicKey,
        password: password,
        signatureId: await transport.getSignatureId(),
      );

      final signedMessage = await unsignedMessage.sign(signature: signature);

      add(const WalletDeployEvent.allowCloseDeploy());

      final transaction = await nekotonRepository.send(
        address: address,
        signedMessage: signedMessage,
        amount: fees!,
        destination: address,
      );

      inject<MessengerService>().show(
        Message.successful(
          context: context,
          message: LocaleKeys.walletDeployedSuccessfully.tr(),
        ),
      );
      if (!isClosed) {
        add(WalletDeployEvent.completeDeploy(transaction));
      }
    } on FfiException catch (e, t) {
      _logger.severe('_handleSend', e, t);
      inject<MessengerService>()
          .show(Message.error(context: context, message: e.message));
      emit(
        WalletDeployState.readyToDeploy(
          fee: fees!,
          balance: balance!,
          custodians:
              _type == WalletDeployType.standard ? null : _cachedCustodians,
          requireConfirmations: _type == WalletDeployType.standard
              ? null
              : _cachedRequireConfirmations,
        ),
      );
    } on Exception catch (e, t) {
      _logger.severe('_handleSend', e, t);
      inject<MessengerService>()
          .show(Message.error(context: context, message: e.toString()));
      emit(
        WalletDeployState.readyToDeploy(
          fee: fees!,
          balance: balance!,
          custodians:
              _type == WalletDeployType.standard ? null : _cachedCustodians,
          requireConfirmations: _type == WalletDeployType.standard
              ? null
              : _cachedRequireConfirmations,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _unsignedMessage?.dispose();

    return super.close();
  }
}
