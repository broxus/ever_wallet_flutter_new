import 'package:app/app/service/service.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:rxdart/rxdart.dart';

class AddAccountTypeModel extends ElementaryModel {
  AddAccountTypeModel(
    ErrorHandler errorHandler,
    this._messengerService,
    this._nekotonRepository,
  ) : super(errorHandler: errorHandler);

  final MessengerService _messengerService;
  final NekotonRepository _nekotonRepository;

  TransportStrategy get transport => _nekotonRepository.currentTransport;

  Future<Address> createAccount({
    required WalletType walletType,
    required PublicKey publicKey,
    required String password,
    required String? name,
  }) async {
    final seedKey = await _getSeedKey(
      publicKey: publicKey,
      walletType: walletType,
      password: password,
    );

    if (seedKey == null) throw Exception(LocaleKeys.createAccountError.tr());

    return seedKey.accountList.addAccount(
      walletType: walletType,
      workchain: defaultWorkchainId,
      name: name,
    );
  }

  void showError(String message) {
    _messengerService.show(
      Message.error(message: message),
    );
  }

  Future<SeedKey?> _getSeedKey({
    required WalletType walletType,
    required PublicKey publicKey,
    required String password,
  }) async {
    final seed = _nekotonRepository.seedList.findSeed(publicKey)!;

    if (!seed.masterKey.createdAccountTypes.contains(walletType)) {
      return seed.masterKey;
    }

    for (final key in seed.subKeys) {
      if (!key.createdAccountTypes.contains(walletType)) {
        return key;
      }
    }

    final addedKeys = seed.subKeys.map((item) => item.publicKey).toSet();
    final keys = await seed.getKeysToDerive(password);
    PublicKey? derivedKey;

    for (var i = 0; i < keys.length; i++) {
      final key = keys[i];

      if (addedKeys.contains(key)) continue;

      final found = await TonWallet.findExistingWallets(
        transport: transport.transport,
        workchainId: defaultWorkchainId,
        publicKey: key,
        walletTypes: [walletType],
      );

      if (found.any((item) => item.isActive)) continue;

      derivedKey = await seed.deriveKey(accountId: i, password: password);
      break;
    }

    if (derivedKey != null) {
      return _nekotonRepository.seedListStream
          .map((seedList) => seedList.findSeedKey(derivedKey!))
          .whereNotNull()
          .first;
    }

    return null;
  }
}
