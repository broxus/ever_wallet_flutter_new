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

  /// Getter of nekoton's storage
  KeyStore get keyStore;

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
          workchain: AddressUtils.workchain(existingWalletInfo.address),
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
    final local = <KeyAccount>[];
    final external = <KeyAccount>[];
    for (final account in accounts) {
      if (account.isExternal) {
        external.add(account);
      } else {
        local.add(account);
      }
    }
    return Future.wait([
      removeLocalAccounts(local),
      removeExternalAccounts(external),
    ]);
  }

  @override
  Future<void> removeLocalAccounts(List<KeyAccount> accounts) async {
    if (accounts.isEmpty) return;

    assert(
      accounts.every((a) => !a.isExternal),
      'All accounts must be local, to remove external use, '
      '$removeExternalAccounts',
    );

    final addresses = accounts.map((e) => e.account.address).toList();
    await storageRepository.showAccounts(addresses);
    await accountsStorage.removeAccounts(addresses);
  }

  /// Removing external account is quite complicated because first of all,
  /// we should remove external account mark from storage by its public key.
  /// Then we should check, if this account exists for any other public key,
  /// because one of them is custodian, another one is real owner.
  /// Then, if there is no other owners of this account, we remove it.
  @override
  Future<void> removeExternalAccounts(List<KeyAccount> accounts) async {
    if (accounts.isEmpty) return;

    assert(
      accounts.every((a) => a.isExternal),
      'All accounts must be external, to remove local use, '
      '$removeLocalAccounts',
    );

    final localKeys = keyStore.keys.map((e) => e.publicKey).toList();

    final externalAccounts = <String, List<String>>{};
    for (final account in accounts) {
      externalAccounts[account.publicKey] = [
        ...?externalAccounts[account.publicKey],
        account.account.address,
      ];
    }

    for (final entry in externalAccounts.entries) {
      await storageRepository.removeExternalAccounts(
        publicKey: entry.key,
        addresses: entry.value,
      );
    }

    final removeFromLocal = <KeyAccount>[];
    final updatedExternal =
        storageRepository.externalAccounts.values.expand((e) => e);
    for (final account in accounts) {
      final isStillExternal = updatedExternal.contains(account.account.address);
      final isLocal = localKeys.contains(account.account.publicKey);
      if (!isStillExternal && !isLocal) {
        removeFromLocal.add(account);
      }
    }

    final addresses = removeFromLocal.map((e) => e.account.address).toList();
    await storageRepository.showAccounts(addresses);
    await accountsStorage.removeAccounts(addresses);
  }

  @override
  Future<void> renameAccount(String address, String newName) =>
      accountsStorage.renameAccount(address, newName);

  @override
  Future<void> addTokenWallet({
    required String accountAddress,
    required String rootTokenContract,
  }) =>
      accountsStorage.addTokenWallet(
        accountAddress: accountAddress,
        rootTokenContract: rootTokenContract,
        networkGroup: currentTransport.transport.group,
      );

  @override
  Future<void> removeTokenWallet({
    required String accountAddress,
    required String rootTokenContract,
  }) =>
      accountsStorage.removeTokenWallet(
        accountAddress: accountAddress,
        rootTokenContract: rootTokenContract,
        networkGroup: currentTransport.transport.group,
      );
}
