import 'package:nekoton_repository/nekoton_repository.dart';

extension ExistingWalletInfoX on ExistingWalletInfo {
  /// Check if account is deployed or has money on balance.
  bool get isActive {
    final isDeployed = contractState.isDeployed;
    final balanceIsGreaterThanZero = contractState.balance > Fixed.zero;

    return isDeployed || balanceIsGreaterThanZero;
  }
}

extension AddressExtension on String {
  /// Get workchain id from account address where it's something like:
  /// 0:1fsagfsdgfas....
  int get workchain => int.parse(split(':').first);
}
