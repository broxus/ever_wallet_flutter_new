import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Wrapper class for [KeyStoreEntry] that helps storing accounts and interact
/// with key.
@immutable
class SeedKey extends Equatable {
  const SeedKey({
    required this.key,
    required this.accountList,
  });

  /// Real key from blockchain
  final KeyStoreEntry key;

  /// List of accounts that specified for this [key]
  final AccountList accountList;

  /// This method allows removing only sub key.
  /// If you need remove seed, use [Seed.removeSeed].
  /// Returns true, if key was removed.
  Future<bool> remove() async {
    final removed =
        await GetIt.instance<SeedKeyRepository>().removeKeys([this]);
    return removed.isNotEmpty;
  }

  /// Rename this key (sub or master) to [name].
  Future<void> rename({required String name}) =>
      GetIt.instance<SeedKeyRepository>().renameKey(
        publicKey: key.publicKey,
        masterKey: key.masterKey,
        name: name,
        isLegacy: key.isLegacy,
      );

  /// Input that can be used to decrypt/encrypt methods.
  /// [password] is the password of the seed
  SignInput signInput(String password) => key.isLegacy
      ? EncryptedKeyPassword(
          publicKey: key.publicKey,
          password: Password.explicit(
            PasswordExplicit(
              password: password,
              cacheBehavior: const PasswordCacheBehavior.nop(),
            ),
          ),
        )
      : DerivedKeySignParams.byAccountId(
          DerivedKeySignParamsByAccountId(
            masterKey: key.masterKey,
            accountId: key.accountId,
            password: Password.explicit(
              PasswordExplicit(
                password: password,
                cacheBehavior: const PasswordCacheBehavior.nop(),
              ),
            ),
          ),
        );

  @override
  List<Object?> get props => [key, accountList];
}
