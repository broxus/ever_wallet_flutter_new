import 'package:app/app/service/connection/data/account_explorer/account_explorer_link_type.dart';
import 'package:app/app/service/connection/data/connection_data/connection_data.dart';
import 'package:app/app/service/connection/data/connection_network/connection_network.dart';
import 'package:app/app/service/connection/data/connection_transport/connection_transport_data.dart';
import 'package:app/app/service/connection/data/transaction_explorer/transaction_explorer_link_type.dart';
import 'package:app/app/service/connection/data/transport_manifest_option/transport_manifest_option.dart';
import 'package:app/app/service/connection/data/transport_native_token_option/transport_native_token_option.dart';
import 'package:app/app/service/connection/generic_token_subscriber.dart';
import 'package:app/app/service/connection/mapping/connection_network_mapper.dart';
import 'package:app/generated/generated.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

const _presetsDomain = 'presets';

@singleton
class PresetsConnectionService {
  static const container = _presetsDomain;

  final _presetsConnectionsSubj = BehaviorSubject<ConnectionNetwork?>();

  ConnectionNetwork? get _data => _presetsConnectionsSubj.valueOrNull;

  List<ConnectionData> get networks => _data?.networks ?? [];

  Map<String, ConnectionTransportData> get transports =>
      _data?.transports ?? {};

  String? get defaultConnectionId => _data?.defaultConnectionId;

  ConnectionData? get defaultNetwork => _data?.defaultNetwork;

  String? currentPresetId;

