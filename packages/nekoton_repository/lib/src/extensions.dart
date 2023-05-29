import 'package:nekoton_repository/nekoton_repository.dart';

extension ExistingWalletInfoX on ExistingWalletInfo {
  /// Check if account is deployed or has money on balance.
  bool get isActive {
    final isDeployed = contractState.isDeployed;
    final balanceIsGreaterThanZero = contractState.balance > Fixed.zero;

    return isDeployed || balanceIsGreaterThanZero;
  }
}
