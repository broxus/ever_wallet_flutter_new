import 'package:nekoton_repository/nekoton_repository.dart';

// TODO(alex-a4): implement custom strategy when it will be implemented
/// Transport strategy for any different custom network
class CustomTransportStrategy extends TransportStrategy {
  CustomTransportStrategy({required this.transport});

  @override
  final Transport transport;

  @override
  String accountExplorerLink(Address accountAddress) => '';

  @override
  final availableWalletTypes = const [];

  @override
  String currencyUrl(String currencyAddress) => '';

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
  final manifestUrl = '';

  @override
  // TODO(alex-a4): implement nativeTokenIcon
  String get nativeTokenIcon => throw UnimplementedError();

  @override
  final nativeTokenTicker = '';

  // TODO(nesquikm): to be implemented
  @override
  final nativeTokenAddress = const Address(address: '');

  @override
  final networkName = '';

  @override
  final seedPhraseWordsCount = [12];

  @override
  String transactionExplorerLink(String transactionHash) => '';
}
