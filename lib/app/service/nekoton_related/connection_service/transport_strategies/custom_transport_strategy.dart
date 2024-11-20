import 'package:app/data/models/models.dart';
import 'package:app/generated/generated.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Transport strategy for any different custom network
class CustomTransportStrategy extends TransportStrategy {
  CustomTransportStrategy({
    required this.transport,
    required this.connection,
  });

  @override
  final Transport transport;

  final ConnectionData connection;

  @override
  String get manifestUrl => connection.manifestUrl;

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
  String currencyUrl(String currencyAddress) => '';

  @override
  String defaultAccountName(WalletType walletType) => walletType.when(
        multisig: (type) => switch (type) {
          MultisigType.safeMultisigWallet => 'SafeMultisig24h',
          MultisigType.safeMultisigWallet24h => 'SafeMultisig24h',
          MultisigType.setcodeMultisigWallet => 'SetcodeMultisig',
          MultisigType.setcodeMultisigWallet24h => 'SetcodeMultisig24h',
          MultisigType.bridgeMultisigWallet => 'BridgeMultisig',
          MultisigType.surfWallet => 'Surf wallet',
          MultisigType.multisig2 => 'Legacy Multisig',
          MultisigType.multisig2_1 => 'Multisig',
        },
        walletV3: () => 'WalletV3',
        highloadWalletV2: () => 'HighloadWalletV2',
        everWallet: () => 'Default',
      );

  @override
  final defaultWalletType = const WalletType.everWallet();

  @override
  String get nativeTokenIcon => Assets.images.tokenDefaultIcon.path;

  @override
  String get nativeTokenTicker => connection.nativeTokenTicker;

  @override
  final nativeTokenAddress = const Address(address: '');

  @override
  final networkName = 'custom';

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
