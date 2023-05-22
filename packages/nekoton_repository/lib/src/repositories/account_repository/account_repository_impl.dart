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

  @override
  Future<void> addAccount({
    required String publicKey,
    required WalletType walletType,
    required int workchain,
    String? name,
    String? explicitAddress,
  }) {
    return accountsStorage.addAccount(
      AccountToAdd(
        name: name ?? currentTransport.defaultAccountName(walletType),
        publicKey: publicKey,
        contract: walletType,
        workchain: workchain,
        explicitAddress: explicitAddress,
      ),
    );
  }

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
        name: name,
        publicKey: existingWalletInfo.publicKey,
        walletType: existingWalletInfo.walletType,
        workchain: existingWalletInfo.address.workchain,
        explicitAddress: address,
      );
    }
    return;
  }
}