  final _json = {
    "defaultConnectionId": "preset_ever_mainnet_proto",
    "networks": [
      {
        "id": "preset_ever_mainnet_proto",
        "name": "Everscale",
        "group": "mainnet",
        "type": "proto",
        "endpoints": [
          "https:/\/jrpc.everwallet.net"
        ],
        "networkType": "ever",
        "blockExplorerUrl": "https:/\/everscan.io",
        "manifestUrl": "https:/\/raw.githubusercontent.com/broxus/ton-assets/master/manifest.json",
        "sortingOrder": 1
      },
      {
        "id": "preset_ever_mainnet_gql",
        "name": "Everscale (reserve)",
        "group": "mainnet",
        "type": "gql",
        "endpoints": [
          "https:/\/mainnet.evercloud.dev/89a3b8f46a484f2ea3bdd364ddaee3a3/graphql"
        ],
        "networkType": "ever",
        "blockExplorerUrl": "https:/\/everscan.io",
        "manifestUrl":
        "https:/\/raw.githubusercontent.com/broxus/ton-assets/master/manifest.json",
        "sortingOrder": 2
      },
      {
        "id": "preset_venom_mainnet_proto",
        "name": "Venom",
        "group": "venom_mainnet",
        "type": "proto",
        "endpoints": [
          "https:/\/jrpc.venom.foundation"
        ],
        "networkType": "venom",
        "blockExplorerUrl": "https:/\/venomscan.com",
        "manifestUrl":
        "https:/\/cdn.venom.foundation/assets/mainnet/manifest.json",
        "sortingOrder": 3
      },
      {
        "id": "preset_tycho_testnet_proto",
        "name": "Tycho Testnet",
        "group": "tycho_testnet",
        "type": "proto",
        "endpoints": [
          "https:/\/rpc-testnet.tychoprotocol.com/"
        ],
        "networkType": "tycho",
        "blockExplorerUrl": "https:/\/testnet.tychoprotocol.com/",
        "manifestUrl":
        "https:/\/raw.githubusercontent.com/broxus/ton-assets/refs/heads/tychotestnet/manifest.json",
        "sortingOrder": 4
      },
      {
        "id": "preset_ton_mainnet_proto",
        "name": "TON",
        "group": "ton",
        "type": "proto",
        "endpoints": [
          "https:/\/jrpc-ton.broxus.com"
        ],
        "networkType": "ton",
        "blockExplorerUrl": "https:/\/tonviewer.com",
        "manifestUrl":
        "https:/\/raw.githubusercontent.com/broxus/ton-assets/refs/heads/ton/manifest.json",
        "sortingOrder": 5
      }
    ],
    "transports": [
      {
        "availableWalletTypes": [
          {
            "type": "everWallet"
          },
          {
            "type": "multisig",
            "value": "multisig2_1"
          }
        ],
        "walletDefaultAccountNames": {
          "multisig": {
            "safeMultisigWallet": "SafeMultisig24h",
            "safeMultisigWallet24h": "SafeMultisig24h",
            "setcodeMultisigWallet": "SetcodeMultisig",
            "setcodeMultisigWallet24h": "SetcodeMultisig24h",
            "bridgeMultisigWallet": "BridgeMultisig",
            "surfWallet": "Surf wallet",
            "multisig2": "Legacy Multisig",
            "multisig2_1": "Multisig"
          },
          "walletV3": "WalletV3",
          "highloadWalletV2": "HighloadWalletV2",
          "everWallet": "Default",
          "walletV4R1": "WalletV4R1",
          "walletV4R2": "WalletV4R2",
          "walletV5R1": "WalletV5R1"
        },
        "defaultWalletType": {
          "type": "everWallet"
        },
        "nativeTokenIcon": "TODO PATH",
        "nativeTokenTickerOption": {
          "type": "fromConnection"
        },
        "manifestOption": {
          "type": "fromConnection"
        },
        "nativeTokenAddress": "",
        "networkName": "custom",
        "networkType": "custom",
        "seedPhraseWordsCount": [12],
        "defaultNativeCurrencyDecimal": 9,
        "genericTokenType": "tip3",
        "accountExplorerLinkType": "accounts",
        "transactionExplorerLinkType": "transactions"
      },
      {
        "availableWalletTypes": [
          {
            "type": "everWallet"
          },
          {
            "type": "multisig",
            "value": "multisig2"
          },
          {
            "type": "multisig",
            "value": "multisig2_1"
          },
          {
            "type": "walletV3"
          },
          {
            "type": "multisig",
            "value": "safeMultisigWallet"
          },
          {
            "type": "multisig",
            "value": "safeMultisigWallet24h"
          },
          {
            "type": "multisig",
            "value": "setcodeMultisigWallet"
          },
          {
            "type": "multisig",
            "value": "setcodeMultisigWallet24h"
          },
          {
            "type": "multisig",
            "value": "bridgeMultisigWallet"
          },
          {
            "type": "multisig",
            "value": "surfWallet"
          }
        ],
        "walletDefaultAccountNames": {
          "multisig": {
            "safeMultisigWallet": "SafeMultisig",
            "safeMultisigWallet24h": "SafeMultisig24h",
            "setcodeMultisigWallet": "SetcodeMultisig",
            "setcodeMultisigWallet24h": "SetcodeMultisig24h",
            "bridgeMultisigWallet": "BridgeMultisig",
            "surfWallet": "Surf Wallet",
            "multisig2": "Legacy Multi-sig",
            "multisig2_1": "Multi-sig"
          },
          "walletV3": "WalletV3",
          "highloadWalletV2": "HighloadWallet",
          "everWallet": "EVER Wallet",
          "walletV4R1": "WalletV4R1",
          "walletV4R2": "WalletV4R2",
          "walletV5R1": "WalletV5R1"
        },
        "defaultWalletType": {
          "type": "everWallet"
        },
        "nativeTokenIcon": "TODO PATH",
        "nativeTokenTickerOption": {
          "type": "byName",
          "name": "EVER"
        },
        "manifestOption": {
          "type": "fromConnection"
        },
        "nativeTokenAddress": "0:a49cd4e158a9a15555e624759e2e4e766d22600b7800d891e46f9291f044a93d",
        "networkName": "Everscale",
        "networkType": "ever",
        "seedPhraseWordsCount": [12, 24],
        "defaultNativeCurrencyDecimal": 9,
        "baseCurrencyUrl": "https:/\/api.flatqube.io/v1/currencies",
        "stakeInformation": {
          "stakingAPYLink":  "https:/\/staking.everwallet.net/v1/strategies/main",
          "stakingValutAddress": "0:675a6d63f27e3f24d41d286043a9286b2e3eb6b84fa4c3308cc2833ef6f54d68",
          "stakingRootContractAddress": "0:6d42d0bc4a6568120ea88bf642edb653d727cfbd35868c47877532de128e71f2",
          "stakeDepositAttachedFee": "2000000000",
          "stakeRemovePendingWithdrawAttachedFee": "2000000000",
          "stakeWithdrawAttachedFee": "3000000000"
        },
        "tokenApiBaseUrl": "https:/\/tokens.everscan.io/v1",
        "currencyApiBaseUrl": "https:/\/api.flatqube.io/v1/currencies",
        "genericTokenType": "tip3",
        "accountExplorerLinkType": "accounts",
        "transactionExplorerLinkType": "transactions"
      },
      {
        "availableWalletTypes": [
          {
            "type": "everWallet"
          },
          {
            "type": "multisig",
            "value": "multisig2"
          },
          {
            "type": "multisig",
            "value": "multisig2_1"
          },
          {
            "type": "walletV3"
          },
          {
            "type": "multisig",
            "value": "safeMultisigWallet"
          },
          {
            "type": "multisig",
            "value": "safeMultisigWallet24h"
          },
          {
            "type": "multisig",
            "value": "setcodeMultisigWallet"
          },
          {
            "type": "multisig",
            "value": "setcodeMultisigWallet24h"
          },
          {
            "type": "multisig",
            "value": "bridgeMultisigWallet"
          },
          {
            "type": "multisig",
            "value": "surfWallet"
          }
        ],
        "walletDefaultAccountNames": {
          "multisig": {
            "safeMultisigWallet": "SafeMultisig",
            "safeMultisigWallet24h": "SafeMultisig24h",
            "setcodeMultisigWallet": "SetcodeMultisig",
            "setcodeMultisigWallet24h": "SetcodeMultisig24h",
            "bridgeMultisigWallet": "BridgeMultisig",
            "surfWallet": "Surf Wallet",
            "multisig2": "Legacy Multi-sig",
            "multisig2_1": "Multi-sig"
          },
          "walletV3": "WalletV3",
          "highloadWalletV2": "HighloadWallet",
          "everWallet": "Default",
          "walletV4R1": "WalletV4R1",
          "walletV4R2": "WalletV4R2",
          "walletV5R1": "WalletV5R1"
        },
        "defaultWalletType": {
          "type": "everWallet"
        },
        "nativeTokenIcon": "TODO PATH",
        "nativeTokenTickerOption": {
          "type": "byName",
          "name": "TYCHO"
        },
        "manifestOption": {
          "type": "fromConnection"
        },
        "nativeTokenAddress": "0:6b3355b19c6aedc65be291c00abbf6e5061c07e1926a3fd543863c7a8d06cc79",
        "networkName": "Tycho Testnet",
        "networkType": "tycho",
        "seedPhraseWordsCount": [12],
        "defaultNativeCurrencyDecimal": 9,
        "baseCurrencyUrl": "https:/\/api-test-tycho.flatqube.io/v1/currencies",
        "genericTokenType": "tip3",
        "accountExplorerLinkType": "accounts",
        "transactionExplorerLinkType": "transactions"
      },
      {
        "availableWalletTypes": [
          {
            "type": "everWallet"
          },
          {
            "type": "multisig",
            "value": "multisig2_1"
          }
        ],
        "walletDefaultAccountNames": {
          "multisig": {
            "safeMultisigWallet": "SafeMultisig24h",
            "safeMultisigWallet24h": "SafeMultisig24h",
            "setcodeMultisigWallet": "SetcodeMultisig",
            "setcodeMultisigWallet24h": "SetcodeMultisig24h",
            "bridgeMultisigWallet": "BridgeMultisig",
            "surfWallet": "Surf Wallet",
            "multisig2": "Legacy Multi-sig",
            "multisig2_1": "Multi-sig"
          },
          "walletV3": "Legacy",
          "highloadWalletV2": "HighloadWallet",
          "everWallet": "Default",
          "walletV4R1": "WalletV4R1",
          "walletV4R2": "WalletV4R2",
          "walletV5R1": "WalletV5R1"
        },
        "defaultWalletType": {
          "type": "everWallet"
        },
        "nativeTokenIcon": "TODO PATH",
        "nativeTokenTickerOption": {
          "type": "byName",
          "name": "VENOM"
        },
        "manifestOption": {
          "type": "fromConnection"
        },
        "nativeTokenAddress": "0:77d36848bb159fa485628bc38dc37eadb74befa514395e09910f601b841f749e",
        "networkName": "Venom",
        "networkType": "venom",
        "seedPhraseWordsCount": [12],
        "defaultNativeCurrencyDecimal": 9,
        "baseCurrencyUrl": "https:/\/api.web3.world/v1/currencies",
        "tokenApiBaseUrl": "https:/\/tokens.venomscan.com/v1",
        "currencyApiBaseUrl": "https:/\/api.web3.world/v1/currencies",
        "genericTokenType": "tip3",
        "accountExplorerLinkType": "accounts",
        "transactionExplorerLinkType": "transactions"
      },
      {
        "availableWalletTypes": [
          {
            "type": "everWallet"
          },
          {
            "type": "multisig",
            "value": "multisig2_1"
          },
          {
            "type": "walletV4R1"
          },
          {
            "type": "walletV4R2"
          },
          {
            "type": "walletV5R1"
          }
        ],
        "walletDefaultAccountNames": {
          "multisig": {
            "safeMultisigWallet": "SafeMultisig24h",
            "safeMultisigWallet24h": "SafeMultisig24h",
            "setcodeMultisigWallet": "SetcodeMultisig",
            "setcodeMultisigWallet24h": "SetcodeMultisig24h",
            "bridgeMultisigWallet": "BridgeMultisig",
            "surfWallet": "Surf Wallet",
            "multisig2": "Legacy Multi-sig",
            "multisig2_1": "Multi-sig"
          },
          "walletV3": "Legacy",
          "highloadWalletV2": "HighloadWallet",
          "everWallet": "EverWallet",
          "walletV4R1": "WalletV4R1",
          "walletV4R2": "WalletV4R2",
          "walletV5R1": "WalletV5R1"
        },
        "defaultWalletType": {
          "type": "walletV5R1"
        },
        "nativeTokenIcon": "TODO PATH",
        "nativeTokenTickerOption": {
          "type": "byName",
          "name": "TON"
        },
        "manifestOption": {
          "type": "fromConnection"
        },
        "nativeTokenAddress": "0:9a8da514d575d20234c3fb1395ee9138f5f1ad838abc905dc42c2389b46bd015",
        "networkName": "TON",
        "networkType": "ton",
        "seedPhraseWordsCount": [12, 24],
        "defaultNativeCurrencyDecimal": 9,
        "genericTokenType": "jetton",
        "accountExplorerLinkType": "packAddress",
        "transactionExplorerLinkType": "transaction"
      }
    ]
  };

