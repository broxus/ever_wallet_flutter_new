import 'package:app/utils/constants.dart';
import 'package:app/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

class SendMessageModel extends ElementaryModel {
  SendMessageModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;

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

  KeyAccount? getAccount(Address address) =>
      _nekotonRepository.seedList.findAccountByAddress(address);

  Future<List<PublicKey>?> getLocalCustodiansAsync(Address address) =>
      _nekotonRepository.getLocalCustodiansAsync(address);

  Future<BigInt> estimateFees({
    required Address address,
    required Address destination,
    required PublicKey? publicKey,
    required BigInt amount,
    required FunctionCall? payload,
    required bool bounce,
  }) async {
    UnsignedMessage? message;

    try {
      final body = await payload?.let(
        (value) => encodeInternalInput(
          contractAbi: payload.abi,
          method: payload.method,
          input: payload.params,
        ),
      );

      message = await _nekotonRepository.prepareTransfer(
        address: address,
        publicKey: publicKey,
        destination: destination,
        amount: amount,
        body: body,
        bounce: bounce,
        expiration: defaultSendTimeout,
      );

      return await _nekotonRepository.estimateFees(
        address: address,
        message: message,
      );
    } finally {
      message?.dispose();
    }
  }

  String? getSeedName(PublicKey custodian) =>
      _nekotonRepository.seedList.findSeedKey(custodian)?.name;

  Future<(Address, RootTokenContractDetails)>
      getTokenRootDetailsFromTokenWallet(Address address) async {
    final details = await TokenWallet.getTokenRootDetailsFromTokenWallet(
      address: address,
      transport: transport.transport,
    );

    return (details.item1, details.item2);
  }
}
