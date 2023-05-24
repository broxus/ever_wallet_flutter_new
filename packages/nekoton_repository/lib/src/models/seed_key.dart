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

  /// Get account instance by it's address.
  /// This is a heavy operation and must not be called during build.
  /// This method can be helpful in browser.
  ///
  /// Returns found account or null.
  KeyAccount? getAccountByAddress(String accountAddress) {
    for (final account in accountList.allAccounts) {
      if (account.account.address == accountAddress) {
        return account;
      }
    }
    return null;
  }

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

  /// Returns list of Accounts that were already created for this key.
  /// !!! Returns not sorted for UI list.
  List<WalletType> get createdAccountTypes =>
      accountList.allAccounts.map((e) => e.account.tonWallet.contract).toList();

  /// Returns list of Accounts that can be created for this key in scope of
  /// current active transport.
  /// availableForTransport\created=availableForCreation.
  ///
  /// !!! Returns not sorted for UI list.
  List<WalletType> get availableForCreationAccountTypes {
    final created = createdAccountTypes;
    final availableForTransport = GetIt.instance<TransportRepository>()
        .currentTransport
        .availableWalletTypes;
    return availableForTransport.where((a) => !created.contains(a)).toList();
  }

  @override
  List<Object?> get props => [key, accountList];
}