  Future<void> fetchConnectionsList() async {
    final data = await Future.value(
      mapToConnectionNetworkFromJson(_json),
      // ConnectionNetwork(
      // defaultConnectionId: 'preset_ever_mainnet_proto',
      // networks: [
      // ConnectionData.protoPreset(
      //   id: 'preset_ever_mainnet_proto',
      //   name: 'Everscale',
      //   group: 'mainnet',
      //   endpoint: 'https://jrpc.everwallet.net',
      //   networkType: 'ever',
      //   canBeEdited: false,
      //   blockExplorerUrl: 'https://everscan.io',
      //   manifestUrl:
      //       'https://raw.githubusercontent.com/broxus/ton-assets/master/manifest.json',
      //   sortingOrder: 1,
      // ),
      // ConnectionData.gqlPreset(
      //   id: 'preset_ever_mainnet_gql',
      //   name: 'Everscale (reserve)',
      //   group: 'mainnet',
      //   endpoints: [
      //     'https://mainnet.evercloud.dev/89a3b8f46a484f2ea3bdd364ddaee3a3/graphql',
      //   ],
      //   networkType: 'ever',
      //   canBeEdited: false,
      //   blockExplorerUrl: 'https://everscan.io',
      //   manifestUrl:
      //       'https://raw.githubusercontent.com/broxus/ton-assets/master/manifest.json',
      //   sortingOrder: 2,
      // ),
      // ConnectionData.protoPreset(
      //   id: 'preset_venom_mainnet_proto',
      //   name: 'Venom',
      //   group: 'venom_mainnet',
      //   endpoint: 'https://jrpc.venom.foundation',
      //   networkType: 'venom',
      //   canBeEdited: false,
      //   blockExplorerUrl: 'https://venomscan.com',
      //   manifestUrl:
      //       'https://cdn.venom.foundation/assets/mainnet/manifest.json',
      //   sortingOrder: 3,
      // ),
      // ConnectionData.protoPreset(
      //   id: 'preset_tycho_testnet_proto',
      //   name: 'Tycho Testnet',
      //   group: 'tycho_testnet',
      //   endpoint: 'https://rpc-testnet.tychoprotocol.com/',
      //   networkType: 'tycho',
      //   canBeEdited: false,
      //   blockExplorerUrl: 'https://testnet.tychoprotocol.com/',
      //   manifestUrl:
      //       'https://raw.githubusercontent.com/broxus/ton-assets/refs/heads/tychotestnet/manifest.json',
      //   sortingOrder: 4,
      // ),
      // ConnectionData.protoPreset(
      //   id: 'preset_ton_mainnet_proto',
      //   name: 'TON',
      //   group: 'ton',
      //   endpoint: 'https://jrpc-ton.broxus.com',
      //   networkType: 'ton',
      //   canBeEdited: false,
      //   blockExplorerUrl: 'https://tonviewer.com',
      //   manifestUrl:
      //       'https://raw.githubusercontent.com/broxus/ton-assets/refs/heads/ton/manifest.json',
      //   sortingOrder: 5,
      // ),
      // ],
      // transports: {
      //   'custom': _custom,
      //   'ever': _ever,
      //   'tycho': _tycho,
      //   'venom': _venom,
      //   'ton': _ton,
      // },
      // ),
    );

    _presetsConnectionsSubj.add(data);
  }
}

