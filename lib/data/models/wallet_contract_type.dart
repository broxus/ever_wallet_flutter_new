import 'package:json_annotation/json_annotation.dart';

@JsonEnum(fieldRename: FieldRename.pascal)
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
}
