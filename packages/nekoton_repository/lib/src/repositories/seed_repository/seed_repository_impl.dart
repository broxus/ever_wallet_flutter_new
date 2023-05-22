import 'package:flutter_nekoton_bridge/flutter_nekoton_bridge.dart';
import 'package:nekoton_repository/src/repositories/seed_repository/seed_repository.dart';

/// Implementation of SeedRepository.
/// Usage
/// ```
/// class NekotonRepository with SeedRepositoryImpl {}
/// ```
mixin SeedKeyRepositoryImpl implements SeedKeyRepository {
  KeyStore get keyStore;

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

    // TODO(alex-a4): add logic to triger accounts adding

    return publicKeys.map((e) => e.publicKey).toList();
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

    final key = await keyStore.addKey(createKeyInput);

    // TODO(alex-a4): add logic to triger accounts adding

    return key.publicKey;
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
  Future<List<String>> removeKeys(List<String> publicKeys) async {
    final removed = await keyStore.removeKeys(publicKeys: publicKeys);
    return removed.map((e) => e.publicKey).toList();
  }
}
