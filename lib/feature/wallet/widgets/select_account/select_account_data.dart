import 'package:nekoton_repository/nekoton_repository.dart';

class SelectAccountData {
  SelectAccountData({
    required this.name,
    required this.privateKeys,
  });

  final String name;
  final List<SeedWithInfo> privateKeys;

  bool hasCurrentAccount(KeyAccount? account) {
    for (final seed in privateKeys) {
      if (seed.accounts.contains(account)) {
        return true;
      }
    }
    return false;
  }
}

class SeedWithInfo {
  SeedWithInfo({
    required this.keyName,
    required this.key,
    required this.accounts,
  });

  final String keyName;
  final String key;
  final List<KeyAccount> accounts;
}
