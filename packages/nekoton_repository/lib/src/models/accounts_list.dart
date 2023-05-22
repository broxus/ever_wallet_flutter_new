import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import 'package:nekoton_repository/nekoton_repository.dart';

/// This list of accounts(assets) is a wrapper around List<AssetsList> with
/// additional logic.
@immutable
class AccountsList {
  const AccountsList(this.accounts);

  final List<AssetsList> accounts;

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
  }) {
    return GetIt.instance<AccountRepository>().addAccount(
      publicKey: publicKey,
      walletType: walletType,
      workchain: workchain,
      name: name,
      explicitAddress: explicitAddress,
    );
  }

  /// Add external account with [address] where [publicKey] is custodian.
  /// [name] is optional.
  /// This method calls [addAccount] inside.
  Future<void> addExternalAccount({
    required String publicKey,
    required String address,
    String? name,
  }) {
    return GetIt.instance<AccountRepository>().addExternalAccount(
      publicKey: publicKey,
      address: address,
      name: name,
    );
  }
}
