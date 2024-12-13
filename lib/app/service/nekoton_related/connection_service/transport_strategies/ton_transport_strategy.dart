part of 'transport_strategies.dart';

/// Transport strategy for ton network
class TonTransportStrategy extends AppTransportStrategy {
  TonTransportStrategy({
    required this.transport,
    required this.connection,
    required this.tonRepository,
  });

  @override
  final Transport transport;

  final ConnectionData connection;
  final TonRepository tonRepository;

  final Map<Address, Symbol> _symbolCache = {};

  @override
  String accountExplorerLink(Address accountAddress) => connection
          .blockExplorerUrl.isNotEmpty
      ? '${connection.blockExplorerUrl}/${packAddress(address: accountAddress)}'
      : '';

  @override
  final availableWalletTypes = const [
    WalletType.everWallet(),
    WalletType.multisig(MultisigType.multisig2_1),
    WalletType.walletV4R1(),
    WalletType.walletV4R2(),
    WalletType.walletV5R1(),
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
          MultisigType.surfWallet => 'Surf Wallet',
          MultisigType.multisig2 => 'Legacy Multi-sig',
          MultisigType.multisig2_1 => 'Multi-sig',
        },
        walletV3: () => 'Legacy',
        highloadWalletV2: () => 'HighloadWallet',
        everWallet: () => 'EverWallet',
        walletV4R1: () => 'WalletV4R1',
        walletV4R2: () => 'WalletV4R2',
        walletV5R1: () => 'WalletV5R1',
      );

  @override
  final defaultWalletType = const WalletType.walletV5R1();

  @override
  String get manifestUrl => connection.manifestUrl;

  @override
  String get nativeTokenIcon => Assets.images.networkTon.path;

  @override
  final nativeTokenTicker = 'TON';

  @override
  final nativeTokenAddress = const Address(
    address:
        '0:9a8da514d575d20234c3fb1395ee9138f5f1ad838abc905dc42c2389b46bd015',
  );

  @override
  final networkName = 'TON';

  @override
  final seedPhraseWordsCount = [12, 24];

  @override
  String transactionExplorerLink(String transactionHash) =>
      connection.blockExplorerUrl.isNotEmpty
          ? '${connection.blockExplorerUrl}/transaction/$transactionHash'
          : '';

  @override
  // ignore: no-magic-number
  int get defaultNativeCurrencyDecimal => 9;

  @override
  StakingInformation? get stakeInformation => null;

  @override
  String? get tokenApiBaseUrl => null;

  @override
  String? get currencyApiBaseUrl => null;

  @override
  Future<GenericTokenWallet> subscribeToken({
    required Address owner,
    required Address rootTokenContract,
  }) async =>
      JettonTokenWallet.subscribe(
        transport: transport,
        owner: owner,
        rootTokenContract: rootTokenContract,
        symbol: await _getSymbol(rootTokenContract),
      );

  Future<Symbol> _getSymbol(Address rootTokenContract) async {
    var symbol = _symbolCache[rootTokenContract];

    if (symbol == null) {
      final info = await tonRepository.getTokenInfo(
        address: rootTokenContract,
      );

      symbol = Symbol(
        name: info.symbol ?? 'UNKNOWN',
        fullName: info.name ?? 'Unknown token',
        decimals: info.decimals ?? 0,
        rootTokenContract: info.address,
      );
      _symbolCache[rootTokenContract] = symbol;
    }

    return symbol;
  }
}
