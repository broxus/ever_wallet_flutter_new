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
        multisig: (type) => switch (type) {
          MultisigType.safeMultisigWallet => 'SafeMultisig24h',
          MultisigType.safeMultisigWallet24h => 'SafeMultisig24h',
          MultisigType.setcodeMultisigWallet => 'SetcodeMultisig',
          MultisigType.setcodeMultisigWallet24h => 'SetcodeMultisig24h',
          MultisigType.bridgeMultisigWallet => 'BridgeMultisig',
          MultisigType.surfWallet => 'Surf Wallet',
          MultisigType.multisig2 => 'Legacy Multi-sig',
          MultisigType.multisig2_1 => 'Multi-sig',
        },
        walletV3: () => 'Legacy',
        highloadWalletV2: () => 'HighloadWallet',
        everWallet: () => 'Default',
        walletV4R1: () => 'WalletV4R1',
        walletV4R2: () => 'WalletV4R2',
        walletV5R1: () => 'WalletV5R1',
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

  @override
  String? get tokenApiBaseUrl => 'https://tokens.venomscan.com/v1';

  @override
  String? get currencyApiBaseUrl => 'https://api.web3.world/v1/currencies';
}
