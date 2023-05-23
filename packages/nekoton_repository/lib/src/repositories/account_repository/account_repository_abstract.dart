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

  /// Remove accounts from storage.
  Future<void> removeAccounts(List<KeyAccount> accounts);
}
