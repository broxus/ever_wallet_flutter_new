// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_contract_type_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WalletContractTypeDtoAdapter extends TypeAdapter<WalletContractTypeDto> {
  @override
  final int typeId = 221;

  @override
  WalletContractTypeDto read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return WalletContractTypeDto.safeMultisigWallet;
      case 1:
        return WalletContractTypeDto.safeMultisigWallet24h;
      case 2:
        return WalletContractTypeDto.setcodeMultisigWallet;
      case 3:
        return WalletContractTypeDto.setcodeMultisigWallet24h;
      case 4:
        return WalletContractTypeDto.bridgeMultisigWallet;
      case 5:
        return WalletContractTypeDto.surfWallet;
      case 6:
        return WalletContractTypeDto.walletV3;
      case 7:
        return WalletContractTypeDto.highloadWalletV2;
      case 8:
        return WalletContractTypeDto.multisig2;
      case 9:
        return WalletContractTypeDto.everWallet;
      case 10:
        return WalletContractTypeDto.multisig2_1;
      default:
        return WalletContractTypeDto.safeMultisigWallet;
    }
  }

  @override
  void write(BinaryWriter writer, WalletContractTypeDto obj) {
    switch (obj) {
      case WalletContractTypeDto.safeMultisigWallet:
        writer.writeByte(0);
        break;
      case WalletContractTypeDto.safeMultisigWallet24h:
        writer.writeByte(1);
        break;
      case WalletContractTypeDto.setcodeMultisigWallet:
        writer.writeByte(2);
        break;
      case WalletContractTypeDto.setcodeMultisigWallet24h:
        writer.writeByte(3);
        break;
      case WalletContractTypeDto.bridgeMultisigWallet:
        writer.writeByte(4);
        break;
      case WalletContractTypeDto.surfWallet:
        writer.writeByte(5);
        break;
      case WalletContractTypeDto.walletV3:
        writer.writeByte(6);
        break;
      case WalletContractTypeDto.highloadWalletV2:
        writer.writeByte(7);
        break;
      case WalletContractTypeDto.multisig2:
        writer.writeByte(8);
        break;
      case WalletContractTypeDto.everWallet:
        writer.writeByte(9);
        break;
      case WalletContractTypeDto.multisig2_1:
        writer.writeByte(10);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalletContractTypeDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
