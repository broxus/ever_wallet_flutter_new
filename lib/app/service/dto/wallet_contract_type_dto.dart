// ignore_for_file: no-magic-number

import 'package:app/data/models/wallet_contract_type.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'wallet_contract_type_dto.g.dart';

@HiveType(typeId: 221)
enum WalletContractTypeDto {
  @HiveField(0)
  safeMultisigWallet,
  @HiveField(1)
  safeMultisigWallet24h,
  @HiveField(2)
  setcodeMultisigWallet,
  @HiveField(3)
  setcodeMultisigWallet24h,
  @HiveField(4)
  bridgeMultisigWallet,
  @HiveField(5)
  surfWallet,
  @HiveField(6)
  walletV3,
  @HiveField(7)
  highloadWalletV2,
  @HiveField(8)
  multisig2,
  @HiveField(9)
  everWallet,
  @HiveField(10)
  multisig2_1,
}

extension WalletContractTypeX on WalletContractType {
  WalletContractTypeDto toDto() {
    switch (this) {
      case WalletContractType.safeMultisigWallet:
        return WalletContractTypeDto.safeMultisigWallet;
      case WalletContractType.safeMultisigWallet24h:
        return WalletContractTypeDto.safeMultisigWallet24h;
      case WalletContractType.setcodeMultisigWallet:
        return WalletContractTypeDto.setcodeMultisigWallet;
      case WalletContractType.setcodeMultisigWallet24h:
        return WalletContractTypeDto.setcodeMultisigWallet24h;
      case WalletContractType.bridgeMultisigWallet:
        return WalletContractTypeDto.bridgeMultisigWallet;
      case WalletContractType.surfWallet:
        return WalletContractTypeDto.surfWallet;
      case WalletContractType.walletV3:
        return WalletContractTypeDto.walletV3;
      case WalletContractType.highloadWalletV2:
        return WalletContractTypeDto.highloadWalletV2;
      case WalletContractType.multisig2:
        return WalletContractTypeDto.multisig2;
      case WalletContractType.everWallet:
        return WalletContractTypeDto.everWallet;
      case WalletContractType.multisig2_1:
        return WalletContractTypeDto.multisig2_1;
      // ignore: no_default_cases
      default:
        throw Exception('Unknown WalletContractType: $this');
    }
  }
}

extension WalletContractTypeDtoX on WalletContractTypeDto {
  WalletContractType toModel() {
    switch (this) {
      case WalletContractTypeDto.safeMultisigWallet:
        return WalletContractType.safeMultisigWallet;
      case WalletContractTypeDto.safeMultisigWallet24h:
        return WalletContractType.safeMultisigWallet24h;
      case WalletContractTypeDto.setcodeMultisigWallet:
        return WalletContractType.setcodeMultisigWallet;
      case WalletContractTypeDto.setcodeMultisigWallet24h:
        return WalletContractType.setcodeMultisigWallet24h;
      case WalletContractTypeDto.bridgeMultisigWallet:
        return WalletContractType.bridgeMultisigWallet;
      case WalletContractTypeDto.surfWallet:
        return WalletContractType.surfWallet;
      case WalletContractTypeDto.walletV3:
        return WalletContractType.walletV3;
      case WalletContractTypeDto.highloadWalletV2:
        return WalletContractType.highloadWalletV2;
      case WalletContractTypeDto.multisig2:
        return WalletContractType.multisig2;
      case WalletContractTypeDto.everWallet:
        return WalletContractType.everWallet;
      case WalletContractTypeDto.multisig2_1:
        return WalletContractType.multisig2_1;
    }
  }
}
