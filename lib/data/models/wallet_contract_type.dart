import 'package:json_annotation/json_annotation.dart';

part 'wallet_contract_type.g.dart';

@JsonEnum(fieldRename: FieldRename.pascal, alwaysCreate: true)
enum WalletContractType {
  safeMultisigWallet,
  safeMultisigWallet24h,
  setcodeMultisigWallet,
  setcodeMultisigWallet24h,
  bridgeMultisigWallet,
  surfWallet,
  walletV3,
  highloadWalletV2,
  everWallet,
  multisig2,
  multisig2_1,
  walletV4R1,
  walletV4R2,
  walletV5R1;

  String get jsonName => _$WalletContractTypeEnumMap[this]!;
}
