import 'package:app/data/models/models.dart';
import 'package:app/generated/generated.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Transport strategy for tycho network
class TychoTransportStrategy extends TransportStrategy {
  TychoTransportStrategy({
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
      'https://api-test-tycho.flatqube.io/v1/currencies/$currencyAddress';

  @override
  String defaultAccountName(WalletType walletType) => walletType.when(
        multisig: (type) => switch (type) {
          MultisigType.safeMultisigWallet => 'SafeMultisig',
          MultisigType.safeMultisigWallet24h => 'SafeMultisig24h',
          MultisigType.setcodeMultisigWallet => 'SetcodeMultisig',
          MultisigType.setcodeMultisigWallet24h => 'SetcodeMultisig24h',
          MultisigType.bridgeMultisigWallet => 'BridgeMultisig',
          MultisigType.surfWallet => 'Surf Wallet',
          MultisigType.multisig2 => 'Legacy Multi-sig',
          MultisigType.multisig2_1 => 'Multi-sig',
        },
        walletV3: () => 'WalletV3',
        highloadWalletV2: () => 'HighloadWallet',
        everWallet: () => 'Default',
      );

  @override
  final defaultWalletType = const WalletType.everWallet();

  @override
  String get manifestUrl => connection.manifestUrl;

  @override
  String get nativeTokenIcon => Assets.images.tychoCoin.path;

  @override
  final nativeTokenTicker = 'TYCHO';

  @override
  final nativeTokenAddress = const Address(
    address:
        '0:6b3355b19c6aedc65be291c00abbf6e5061c07e1926a3fd543863c7a8d06cc79',
  );

  @override
  final networkName = 'Tycho Testnet';

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
  String? get tokenApiBaseUrl => null;
}
