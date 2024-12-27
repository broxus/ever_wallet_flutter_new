// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_interaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AccountInteractionImpl _$$AccountInteractionImplFromJson(
        Map<String, dynamic> json) =>
    _$AccountInteractionImpl(
      address: Address.fromJson(json['address'] as String),
      publicKey: PublicKey.fromJson(json['publicKey'] as String),
      contractType:
          $enumDecode(_$WalletContractTypeEnumMap, json['contractType']),
    );

Map<String, dynamic> _$$AccountInteractionImplToJson(
        _$AccountInteractionImpl instance) =>
    <String, dynamic>{
      'address': instance.address.toJson(),
      'publicKey': instance.publicKey.toJson(),
      'contractType': _$WalletContractTypeEnumMap[instance.contractType]!,
    };

const _$WalletContractTypeEnumMap = {
  WalletContractType.safeMultisigWallet: 'SafeMultisigWallet',
  WalletContractType.safeMultisigWallet24h: 'SafeMultisigWallet24h',
  WalletContractType.setcodeMultisigWallet: 'SetcodeMultisigWallet',
  WalletContractType.setcodeMultisigWallet24h: 'SetcodeMultisigWallet24h',
  WalletContractType.bridgeMultisigWallet: 'BridgeMultisigWallet',
  WalletContractType.surfWallet: 'SurfWallet',
  WalletContractType.walletV3: 'WalletV3',
  WalletContractType.highloadWalletV2: 'HighloadWalletV2',
  WalletContractType.everWallet: 'EverWallet',
  WalletContractType.multisig2: 'Multisig2',
  WalletContractType.multisig2_1: 'Multisig2_1',
  WalletContractType.walletV4R1: 'WalletV4R1',
  WalletContractType.walletV4R2: 'WalletV4R2',
  WalletContractType.walletV5R1: 'WalletV5R1',
};
