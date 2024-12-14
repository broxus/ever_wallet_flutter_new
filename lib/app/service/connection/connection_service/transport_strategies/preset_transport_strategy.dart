import 'package:app/data/models/connection/connection_data/connection_data.dart';
import 'package:app/data/models/connection/connection_transport/connection_transport_data.dart';
import 'package:app/data/models/connection/transport_manifest_option/transport_manifest_option.dart';
import 'package:app/data/models/connection/transport_native_token_option/transport_native_token_option.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class PresetTransportStrategy extends TransportStrategy {
  PresetTransportStrategy({
    required this.transport,
    required this.connection,
    required this.availableWalletTypes,
    required this.walletDefaultAccountNames,
    required this.defaultWalletType,
    required this.nativeTokenIcon,
    required this.nativeTokenTickerOption,
    required this.manifestOption,
    required this.nativeTokenAddress,
    required this.networkName,
    required this.seedPhraseWordsCount,
    required this.defaultNativeCurrencyDecimal,
    this.stakeInformation,
    this.tokenApiBaseUrl,
    this.currencyApiBaseUrl,
    String? baseCurrencyUrl,
  }) : baseCurrencyUrl = baseCurrencyUrl ?? '';

  @override
  final Transport transport;

  final ConnectionData connection;

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
  final String nativeTokenIcon;

  final TransportNativeTokenTickerOption nativeTokenTickerOption;

  final TransportManifestOption manifestOption;

  @override
  final Address nativeTokenAddress;

  @override
  final String networkName;

  @override
  final List<int> seedPhraseWordsCount;

  @override
  int defaultNativeCurrencyDecimal;

  final String baseCurrencyUrl;

  @override
  StakingInformation? stakeInformation;

  @override
  String? tokenApiBaseUrl;

  @override
  String? currencyApiBaseUrl;

  @override
  String get nativeTokenTicker => nativeTokenTickerOption.when(
        fromConnection: () => connection.nativeTokenTicker,
        byName: (String name) => name,
      );

  @override
  String accountExplorerLink(Address accountAddress) =>
      connection.blockExplorerUrl.isNotEmpty
          ? '${connection.blockExplorerUrl}/accounts/${accountAddress.address}'
          : '';

  @override
  String currencyUrl(String currencyAddress) =>
      '$baseCurrencyUrl/$currencyAddress';

  @override
  String defaultAccountName(WalletType walletType) => walletType.when(
        multisig: (type) => walletDefaultAccountNames.multisig[type] ?? '',
        walletV3: () => walletDefaultAccountNames.walletV3,
        highloadWalletV2: () => walletDefaultAccountNames.highloadWalletV2,
        everWallet: () => walletDefaultAccountNames.everWallet,
      );

  ///
  @override
  String transactionExplorerLink(String transactionHash) =>
      connection.blockExplorerUrl.isNotEmpty
          ? '${connection.blockExplorerUrl}/transactions/$transactionHash'
          : '';
}