// final _custom = ConnectionTransportData(
//   availableWalletTypes: const [
//     WalletType.everWallet(),
//     WalletType.multisig(MultisigType.multisig2_1),
//   ],
//   walletDefaultAccountNames: WalletDefaultAccountNames(
//     multisig: <MultisigType, String>{
//       MultisigType.safeMultisigWallet: 'SafeMultisig24h',
//       MultisigType.safeMultisigWallet24h: 'SafeMultisig24h',
//       MultisigType.setcodeMultisigWallet: 'SetcodeMultisig',
//       MultisigType.setcodeMultisigWallet24h: 'SetcodeMultisig24h',
//       MultisigType.bridgeMultisigWallet: 'BridgeMultisig',
//       MultisigType.surfWallet: 'Surf wallet',
//       MultisigType.multisig2: 'Legacy Multisig',
//       MultisigType.multisig2_1: 'Multisig',
//     },
//     walletV3: 'WalletV3',
//     highloadWalletV2: 'HighloadWalletV2',
//     everWallet: 'Default',
//     walletV4R1: 'WalletV4R1',
//     walletV4R2: 'WalletV4R2',
//     walletV5R1: 'WalletV5R1',
//   ),
//   defaultWalletType: const WalletType.everWallet(),
//   nativeTokenIcon: Assets.images.tokenDefaultIcon.path,
//   nativeTokenTickerOption:
//       const TransportNativeTokenTickerOption.fromConnection(),
//   manifestOption: const TransportManifestOption.fromConnection(),
//   nativeTokenAddress: const Address(address: ''),
//   networkName: 'custom',
//   networkType: 'custom',
//   seedPhraseWordsCount: [12],
//   defaultNativeCurrencyDecimal: 9,
//   genericTokenType: GenericTokenType.tip3,
//   accountExplorerLinkType: AccountExplorerLinkType.accounts,
//   transactionExplorerLinkType: TransactionExplorerLinkType.transactions,
// );

