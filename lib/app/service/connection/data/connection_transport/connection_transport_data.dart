import 'package:app/app/service/connection/data/account_explorer/account_explorer_link_type.dart';
import 'package:app/app/service/connection/data/transaction_explorer/transaction_explorer_link_type.dart';
import 'package:app/app/service/connection/data/transport_icons.dart';
import 'package:app/app/service/connection/data/transport_manifest_option/transport_manifest_option.dart';
import 'package:app/app/service/connection/data/transport_native_token_option/transport_native_token_option.dart';
import 'package:app/app/service/connection/generic_token_subscriber.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class ConnectionTransportData {
  ConnectionTransportData({
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
    this.baseCurrencyUrl,
    this.stakeInformation,
    this.tokenApiBaseUrl,
    this.currencyApiBaseUrl,
  });

  final TransportIcons icons;
  final List<WalletType> availableWalletTypes;
  final WalletDefaultAccountNames walletDefaultAccountNames;
  final WalletType defaultWalletType;
  final String? baseCurrencyUrl;
  final TransportNativeTokenTickerOption nativeTokenTickerOption;
  final TransportManifestOption manifestOption;
  final Address nativeTokenAddress;
  final String networkName;
  final String networkType;
  final List<int> seedPhraseWordsCount;
  final int defaultNativeCurrencyDecimal;
  final GenericTokenType genericTokenType;
  final AccountExplorerLinkType accountExplorerLinkType;
  final TransactionExplorerLinkType transactionExplorerLinkType;
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
    required this.walletV4R1,
    required this.walletV4R2,
    required this.walletV5R1,
  });

  final Map<MultisigType, String> multisig;
  final String walletV3;
  final String highloadWalletV2;
  final String everWallet;
  final String walletV4R1;
  final String walletV4R2;
  final String walletV5R1;
}
