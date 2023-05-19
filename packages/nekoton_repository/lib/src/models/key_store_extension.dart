import 'package:get_it/get_it.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

extension KeyStoreExtension on KeyStoreEntry {
  /// This method allows removing only sub key.
  /// If you need remove seed, use [Seed.removeSeed].
  /// Returns true, if key was removed.
  Future<bool> remove() async {
    final removed =
        await GetIt.instance<SeedKeyRepository>().removeKeys([publicKey]);
    return removed.isNotEmpty;
  }

  /// Rename this key (sub or master) to [name].
  Future<void> rename({required String name}) =>
      GetIt.instance<SeedKeyRepository>().renameKey(
        publicKey: publicKey,
        masterKey: masterKey,
        name: name,
        isLegacy: isLegacy,
      );

  /// Input that can be used to decrypt/encrypt methods.
  /// [password] is the password of the seed
  SignInput signInput(String password) => isLegacy
      ? EncryptedKeyPassword(
          publicKey: publicKey,
          password: Password.explicit(
            PasswordExplicit(
              password: password,
              cacheBehavior: const PasswordCacheBehavior.nop(),
            ),
          ),
        )
      : DerivedKeySignParams.byAccountId(
          DerivedKeySignParamsByAccountId(
            masterKey: masterKey,
            accountId: accountId,
            password: Password.explicit(
              PasswordExplicit(
                password: password,
                cacheBehavior: const PasswordCacheBehavior.nop(),
              ),
            ),
          ),
        );
}
