import 'package:app/app/service/connection/data/account_explorer/account_explorer_link_type.dart';
import 'package:app/app/service/connection/data/connection_data/connection_data.dart';
import 'package:app/app/service/connection/data/connection_transport/connection_transport_data.dart';
import 'package:app/app/service/connection/data/transaction_explorer/transaction_explorer_link_type.dart';
import 'package:app/app/service/connection/data/transport_icons.dart';
import 'package:app/app/service/connection/data/transport_manifest_option/transport_manifest_option.dart';
import 'package:app/app/service/connection/data/transport_native_token_option/transport_native_token_option.dart';
import 'package:app/app/service/connection/generic_token_subscriber.dart';
import 'package:app/app/service/connection/group.dart';
import 'package:app/app/service/connection/network_type.dart';
import 'package:app/app/service/connection/transport_strategies/app_transport_strategy.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class CommonTransportStrategy extends AppTransportStrategy {
  CommonTransportStrategy({
    required this.transport,
    required this.connection,
    required this.icons,
    required this.availableWalletTypes,
    required this.walletDefaultAccountNames,
    required this.defaultWalletType,
    required this.nativeTokenTickerOption,
    required this.manifestOption,
    required this.nativeTokenAddress,
    required this.networkName,
    required this.networkType,
    required this.seedPhraseWordsCount,
    required this.defaultNativeCurrencyDecimal,
    required this.genericTokenType,
    required this.accountExplorerLinkType,
    required this.transactionExplorerLinkType,
    this.stakeInformation,
    this.tokenApiBaseUrl,
    this.currencyApiBaseUrl,
    String? baseCurrencyUrl,
  }) : baseCurrencyUrl = baseCurrencyUrl ?? '';

  factory CommonTransportStrategy.fromData(
    Transport transport,
    ConnectionData connection,
    ConnectionTransportData transportData,
  ) {
    return CommonTransportStrategy(
      transport: transport,
      connection: connection,
      icons: transportData.icons,
      availableWalletTypes: transportData.availableWalletTypes,
      walletDefaultAccountNames: transportData.walletDefaultAccountNames,
      defaultWalletType: transportData.defaultWalletType,
      nativeTokenTickerOption: transportData.nativeTokenTickerOption,
      manifestOption: transportData.manifestOption,
      nativeTokenAddress: transportData.nativeTokenAddress,
      networkName: transportData.networkName,
      networkType: transportData.networkType,
      seedPhraseWordsCount: transportData.seedPhraseWordsCount,
      defaultNativeCurrencyDecimal: transportData.defaultNativeCurrencyDecimal,
      genericTokenType: transportData.genericTokenType,
      accountExplorerLinkType: transportData.accountExplorerLinkType,
      transactionExplorerLinkType: transportData.transactionExplorerLinkType,
      stakeInformation: transportData.stakeInformation,
      tokenApiBaseUrl: transportData.tokenApiBaseUrl,
      currencyApiBaseUrl: transportData.currencyApiBaseUrl,
      baseCurrencyUrl: transportData.baseCurrencyUrl,
    );
  }

  @override
  final Transport transport;

  final ConnectionData connection;

  final TransportIcons icons;

  @override
  final List<WalletType> availableWalletTypes;

  final WalletDefaultAccountNames walletDefaultAccountNames;

  @override
  final WalletType defaultWalletType;

  @override
  String get manifestUrl => manifestOption.when(
        fromConnection: () => connection.manifestUrl,
      );

  @override
  String get nativeTokenIcon =>
      icons.nativeToken ?? Assets.images.nativeTokenDefault.path;

  final TransportNativeTokenTickerOption nativeTokenTickerOption;

  final TransportManifestOption manifestOption;

  @override
  final Address nativeTokenAddress;

  @override
  final String networkName;

  final NetworkType networkType;

  @override
  final List<int> seedPhraseWordsCount;

  @override
  int defaultNativeCurrencyDecimal;

  final GenericTokenType genericTokenType;

  final AccountExplorerLinkType accountExplorerLinkType;

  final TransactionExplorerLinkType transactionExplorerLinkType;

  final String baseCurrencyUrl;

  @override
  StakingInformation? stakeInformation;

  @override
  String? tokenApiBaseUrl;

  @override
  String? currencyApiBaseUrl;

  late final _subscriber = switch (genericTokenType) {
    GenericTokenType.tip3 => Tip3TokenWalletSubscriber(),
    GenericTokenType.jetton => JettonTokenWalletSubscriber(inject(), inject()),
  };

  NetworkGroup get networkGroup => transport.group;

  @override
  String get nativeTokenTicker => nativeTokenTickerOption.when(
        fromConnection: () => connection.nativeTokenTicker,
        byName: (String name) => name,
      );

  @override
  String accountExplorerLink(Address accountAddress) {
    if (connection.blockExplorerUrl.isEmpty) {
      return '';
    }

    return switch (accountExplorerLinkType) {
      AccountExplorerLinkType.accounts =>
        '${connection.blockExplorerUrl}/accounts/${accountAddress.address}',
      AccountExplorerLinkType.accountDetails =>
        '${connection.blockExplorerUrl}/accounts/accountDetails?id=${accountAddress.address}',
      AccountExplorerLinkType.packAddress =>
        '${connection.blockExplorerUrl}/${packAddress(accountAddress)}',
    };
  }

  @override
  String currencyUrl(String currencyAddress) =>
      baseCurrencyUrl.isNotEmpty ? '$baseCurrencyUrl/$currencyAddress' : '';

  @override
  String defaultAccountName(WalletType walletType) => walletType.when(
        multisig: (type) => walletDefaultAccountNames.multisig[type] ?? '',
        walletV3: () => walletDefaultAccountNames.walletV3,
        highloadWalletV2: () => walletDefaultAccountNames.highloadWalletV2,
        everWallet: () => walletDefaultAccountNames.everWallet,
        walletV4R1: () => walletDefaultAccountNames.walletV4R1,
        walletV4R2: () => walletDefaultAccountNames.walletV4R2,
        walletV5R1: () => walletDefaultAccountNames.walletV5R1,
      );

  @override
  String transactionExplorerLink(String transactionHash) {
    if (connection.blockExplorerUrl.isEmpty) {
      return '';
    }

    return switch (transactionExplorerLinkType) {
      TransactionExplorerLinkType.transaction =>
        '${connection.blockExplorerUrl}/transaction/$transactionHash',
      TransactionExplorerLinkType.transactions =>
        '${connection.blockExplorerUrl}/transactions/$transactionHash',
      TransactionExplorerLinkType.transactionDetails =>
        '${connection.blockExplorerUrl}/transactions/transactionDetails?id=$transactionHash',
    };
  }

  @override
  Future<GenericTokenWallet> subscribeToken({
    required Address owner,
    required Address rootTokenContract,
  }) =>
      _subscriber.subscribeToken(
        owner: owner,
        rootTokenContract: rootTokenContract,
        transport: transport,
      );
}
