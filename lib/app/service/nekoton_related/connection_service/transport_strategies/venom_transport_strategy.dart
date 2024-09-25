import 'package:app/data/models/models.dart';
import 'package:app/generated/generated.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Transport strategy for venom network
class VenomTransportStrategy extends TransportStrategy {
  VenomTransportStrategy({
    required this.transport,
    required this.connection,
  });

  @override
  final Transport transport;

  final ConnectionData connection;

  @override
  String accountExplorerLink(Address accountAddress) =>
      connection.blockExplorerUrl.isNotEmpty
          ? '${connection.blockExplorerUrl}/accounts/${accountAddress.address}'
          : '';

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
  String get manifestUrl => connection.manifestUrl;

  @override
  String get nativeTokenIcon => Assets.images.venom.path;

  @override
  final nativeTokenTicker = 'VENOM';

  @override
  final nativeTokenAddress = const Address(
    address:
        '0:77d36848bb159fa485628bc38dc37eadb74befa514395e09910f601b841f749e',
  );

  @override
  final networkName = 'Venom';

  @override
  final seedPhraseWordsCount = [12];

  @override
  String transactionExplorerLink(String transactionHash) =>
      connection.blockExplorerUrl.isNotEmpty
          ? '${connection.blockExplorerUrl}/transactions/$transactionHash'
          : '';

  @override
  // ignore: no-magic-number
  int get defaultNativeCurrencyDecimal => 9;

  @override
  StakingInformation? get stakeInformation => null;
}
