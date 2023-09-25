import 'package:nekoton_repository/nekoton_repository.dart';

String getDefaultAccountName(
  WalletType walletType, {
  Map<WalletType, String>? overrides,
}) {
  final overridden = overrides?[walletType];

  return overridden ??
      walletType.when(
        multisig: (multisigType) {
          switch (multisigType) {
            case MultisigType.safeMultisigWallet:
              return 'SafeMultisig';
            case MultisigType.safeMultisigWallet24h:
              return 'SafeMultisig24';
            case MultisigType.setcodeMultisigWallet:
              return 'SetcodeMultisig';
            case MultisigType.setcodeMultisigWallet24h:
              return 'SetcodeMultisig24';
            case MultisigType.bridgeMultisigWallet:
              return 'BridgeMultisig';
            case MultisigType.surfWallet:
              return 'Surf';
            case MultisigType.multisig2:
              return 'Multisig2';
            case MultisigType.multisig2_1:
              return 'Multisig2.1';
          }
        },
        everWallet: () => 'EVER Wallet',
        walletV3: () => 'WalletV3',
        highloadWalletV2: () => 'HighloadWalletV2',
      );
}
