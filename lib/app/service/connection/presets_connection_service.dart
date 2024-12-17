import 'dart:async';
import 'dart:convert';

import 'package:app/app/service/connection/data/connection_data/connection_data.dart';
import 'package:app/app/service/connection/data/connection_network/connection_network.dart';
import 'package:app/app/service/connection/data/connection_transport/connection_transport_data.dart';
import 'package:app/app/service/connection/mapping/connection_network_mapper.dart';
import 'package:app/app/service/storage_service/secure_storage_service.dart';
import 'package:crypto/crypto.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

const _presetsDomain = 'presets';

@singleton
class PresetsConnectionService {
  PresetsConnectionService(
    this._secureStorage,
  );

  static const container = _presetsDomain;

  final SecureStorageService _secureStorage;

  final _presetsConnectionsSubj = BehaviorSubject<ConnectionNetwork?>();

  static final _logger = Logger('PresetsConnectionService');

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
        "endpoints": ["https:/\/jrpc.everwallet.net"],
        "networkType": "ever",
        "blockExplorerUrl": "https:/\/everscan.io",
        "manifestUrl":
            "https:/\/raw.githubusercontent.com/broxus/ton-assets/master/manifest.json",
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
        "endpoints": ["https:/\/jrpc.venom.foundation"],
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
        "endpoints": ["https:/\/rpc-testnet.tychoprotocol.com/"],
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
        "endpoints": ["https:/\/jrpc-ton.broxus.com"],
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
          {"type": "everWallet"},
          {"type": "multisig", "value": "multisig2_1"}
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
        "defaultWalletType": {"type": "everWallet"},
        "nativeTokenIcon": "TODO PATH",
        "nativeTokenTickerOption": {"type": "fromConnection"},
        "manifestOption": {"type": "fromConnection"},
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
          {"type": "everWallet"},
          {"type": "multisig", "value": "multisig2"},
          {"type": "multisig", "value": "multisig2_1"},
          {"type": "walletV3"},
          {"type": "multisig", "value": "safeMultisigWallet"},
          {"type": "multisig", "value": "safeMultisigWallet24h"},
          {"type": "multisig", "value": "setcodeMultisigWallet"},
          {"type": "multisig", "value": "setcodeMultisigWallet24h"},
          {"type": "multisig", "value": "bridgeMultisigWallet"},
          {"type": "multisig", "value": "surfWallet"}
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
        "defaultWalletType": {"type": "everWallet"},
        "nativeTokenIcon": "TODO PATH",
        "nativeTokenTickerOption": {"type": "byName", "name": "EVER"},
        "manifestOption": {"type": "fromConnection"},
        "nativeTokenAddress":
            "0:a49cd4e158a9a15555e624759e2e4e766d22600b7800d891e46f9291f044a93d",
        "networkName": "Everscale",
        "networkType": "ever",
        "seedPhraseWordsCount": [12, 24],
        "defaultNativeCurrencyDecimal": 9,
        "baseCurrencyUrl": "https:/\/api.flatqube.io/v1/currencies",
        "stakeInformation": {
          "stakingAPYLink":
              "https:/\/staking.everwallet.net/v1/strategies/main",
          "stakingValutAddress":
              "0:675a6d63f27e3f24d41d286043a9286b2e3eb6b84fa4c3308cc2833ef6f54d68",
          "stakingRootContractAddress":
              "0:6d42d0bc4a6568120ea88bf642edb653d727cfbd35868c47877532de128e71f2",
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
          {"type": "everWallet"},
          {"type": "multisig", "value": "multisig2"},
          {"type": "multisig", "value": "multisig2_1"},
          {"type": "walletV3"},
          {"type": "multisig", "value": "safeMultisigWallet"},
          {"type": "multisig", "value": "safeMultisigWallet24h"},
          {"type": "multisig", "value": "setcodeMultisigWallet"},
          {"type": "multisig", "value": "setcodeMultisigWallet24h"},
          {"type": "multisig", "value": "bridgeMultisigWallet"},
          {"type": "multisig", "value": "surfWallet"}
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
        "defaultWalletType": {"type": "everWallet"},
        "nativeTokenIcon": "TODO PATH",
        "nativeTokenTickerOption": {"type": "byName", "name": "TYCHO"},
        "manifestOption": {"type": "fromConnection"},
        "nativeTokenAddress":
            "0:6b3355b19c6aedc65be291c00abbf6e5061c07e1926a3fd543863c7a8d06cc79",
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
          {"type": "everWallet"},
          {"type": "multisig", "value": "multisig2_1"}
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
        "defaultWalletType": {"type": "everWallet"},
        "nativeTokenIcon": "TODO PATH",
        "nativeTokenTickerOption": {"type": "byName", "name": "VENOM"},
        "manifestOption": {"type": "fromConnection"},
        "nativeTokenAddress":
            "0:77d36848bb159fa485628bc38dc37eadb74befa514395e09910f601b841f749e",
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
          {"type": "everWallet"},
          {"type": "multisig", "value": "multisig2_1"},
          {"type": "walletV4R1"},
          {"type": "walletV4R2"},
          {"type": "walletV5R1"}
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
        "defaultWalletType": {"type": "walletV5R1"},
        "nativeTokenIcon": "TODO PATH",
        "nativeTokenTickerOption": {"type": "byName", "name": "TON"},
        "manifestOption": {"type": "fromConnection"},
        "nativeTokenAddress":
            "0:9a8da514d575d20234c3fb1395ee9138f5f1ad838abc905dc42c2389b46bd015",
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
    ConnectionNetwork? data;

    try {
      data = await Future.value(
        mapToConnectionNetworkFromJson(_json),
      );

      unawaited(_updateCacheIfNeed(_json));
    } catch (e, s) {
      _logger.severe('Error fetch connections', e, s);
      try {
        final cache = await _secureStorage.getConnectionJson();
        if (cache != null) {
          mapToConnectionNetworkFromJson(
            await jsonDecode(cache) as Map<String, dynamic>,
          );
        }
      } catch (e, s) {
        _logger.severe('Error get connections from cache', e, s);
      }
    }

    _presetsConnectionsSubj.add(data);
  }

  Future<void> _updateCacheIfNeed(Map<String, dynamic> json) async {
    final currentSha256 = sha256
        .convert(
          utf8.encode(_json.toString()),
        )
        .toString();

    String? cachedSha256;

    try {
      cachedSha256 = await _secureStorage.getConnectionJsonHash();
    } catch (e, s) {
      _logger.severe('Error get hash', e, s);
    }

    if (currentSha256 != cachedSha256) {
      try {
        await _secureStorage.setConnectionJsonHash(currentSha256);
      } catch (e, s) {
        _logger.severe('Error save hash', e, s);
      }

      try {
        await _secureStorage.setConnectionJson(jsonEncode(_json));
      } catch (e, s) {
        _logger.severe('Error save hash', e, s);
      }
    }
  }
}