// final _ever = ConnectionTransportData(
//   availableWalletTypes: const [
//     WalletType.everWallet(),
//     WalletType.multisig(MultisigType.multisig2),
//     WalletType.multisig(MultisigType.multisig2_1),
//     WalletType.walletV3(),
//     WalletType.multisig(MultisigType.safeMultisigWallet),
//     WalletType.multisig(MultisigType.safeMultisigWallet24h),
//     WalletType.multisig(MultisigType.setcodeMultisigWallet),
//     WalletType.multisig(MultisigType.setcodeMultisigWallet24h),
//     WalletType.multisig(MultisigType.bridgeMultisigWallet),
//     WalletType.multisig(MultisigType.surfWallet),
//   ],
//   walletDefaultAccountNames: WalletDefaultAccountNames(
//     multisig: <MultisigType, String>{
//       MultisigType.safeMultisigWallet: 'SafeMultisig',
//       MultisigType.safeMultisigWallet24h: 'SafeMultisig24h',
//       MultisigType.setcodeMultisigWallet: 'SetcodeMultisig',
//       MultisigType.setcodeMultisigWallet24h: 'SetcodeMultisig24h',
//       MultisigType.bridgeMultisigWallet: 'BridgeMultisig',
//       MultisigType.surfWallet: 'Surf Wallet',
//       MultisigType.multisig2: 'Legacy Multi-sig',
//       MultisigType.multisig2_1: 'Multi-sig',
//     },
//     walletV3: 'WalletV3',
//     highloadWalletV2: 'HighloadWallet',
//     everWallet: 'EVER Wallet',
//     walletV4R1: 'WalletV4R1',
//     walletV4R2: 'WalletV4R2',
//     walletV5R1: 'WalletV5R1',
//   ),
//   defaultWalletType: const WalletType.everWallet(),
//   nativeTokenIcon: Assets.images.everCoin.path,
//   nativeTokenTickerOption:
//       const TransportNativeTokenTickerOption.byName('EVER'),
//   manifestOption: const TransportManifestOption.fromConnection(),
//   nativeTokenAddress: const Address(
//     address:
//         '0:a49cd4e158a9a15555e624759e2e4e766d22600b7800d891e46f9291f044a93d',
//   ),
//   networkName: 'Everscale',
//   networkType: 'ever',
//   seedPhraseWordsCount: [12, 24],
//   defaultNativeCurrencyDecimal: 9,
//   baseCurrencyUrl: 'https://api.flatqube.io/v1/currencies',
//   stakeInformation: StakingInformation(
//     stakingAPYLink: Uri.parse(
//       'https://staking.everwallet.net/v1/strategies/main',
//     ),
//     stakingValutAddress: const Address(
//       address:
//           '0:675a6d63f27e3f24d41d286043a9286b2e3eb6b84fa4c3308cc2833ef6f54d68',
//     ),
//     stakingRootContractAddress: const Address(
//       address:
//           '0:6d42d0bc4a6568120ea88bf642edb653d727cfbd35868c47877532de128e71f2',
//     ),
//     stakeDepositAttachedFee: BigInt.parse('2000000000'),
//     // 2 EVER
//     stakeRemovePendingWithdrawAttachedFee: BigInt.parse('2000000000'),
//     // 2 EVER
//     stakeWithdrawAttachedFee: BigInt.parse('3000000000'), // 3 EVER
//   ),
//   tokenApiBaseUrl: 'https://tokens.everscan.io/v1',
//   currencyApiBaseUrl: 'https://api.flatqube.io/v1/currencies',
//   genericTokenType: GenericTokenType.tip3,
//   accountExplorerLinkType: AccountExplorerLinkType.accounts,
//   transactionExplorerLinkType: TransactionExplorerLinkType.transactions,
// );

