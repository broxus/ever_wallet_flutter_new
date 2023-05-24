import 'package:nekoton_repository/nekoton_repository.dart';

/// Repository that can be used in data-classes related to Accounts.
/// This repository can be used as <AccountRepositoryImpl> or you can add
/// custom logic.
abstract class AccountRepository {
  /// Add account to storage.
  Future<void> addAccount(AccountToAdd account);

  /// Add list of accounts to storage.
  /// Same as [addAccount] but for multiple accounts.
  Future<void> addAccounts(List<AccountToAdd> accounts);

  /// Add external account with [address] where [publicKey] is custodian.
  /// [name] is optional.
  /// This method calls [addAccount] inside.
  Future<void> addExternalAccount({
    required String publicKey,
    required String address,
    String? name,
  });

  /// This is a helper function, that calls [removeLocalAccounts] or
  /// [removeExternalAccounts] based on every account status.
  Future<void> removeAccounts(List<KeyAccount> accounts);

  /// Remove only local accounts from storage.
  /// Account is local if [KeyAccount.isExternal] is false
  Future<void> removeLocalAccounts(List<KeyAccount> accounts);

  /// Remove only external accounts from storage.
  /// Account is external if [KeyAccount.isExternal] is true
  Future<void> removeExternalAccounts(List<KeyAccount> accounts);

  /// Change name of account with [address] to [newName].
  Future<void> renameAccount(String address, String newName);

  /// Add token to [accountAddress] with [rootTokenContract].
  Future<void> addTokenWallet({
    required String accountAddress,
    required String rootTokenContract,
  });

  /// Remove token with [rootTokenContract] from [accountAddress].
  Future<void> removeTokenWallet({
    required String accountAddress,
    required String rootTokenContract,
  });
}
