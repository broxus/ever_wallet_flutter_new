import 'package:app/app/service/messenger/message.dart';
import 'package:app/app/service/messenger/service/messenger_service.dart';
import 'package:app/feature/wallet/ton_confirm_transaction/ton_confirm_transaction_screen.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/constants.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

/// [ElementaryModel] for [TonConfirmTransactionScreen]
class TonConfirmTransactionScreenModel extends ElementaryModel {
  TonConfirmTransactionScreenModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._messengerService,
    this._walletAddress,
    this.amount,
    this._transactionId,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final MessengerService _messengerService;
  final Address _walletAddress;
  final BigInt amount;
  final String _transactionId;

  late final account =
      _nekotonRepository.seedList.findAccountByAddress(_walletAddress);

  late final currency =
      Currencies()[_nekotonRepository.currentTransport.nativeTokenTicker];

  late final money = currency == null
      ? null
      : Money.fromBigIntWithCurrency(
          amount,
          currency!,
        );

  Future<UnsignedMessage> prepareConfirmTransaction(
    PublicKey selectedCustodian,
  ) =>
      _nekotonRepository.prepareConfirmTransaction(
        address: _walletAddress,
        publicKey: selectedCustodian,
        transactionId: _transactionId,
        expiration: defaultSendTimeout,
      );

  Future<BigInt> estimateFees(UnsignedMessage unsignedMessage) =>
      _nekotonRepository.estimateFees(
        address: _walletAddress,
        message: unsignedMessage,
      );

  // Получаем состояние кошелька и проверяем баланс
  Future<TonWalletState> get walletState => _nekotonRepository.walletsStream
      .expand((e) => e)
      .firstWhere((wallets) => wallets.address == _walletAddress);

  Future<SignedMessage> createSignedMessage({
    required String hash,
    required PublicKey selectedCustodian,
    required String password,
    required UnsignedMessage unsignedMessage,
  }) async {
    final transport = _nekotonRepository.currentTransport.transport;

    final signature = await _nekotonRepository.seedList.sign(
      data: hash,
      publicKey: selectedCustodian,
      password: password,
      signatureId: await transport.getSignatureId(),
    );

    return unsignedMessage.sign(signature: signature);
  }

  Future<Transaction> send({
    required SignedMessage signedMessage,
    required Address destination,
  }) =>
      _nekotonRepository.send(
        address: _walletAddress,
        signedMessage: signedMessage,
        amount: amount,
        destination: destination,
      );

  void showSuccessful(BuildContext? context) {
    _messengerService.show(
      Message.successful(
        context: context,
        message: LocaleKeys.transactionSentSuccessfully.tr(),
      ),
    );
  }

  void showError(BuildContext? context, Object e) {
    _messengerService.show(
      Message.error(
        context: context,
        message: e.toString(),
      ),
    );
  }
}
