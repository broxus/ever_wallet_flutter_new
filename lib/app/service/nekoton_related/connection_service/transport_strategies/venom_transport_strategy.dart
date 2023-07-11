import 'package:nekoton_repository/nekoton_repository.dart';

/// Transport strategy for venom network
class VenomTransportStrategy extends TransportStrategy {
  VenomTransportStrategy({required this.transport});

  @override
  final Transport transport;

  @override
  String accountExplorerLink(Address accountAddress) =>
      'https://venomscan.com/accounts/${accountAddress.address}';

  @override
  final availableWalletTypes = const [
    WalletType.everWallet(),
    WalletType.multisig(MultisigType.multisig2_1),
  ];

  @override
  String currencyUrl(String currencyAddress) =>
      'https://api.web3.world/v1/currencies/$currencyAddress';

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
              return 'Legacy Multisignature';
            case MultisigType.surfWallet:
              return 'Surf';
            case MultisigType.multisig2:
              return 'Multisig2';
            case MultisigType.multisig2_1:
              return 'Multisignature';
          }
        },
        everWallet: () => 'Default',
        walletV3: () => 'Legacy',
        highloadWalletV2: () => 'HighloadWalletV2',
      );

  @override
  final defaultWalletType = const WalletType.everWallet();

  @override
  final manifestUrl =
      'https://raw.githubusercontent.com/BVFDT/venom-assets/master/manifest.json';

  @override
  // TODO(alex-a4): implement nativeTokenIcon
  String get nativeTokenIcon => throw UnimplementedError();

  @override
  final nativeTokenTicker = 'VENOM';

  @override
  final nativeTokenAddress = const Address(
    address:
        '0:28237a5d5abb32413a79b5f98573074d3b39b72121305d9c9c97912fc06d843c',
  );

  @override
  final networkName = 'Venom';

  @override
  final seedPhraseWordsCount = [12];

  @override
  String transactionExplorerLink(String transactionHash) =>
      'https://venomscan.com/transactions/$transactionHash';
}
