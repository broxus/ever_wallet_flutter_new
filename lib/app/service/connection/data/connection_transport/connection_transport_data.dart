import 'package:app/app/service/connection/data/account_explorer/account_explorer_link_type.dart';
import 'package:app/app/service/connection/data/default_active_asset.dart';
import 'package:app/app/service/connection/data/transaction_explorer/transaction_explorer_link_type.dart';
import 'package:app/app/service/connection/data/transport_icons.dart';
import 'package:app/app/service/connection/data/transport_manifest_option/transport_manifest_option.dart';
import 'package:app/app/service/connection/data/transport_native_token_option/transport_native_token_option.dart';
import 'package:app/app/service/connection/generic_token_subscriber.dart';
import 'package:app/generated/generated.dart';
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
    List<DefaultActiveAsset>? defaultActiveAssets,
  }) : defaultActiveAssets = defaultActiveAssets ?? [];

  factory ConnectionTransportData.custom({
    required String networkType,
    required String networkName,
  }) =>
      ConnectionTransportData(
        networkType: networkType,
        networkName: networkName,
        icons: TransportIcons(
          nativeToken: Assets.images.tokenDefaultIcon.path,
          network: Assets.images.networkDefault.path,
          vector: Assets.images.networkVectorDefault.path,
        ),
        availableWalletTypes: const [
          WalletType.everWallet(),
          WalletType.multisig(MultisigType.multisig2_1),
        ],
        walletDefaultAccountNames: WalletDefaultAccountNames(
          multisig: {
            MultisigType.safeMultisigWallet: 'SafeMultisig24h',
            MultisigType.safeMultisigWallet24h: 'SafeMultisig24h',
            MultisigType.setcodeMultisigWallet: 'SetcodeMultisig',
            MultisigType.setcodeMultisigWallet24h: 'SetcodeMultisig24h',
            MultisigType.bridgeMultisigWallet: 'BridgeMultisig',
            MultisigType.surfWallet: 'Surf wallet',
            MultisigType.multisig2: 'Legacy Multisig',
            MultisigType.multisig2_1: 'Multisig',
          },
          walletV3: 'Wallet V3',
          highloadWalletV2: 'Highload Wallet V2',
          everWallet: 'Ever Wallet',
          walletV4R1: 'Wallet V4R1',
          walletV4R2: 'Wallet V4R2',
          walletV5R1: 'Wallet V5R1',
        ),
        defaultWalletType: const WalletType.everWallet(),
        nativeTokenTickerOption:
            const TransportNativeTokenTickerOption.fromConnection(),
        manifestOption: const TransportManifestOption.fromConnection(),
        nativeTokenAddress: const Address(address: ''),
        seedPhraseWordsCount: [12, 24],
        defaultNativeCurrencyDecimal: 9,
        genericTokenType: GenericTokenType.tip3,
        accountExplorerLinkType: AccountExplorerLinkType.accounts,
        transactionExplorerLinkType: TransactionExplorerLinkType.transactions,
      );

  final List<DefaultActiveAsset> defaultActiveAssets;
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
