import 'package:nekoton_repository/nekoton_repository.dart';

sealed class WalletPrepareBalanceData {}

class WalletPrepareNativeBalanceData extends WalletPrepareBalanceData {
  WalletPrepareNativeBalanceData({
    required this.root,
    required this.symbol,
    required this.balance,
  });

  final Address root;
  final String symbol;
  final BigInt balance;
}

class WalletPrepareTokenBalanceData extends WalletPrepareBalanceData {
  WalletPrepareTokenBalanceData({
    required this.root,
    required this.symbol,
    required this.money,
  });

  final Address root;
  final String symbol;
  final Money money;
}

class WalletPrepareErrorBalanceData extends WalletPrepareBalanceData {
  WalletPrepareErrorBalanceData(this.error);

  final Exception? error;
}
