import 'package:nekoton_repository/nekoton_repository.dart';

/// Repository that can be used in data-classes related to Accounts.
/// This repository can be used as <AccountRepositoryImpl> or you can add
/// custom logic.
abstract class AccountRepository {
  /// Add account to key with [publicKey] and [walletType].
  /// [workchain] specify Transport network that should be used for this account
  /// [name] is optional and if not specified, auto-generated name will be used.
  /// [explicitAddress] is used for external accounts where [publicKey] is
  /// custodian.
  Future<void> addAccount({
    required String publicKey,
    required WalletType walletType,
    required int workchain,
    String? name,
    String? explicitAddress,
  });

  /// Add external account with [address] where [publicKey] is custodian.
  /// [name] is optional.
  /// This method calls [addAccount] inside.
  Future<void> addExternalAccount({
    required String publicKey,
    required String address,
    String? name,
  });
}
