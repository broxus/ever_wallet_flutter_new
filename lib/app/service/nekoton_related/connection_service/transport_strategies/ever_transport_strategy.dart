import 'package:nekoton_repository/nekoton_repository.dart';

/// Transport strategy for everscale network
class EverTransportStrategy extends TransportStrategy {
  EverTransportStrategy({required this.transport});

  @override
  final Transport transport;

  @override
  String accountExplorerLink(Address accountAddress) =>
      'https://everscan.io/accounts/${accountAddress.address}';

  @override
  final availableWalletTypes = const [
    WalletType.everWallet(),
    WalletType.multisig(MultisigType.multisig2),
    WalletType.multisig(MultisigType.multisig2_1),
    WalletType.walletV3(),
    WalletType.multisig(MultisigType.safeMultisigWallet),
    WalletType.multisig(MultisigType.safeMultisigWallet24h),
    WalletType.multisig(MultisigType.setcodeMultisigWallet),
    WalletType.multisig(MultisigType.setcodeMultisigWallet24h),
    WalletType.multisig(MultisigType.bridgeMultisigWallet),
    WalletType.multisig(MultisigType.surfWallet),
  ];

  @override
  String currencyUrl(String currencyAddress) =>
      'https://api.flatqube.io/v1/currencies/$currencyAddress';

  @override
  String defaultAccountName(WalletType walletType) => walletType.when(
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

  @override
  final defaultWalletType = const WalletType.everWallet();

  @override
  final manifestUrl =
      'https://raw.githubusercontent.com/broxus/ton-assets/master/manifest.json';

  @override
  // TODO(alex-a4): implement nativeTokenIcon
  String get nativeTokenIcon => throw UnimplementedError();

  @override
  final nativeTokenTicker = 'EVER';

  @override
  final nativeTokenAddress = const Address(
    address:
        '0:a49cd4e158a9a15555e624759e2e4e766d22600b7800d891e46f9291f044a93d',
  );

  @override
  final networkName = 'Everscale';

  @override
  final seedPhraseWordsCount = [12, 24];

  @override
  String transactionExplorerLink(String transactionHash) =>
      'https://everscan.io/transactions/$transactionHash';

  @override
  // ignore: no-magic-number
  int get defaultNativeCurrencyDecimal => 9;
}
