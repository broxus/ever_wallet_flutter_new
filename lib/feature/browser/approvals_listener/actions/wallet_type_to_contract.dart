import 'package:app/data/models/models.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

extension WalletTypeToContract on WalletType {
  /// Extension that allows convert [WalletType] to [WalletContractType] for
  /// browser usage.
  WalletContractType toContractType() => when(
        multisig: (multisigType) {
          switch (multisigType) {
            case MultisigType.safeMultisigWallet:
              return WalletContractType.safeMultisigWallet;
            case MultisigType.safeMultisigWallet24h:
              return WalletContractType.safeMultisigWallet24h;
            case MultisigType.setcodeMultisigWallet:
              return WalletContractType.setcodeMultisigWallet;
            case MultisigType.setcodeMultisigWallet24h:
              return WalletContractType.setcodeMultisigWallet24h;
            case MultisigType.bridgeMultisigWallet:
              return WalletContractType.bridgeMultisigWallet;
            case MultisigType.surfWallet:
              return WalletContractType.surfWallet;
            case MultisigType.multisig2:
              return WalletContractType.multisig2;
            case MultisigType.multisig2_1:
              return WalletContractType.multisig2_1;
          }
        },
        everWallet: () => WalletContractType.everWallet,
        walletV3: () => WalletContractType.walletV3,
        highloadWalletV2: () => WalletContractType.highloadWalletV2,
        walletV4R1: () => WalletContractType.walletV4R1,
        walletV4R2: () => WalletContractType.walletV4R2,
        walletV5R1: () => WalletContractType.walletV5R1,
      );
}
