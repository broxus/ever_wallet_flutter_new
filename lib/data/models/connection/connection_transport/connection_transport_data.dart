import 'package:app/data/models/connection/transport_manifest_option/transport_manifest_option.dart';
import 'package:app/data/models/connection/transport_native_token_option/transport_native_token_option.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class ConnectionTransportData {
  ConnectionTransportData({
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
    this.baseCurrencyUrl,
    this.stakeInformation,
    this.tokenApiBaseUrl,
    this.currencyApiBaseUrl,
  });

  final List<WalletType> availableWalletTypes;
  final WalletDefaultAccountNames walletDefaultAccountNames;
  final WalletType defaultWalletType;
  final String? baseCurrencyUrl;
  final String nativeTokenIcon;
  final TransportNativeTokenTickerOption nativeTokenTickerOption;
  final TransportManifestOption manifestOption;
  final Address nativeTokenAddress;
  final String networkName;
  final List<int> seedPhraseWordsCount;
  final int defaultNativeCurrencyDecimal;
  final StakingInformation? stakeInformation;
  final String? tokenApiBaseUrl;
  final String? currencyApiBaseUrl;
}

class WalletDefaultAccountNames {
  WalletDefaultAccountNames({
    required this.multisig,
    required this.walletV3,
    required this.highloadWalletV2,
    required this.everWallet,
  });

  final Map<MultisigType, String> multisig;
  final String walletV3;
  final String highloadWalletV2;
  final String everWallet;
}
