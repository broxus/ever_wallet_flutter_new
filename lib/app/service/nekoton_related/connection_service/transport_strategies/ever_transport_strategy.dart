import 'package:app/data/models/models.dart';
import 'package:app/generated/generated.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Transport strategy for everscale network
class EverTransportStrategy extends TransportStrategy {
  EverTransportStrategy({
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
      'https://api.flatqube.io/v1/currencies/$currencyAddress';

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
        everWallet: () => 'EVER Wallet',
      );

  @override
  final defaultWalletType = const WalletType.everWallet();

  @override
  String get manifestUrl => connection.manifestUrl;

  @override
  String get nativeTokenIcon => Assets.images.everCoin.path;

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
      connection.blockExplorerUrl.isNotEmpty
          ? '${connection.blockExplorerUrl}/transactions/$transactionHash'
          : '';

  @override
  // ignore: no-magic-number
  int get defaultNativeCurrencyDecimal => 9;

  @override
  final stakeInformation = StakingInformation(
    stakingAPYLink: Uri.parse(
      'https://staking.everwallet.net/v1/strategies/main',
    ),
    stakingValutAddress: const Address(
      address:
          '0:675a6d63f27e3f24d41d286043a9286b2e3eb6b84fa4c3308cc2833ef6f54d68',
    ),
    stakingRootContractAddress: const Address(
      address:
          '0:6d42d0bc4a6568120ea88bf642edb653d727cfbd35868c47877532de128e71f2',
    ),
    stakeDepositAttachedFee: BigInt.parse('2000000000'),
    // 2 EVER
    stakeRemovePendingWithdrawAttachedFee: BigInt.parse('2000000000'),
    // 2 EVER
    stakeWithdrawAttachedFee: BigInt.parse('3000000000'), // 3 EVER
  );

  @override
  String? get tokenApiBaseUrl => 'https://tokens.everscan.io/v1';
}
