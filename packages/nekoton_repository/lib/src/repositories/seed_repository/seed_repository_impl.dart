import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Implementation of SeedRepository.
/// Usage
/// ```
/// class NekotonRepository with SeedRepositoryImpl {}
/// ```
mixin SeedKeyRepositoryImpl on TransportRepository
    implements SeedKeyRepository {
  KeyStore get keyStore;

  NekotonStorageRepository get storageRepository;

  @override
  Future<List<String>> deriveKeys({
    required List<int> accountIds,
    required String password,
    required String masterKey,
  }) async {
    final publicKeys = await keyStore.addKeys(
      accountIds
          .map(
            (accountId) => DerivedKeyCreateInput.derive(
              DerivedKeyCreateInputDerive(
                masterKey: masterKey,
                accountId: accountId,
                password: Password.explicit(
                  PasswordExplicit(
                    password: password,
                    cacheBehavior: const PasswordCacheBehavior.nop(),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );

    unawaited(triggerAddingAccounts(publicKeys));

    return publicKeys;
  }

  @override
  Future<String> addSeed({
    required List<String> phrase,
    required String password,
    String? name,
  }) async {
    final isLegacy = phrase.length == 24;
    final mnemonicType =
        isLegacy ? const MnemonicType.legacy() : const MnemonicType.labs(0);
    final phraseStr = phrase.join(' ');

    final CreateKeyInput createKeyInput;

    if (isLegacy) {
      createKeyInput = EncryptedKeyCreateInput(
        name: name,
        phrase: phraseStr,
        mnemonicType: mnemonicType,
        password: Password.explicit(
          PasswordExplicit(
            password: password,
            cacheBehavior: const PasswordCacheBehavior.nop(),
          ),
        ),
      );
    } else {
      createKeyInput = DerivedKeyCreateInput.import(
        DerivedKeyCreateInputImport(
          keyName: name,
          phrase: phraseStr,
          password: Password.explicit(
            PasswordExplicit(
              password: password,
              cacheBehavior: const PasswordCacheBehavior.nop(),
            ),
          ),
        ),
      );
    }

    final publicKey = await keyStore.addKey(createKeyInput);

    unawaited(triggerAddingAccounts([publicKey]));

    return publicKey;
  }

  /// Trigger adding accounts to [AccountRepository] by public keys.
  Future<void> triggerAddingAccounts(List<String> publicKeys) async {
    final foundAccounts = <ExistingWalletInfo>[];

    final transport = currentTransport;

    for (final key in publicKeys) {
      final found = await TonWallet.findExistingWallets(
        transport: transport.transport,
        workchainId: defaultWorkchainId,
        publicKey: key,
        walletTypes: transport.availableWalletTypes,
      );

      final activeAccounts = found.where((e) => e.isActive);

      foundAccounts.addAll(activeAccounts);
      // TODO(alex-a4): check if this logic really needed
      // final isExists = accounts.any((e) => e.address == activeWallet.
      // address);
    }

    await GetIt.instance<AccountRepository>().addAccounts(
      foundAccounts
          .map(
            (e) => AccountToAdd(
              publicKey: e.publicKey,
              contract: e.walletType,
              workchain: AddressUtils.workchain(e.address),
              name: transport.defaultAccountName(e.walletType),
            ),
          )
          .toList(),
    );
  }

  @override
  Future<void> changeSeedPassword({
    required String publicKey,
    required String oldPassword,
    required String newPassword,
    required bool isLegacy,
  }) async {
    final UpdateKeyInput updateKeyInput;

    if (isLegacy) {
      updateKeyInput = EncryptedKeyUpdateParams.changePassword(
        EncryptedKeyUpdateParamsChangePassword(
          publicKey: publicKey,
          oldPassword: Password.explicit(
            PasswordExplicit(
              password: oldPassword,
              cacheBehavior: const PasswordCacheBehavior.nop(),
            ),
          ),
          newPassword: Password.explicit(
            PasswordExplicit(
              password: newPassword,
              cacheBehavior: const PasswordCacheBehavior.nop(),
            ),
          ),
        ),
      );
    } else {
      updateKeyInput = DerivedKeyUpdateParams.changePassword(
        DerivedKeyUpdateParamsChangePassword(
          masterKey: publicKey,
          oldPassword: Password.explicit(
            PasswordExplicit(
              password: oldPassword,
              cacheBehavior: const PasswordCacheBehavior.nop(),
            ),
          ),
          newPassword: Password.explicit(
            PasswordExplicit(
              password: newPassword,
              cacheBehavior: const PasswordCacheBehavior.nop(),
            ),
          ),
        ),
      );
    }

    await keyStore.updateKey(updateKeyInput);
  }

  @override
  Future<void> renameKey({
    required String publicKey,
    required String masterKey,
    required String name,
    required bool isLegacy,
  }) async {
    final UpdateKeyInput updateKeyInput;

    if (isLegacy) {
      updateKeyInput = EncryptedKeyUpdateParams.rename(
        EncryptedKeyUpdateParamsRename(
          publicKey: publicKey,
          name: name,
        ),
      );
    } else {
      updateKeyInput = DerivedKeyUpdateParams.renameKey(
        DerivedKeyUpdateParamsRenameKey(
          masterKey: masterKey,
          publicKey: publicKey,
          name: name,
        ),
      );
    }

    await keyStore.updateKey(updateKeyInput);
  }

  @override
  Future<List<String>> exportKey({
    required String masterKey,
    required String password,
    required bool isLegacy,
  }) async {
    final ExportKeyInput exportKeyInput;

    if (isLegacy) {
      exportKeyInput = EncryptedKeyPassword(
        publicKey: masterKey,
        password: Password.explicit(
          PasswordExplicit(
            password: password,
            cacheBehavior: const PasswordCacheBehavior.nop(),
          ),
        ),
      );
    } else {
      exportKeyInput = DerivedKeyExportParams(
        masterKey: masterKey,
        password: Password.explicit(
          PasswordExplicit(
            password: password,
            cacheBehavior: const PasswordCacheBehavior.nop(),
          ),
        ),
      );
    }

    final exportKeyOutput = await keyStore.exportKey(exportKeyInput);

    final List<String> phrase;

    if (exportKeyInput is EncryptedKeyPassword) {
      phrase = (exportKeyOutput as EncryptedKeyExportOutput).phrase.split(' ');
    } else if (exportKeyInput is DerivedKeyExportParams) {
      phrase = (exportKeyOutput as DerivedKeyExportOutput).phrase.split(' ');
    } else {
      throw UnsupportedError('Invalid signer');
    }

    return phrase;
  }

  @override
  Future<List<EncryptedData>> encrypt({
    required String data,
    required List<String> publicKeys,
    required EncryptionAlgorithm algorithm,
    required SignInput signInput,
  }) =>
      keyStore.encrypt(
        data: data,
        publicKeys: publicKeys,
        algorithm: algorithm,
        input: signInput,
      );

  @override
  Future<String> decrypt({
    required EncryptedData data,
    required SignInput signInput,
  }) =>
      keyStore.decrypt(data: data, input: signInput);

  @override
  Future<String> sign({
    required String data,
    required SignInput signInput,
    required int? signatureId,
  }) =>
      keyStore.sign(
        data: data,
        input: signInput,
        signatureId: signatureId,
      );

  @override
  Future<SignedData> signData({
    required String data,
    required SignInput signInput,
    required int? signatureId,
  }) =>
      keyStore.signData(
        data: data,
        input: signInput,
        signatureId: signatureId,
      );

  @override
  Future<SignedDataRaw> signRawData({
    required String data,
    required SignInput signInput,
    required int? signatureId,
  }) =>
      keyStore.signDataRaw(
        data: data,
        input: signInput,
        signatureId: signatureId,
      );

  @override
  Future<List<String>> removeKeys(List<SeedKey> keys) async {
    final removed = await keyStore.removeKeys(
      publicKeys: keys.map((e) => e.key.publicKey).toList(),
    );
    unawaited(
      triggerRemovingAccounts(
        keys.where((k) => removed.contains(k.key.publicKey)),
      ),
    );
    return removed;
  }

  /// Remove accounts, specified for [keys] that were removed.
  /// Also removes information from storage about hidden and external accounts.
  Future<void> triggerRemovingAccounts(Iterable<SeedKey> keys) async {
    final accountsToRemove = <KeyAccount>[];

    for (final key in keys) {
      for (final account in key.accountList.allAccounts) {
        accountsToRemove.add(account);
      }
    }
    await GetIt.instance<AccountRepository>().removeAccounts(accountsToRemove);
  }
}