// final _tycho = ConnectionTransportData(
//   availableWalletTypes: const [
//     WalletType.everWallet(),
//     WalletType.multisig(MultisigType.multisig2),
//     WalletType.multisig(MultisigType.multisig2_1),
//     WalletType.walletV3(),
//     WalletType.multisig(MultisigType.safeMultisigWallet),
//     WalletType.multisig(MultisigType.safeMultisigWallet24h),
//     WalletType.multisig(MultisigType.setcodeMultisigWallet),
//     WalletType.multisig(MultisigType.setcodeMultisigWallet24h),
//     WalletType.multisig(MultisigType.bridgeMultisigWallet),
//     WalletType.multisig(MultisigType.surfWallet),
//   ],
//   walletDefaultAccountNames: WalletDefaultAccountNames(
//     multisig: <MultisigType, String>{
//       MultisigType.safeMultisigWallet: 'SafeMultisig',
//       MultisigType.safeMultisigWallet24h: 'SafeMultisig24h',
//       MultisigType.setcodeMultisigWallet: 'SetcodeMultisig',
//       MultisigType.setcodeMultisigWallet24h: 'SetcodeMultisig24h',
//       MultisigType.bridgeMultisigWallet: 'BridgeMultisig',
//       MultisigType.surfWallet: 'Surf Wallet',
//       MultisigType.multisig2: 'Legacy Multi-sig',
//       MultisigType.multisig2_1: 'Multi-sig',
//     },
//     walletV3: 'WalletV3',
//     highloadWalletV2: 'HighloadWallet',
//     everWallet: 'Default',
//     walletV4R1: 'WalletV4R1',
//     walletV4R2: 'WalletV4R2',
//     walletV5R1: 'WalletV5R1',
//   ),
//   defaultWalletType: const WalletType.everWallet(),
//   nativeTokenIcon: Assets.images.tychoCoin.path,
//   nativeTokenTickerOption:
//       const TransportNativeTokenTickerOption.byName('TYCHO'),
//   manifestOption: const TransportManifestOption.fromConnection(),
//   nativeTokenAddress: const Address(
//     address:
//         '0:6b3355b19c6aedc65be291c00abbf6e5061c07e1926a3fd543863c7a8d06cc79',
//   ),
//   networkName: 'Tycho Testnet',
//   networkType: 'tycho',
//   seedPhraseWordsCount: [12],
//   defaultNativeCurrencyDecimal: 9,
//   baseCurrencyUrl: 'https://api-test-tycho.flatqube.io/v1/currencies',
//   genericTokenType: GenericTokenType.tip3,
//   accountExplorerLinkType: AccountExplorerLinkType.accounts,
//   transactionExplorerLinkType: TransactionExplorerLinkType.transactions,
// );

