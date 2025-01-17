import 'package:app/app/service/service.dart';
import 'package:app/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:rxdart/rxdart.dart';

class SendMessageModel extends ElementaryModel {
  SendMessageModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._messengerService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final MessengerService _messengerService;

  TransportStrategy get transport => _nekotonRepository.currentTransport;

  Stream<Money> getBalanceStream(Address address) => _nekotonRepository
      .walletsStream
      .map((wallets) => wallets.firstWhereOrNull((w) => w.address == address))
      .mapNotNull((wallet) => wallet?.wallet?.contractState.balance)
      .map(
        (value) => Money.fromBigIntWithCurrency(
          value,
          Currencies()[transport.nativeTokenTicker]!,
        ),
      );

  Future<TonWalletState> getTonWalletState(Address address) async {
    final wallet = await _nekotonRepository.walletsStream
        .expand((e) => e)
        .firstWhere((wallets) => wallets.address == address);
    return wallet;
  }

  KeyAccount? getAccount(Address address) =>
      _nekotonRepository.seedList.findAccountByAddress(address);

  Future<List<PublicKey>?> getLocalCustodiansAsync(Address address) =>
      _nekotonRepository.getLocalCustodiansAsync(address);

  Future<UnsignedMessage> prepareTransfer({
    required Address address,
    required Address destination,
    required PublicKey? publicKey,
    required BigInt amount,
    required FunctionCall? payload,
    required bool bounce,
  }) async {
    final body = await payload?.let(
      (value) => encodeInternalInput(
        contractAbi: payload.abi,
        method: payload.method,
        input: payload.params,
      ),
    );

    return _nekotonRepository.prepareTransfer(
      address: address,
      publicKey: publicKey,
      destination: destination,
      amount: amount,
      body: body,
      bounce: bounce,
      expiration: defaultSendTimeout,
    );
  }

  Future<BigInt> estimateFees({
    required Address address,
    required UnsignedMessage message,
  }) =>
      _nekotonRepository.estimateFees(
        address: address,
        message: message,
      );

  Future<List<TxTreeSimulationErrorItem>> simulateTransactionTree({
    required Address address,
    required UnsignedMessage message,
  }) =>
      // TODO(komarov): remove when fixed in nekoton
      transport.networkType == 'ton'
          ? Future.value([])
          : _nekotonRepository.simulateTransactionTree(
              address: address,
              message: message,
            );

  String? getSeedName(PublicKey custodian) =>
      _nekotonRepository.seedList.findSeedKey(custodian)?.name;

  Future<(Address, RootTokenContractDetails)>
      getTokenRootDetailsFromTokenWallet(Address address) async {
    final details = await TokenWallet.getTokenRootDetailsFromTokenWallet(
      address: address,
      transport: transport.transport,
    );

    return details;
  }

  void showError(BuildContext context, String message) {
    _messengerService.show(
      Message.error(
        context: context,
        message: message,
      ),
    );
  }
}
