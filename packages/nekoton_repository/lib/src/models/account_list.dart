import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import 'package:nekoton_repository/nekoton_repository.dart';

/// This list of accounts(assets) is a wrapper around List<KeyAccount> with
/// additional logic.
/// List of accounts specified for [publicKey].
@immutable
class AccountList extends Equatable {
  const AccountList({
    required this.allAccounts,
    required this.publicKey,
  });

  factory AccountList.empty(String publicKey) =>
      AccountList(allAccounts: const [], publicKey: publicKey);

  /// List of all accounts specified for [publicKey].
  final List<KeyAccount> allAccounts;

  /// Returns list of accounts that could be displayed to user in UI
  /// (not hidden accounts).
  List<KeyAccount> get displayAccounts =>
      allAccounts.where((a) => !a.isHidden).toList();

  /// Returns list of accounts that specified for [publicKey].
  List<KeyAccount> get localAccounts =>
      allAccounts.where((a) => !a.isExternal).toList();

  /// Returns list of accounts that specified for other publicKey, but this
  /// [publicKey] is custodian.
  List<KeyAccount> get externalAccounts =>
      allAccounts.where((a) => a.isExternal).toList();

  /// Key for which this list of accounts exists.
  final String publicKey;

  /// Add account to key with [publicKey] and [walletType].
  /// [workchain] specify Transport network that should be used for this account
  /// [name] is optional and if not specified, auto-generated name will be used.
  Future<void> addAccount({
    required WalletType walletType,
    required int workchain,
    String? name,
  }) {
    return GetIt.instance<AccountRepository>().addAccount(
      AccountToAdd(
        name: name ??
            GetIt.instance<TransportRepository>()
                .currentTransport
                .defaultAccountName(walletType),
        publicKey: publicKey,
        contract: walletType,
        workchain: workchain,
      ),
    );
  }

  /// Add external account with [address] where [publicKey] is custodian.
  /// [name] is optional.
  /// This method calls [addAccount] inside.
  Future<void> addExternalAccount({
    required String address,
    String? name,
  }) {
    return GetIt.instance<AccountRepository>().addExternalAccount(
      publicKey: publicKey,
      address: address,
      name: name,
    );
  }

  @override
  List<Object?> get props => [allAccounts, publicKey];
}