// final _venom = ConnectionTransportData(
//   availableWalletTypes: const [
//     WalletType.everWallet(),
//     WalletType.multisig(MultisigType.multisig2_1),
//   ],
//   walletDefaultAccountNames: WalletDefaultAccountNames(
//     multisig: <MultisigType, String>{
//       MultisigType.safeMultisigWallet: 'SafeMultisig24h',
//       MultisigType.safeMultisigWallet24h: 'SafeMultisig24h',
//       MultisigType.setcodeMultisigWallet: 'SetcodeMultisig',
//       MultisigType.setcodeMultisigWallet24h: 'SetcodeMultisig24h',
//       MultisigType.bridgeMultisigWallet: 'BridgeMultisig',
//       MultisigType.surfWallet: 'Surf Wallet',
//       MultisigType.multisig2: 'Legacy Multi-sig',
//       MultisigType.multisig2_1: 'Multi-sig',
//     },
//     walletV3: 'Legacy',
//     highloadWalletV2: 'HighloadWallet',
//     everWallet: 'Default',
//     walletV4R1: 'WalletV4R1',
//     walletV4R2: 'WalletV4R2',
//     walletV5R1: 'WalletV5R1',
//   ),
//   defaultWalletType: const WalletType.everWallet(),
//   nativeTokenIcon: Assets.images.venom.path,
//   nativeTokenTickerOption:
//       const TransportNativeTokenTickerOption.byName('VENOM'),
//   manifestOption: const TransportManifestOption.fromConnection(),
//   nativeTokenAddress: const Address(
//     address:
//         '0:77d36848bb159fa485628bc38dc37eadb74befa514395e09910f601b841f749e',
//   ),
//   networkName: 'Venom',
//   networkType: 'venom',
//   seedPhraseWordsCount: [12],
//   defaultNativeCurrencyDecimal: 9,
//   baseCurrencyUrl: 'https://api.web3.world/v1/currencies',
//   tokenApiBaseUrl: 'https://tokens.venomscan.com/v1',
//   currencyApiBaseUrl: 'https://api.web3.world/v1/currencies',
//   genericTokenType: GenericTokenType.tip3,
//   accountExplorerLinkType: AccountExplorerLinkType.accounts,
//   transactionExplorerLinkType: TransactionExplorerLinkType.transactions,
// );
//
// final _ton = ConnectionTransportData(
//   availableWalletTypes: const [
//     WalletType.everWallet(),
//     WalletType.multisig(MultisigType.multisig2_1),
//     WalletType.walletV4R1(),
//     WalletType.walletV4R2(),
//     WalletType.walletV5R1(),
//   ],
//   walletDefaultAccountNames: WalletDefaultAccountNames(
//     multisig: <MultisigType, String>{
//       MultisigType.safeMultisigWallet: 'SafeMultisig24h',
//       MultisigType.safeMultisigWallet24h: 'SafeMultisig24h',
//       MultisigType.setcodeMultisigWallet: 'SetcodeMultisig',
//       MultisigType.setcodeMultisigWallet24h: 'SetcodeMultisig24h',
//       MultisigType.bridgeMultisigWallet: 'BridgeMultisig',
//       MultisigType.surfWallet: 'Surf Wallet',
//       MultisigType.multisig2: 'Legacy Multi-sig',
//       MultisigType.multisig2_1: 'Multi-sig',
//     },
//     walletV3: 'Legacy',
//     highloadWalletV2: 'HighloadWallet',
//     everWallet: 'EverWallet',
//     walletV4R1: 'WalletV4R1',
//     walletV4R2: 'WalletV4R2',
//     walletV5R1: 'WalletV5R1',
//   ),
//   defaultWalletType: const WalletType.walletV5R1(),
//
//   /// TON
//   nativeTokenIcon: Assets.images.venom.path,
//   nativeTokenTickerOption: const TransportNativeTokenTickerOption.byName('TON'),
//   manifestOption: const TransportManifestOption.fromConnection(),
//   nativeTokenAddress: const Address(
//     address:
//         '0:9a8da514d575d20234c3fb1395ee9138f5f1ad838abc905dc42c2389b46bd015',
//   ),
//   networkName: 'TON',
//   networkType: 'ton',
//   seedPhraseWordsCount: [12, 24],
//   defaultNativeCurrencyDecimal: 9,
//   genericTokenType: GenericTokenType.jetton,
//   accountExplorerLinkType: AccountExplorerLinkType.packAddress,
//   transactionExplorerLinkType: TransactionExplorerLinkType.transaction,
// );
