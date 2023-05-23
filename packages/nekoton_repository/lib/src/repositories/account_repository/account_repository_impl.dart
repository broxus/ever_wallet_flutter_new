import 'package:collection/collection.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Implementation of AccountRepository.
/// Usage
/// ```
/// class NekotonRepository with AccountRepositoryImpl {}
/// ```
mixin AccountRepositoryImpl on TransportRepository
    implements AccountRepository {
  /// Getter of nekoton's storage
  AccountsStorage get accountsStorage;

  NekotonStorageRepository get storageRepository;

  @override
  Future<void> addAccount(AccountToAdd account) =>
      accountsStorage.addAccount(account);

  @override
  Future<void> addAccounts(List<AccountToAdd> accounts) =>
      accountsStorage.addAccounts(accounts);

  @override
  Future<void> addExternalAccount({
    required String publicKey,
    required String address,
    String? name,
  }) async {
    final custodians = await TonWallet.getWalletCustodians(
      transport: currentTransport.transport,
      address: address,
    );

    final isCustodian = custodians.contains(publicKey);

    if (!isCustodian) throw Exception('Is not custodian');

    // Check if this account is part of publicKey
    final account =
        accountsStorage.accounts.firstWhereOrNull((e) => e.address == address);

    if (account == null) {
      final existingWalletInfo = await TonWallet.getExistingWalletInfo(
        transport: currentTransport.transport,
        address: address,
      );

      await addAccount(
        AccountToAdd(
          name: name ??
              currentTransport
                  .defaultAccountName(existingWalletInfo.walletType),
          publicKey: publicKey,
          contract: existingWalletInfo.walletType,
          workchain: existingWalletInfo.address.workchain,
          explicitAddress: address,
        ),
      );
      await storageRepository.addExternalAccount(
        publicKey: publicKey,
        address: address,
      );
    }
  }

  @override
  Future<void> removeAccounts(List<KeyAccount> accounts) {
    final addresses = accounts.map((e) => e.account.address).toList();

    final externalAccounts = <String, List<String>>{};
    for (final account in accounts) {
      if (externalAccounts.containsKey(account.publicKey)) {
        externalAccounts[account.publicKey]!.add(account.account.address);
      } else {
        externalAccounts[account.publicKey] = [account.account.address];
      }
    }

    for (final entry in externalAccounts.entries) {
      storageRepository.removeExternalAccounts(
        publicKey: entry.key,
        addresses: entry.value,
      );
    }
    storageRepository.showAccounts(addresses);

    return accountsStorage.removeAccounts(addresses);
  }
}
