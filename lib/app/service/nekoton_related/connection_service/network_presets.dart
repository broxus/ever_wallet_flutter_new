import 'package:app/data/models/connection_data.dart';
import 'package:app/data/models/network_type.dart';

const defaultConnectionkId = everMainnetProtoID;

final networkPresets = [
  ..._everPresets,
  ..._venomPresets,
  ..._tychoPresets,
  ..._tonPresets,
  ..._customPresets,
];

final defaultNetwork = networkPresets.firstWhere(
  (element) => element.id == defaultConnectionkId,
);

const everMainnetProtoID = 'preset_ever_mainnet_proto';
const venomMainnetProtoID = 'preset_venom_mainnet_proto';
const tychoTestnetProtoID = 'preset_tycho_testnet_proto';
const tonMainnetProtoID = 'preset_ton_mainnet_proto';

/// Presets for ever network
final _everPresets = <ConnectionData>[
  ConnectionData.protoPreset(
    id: everMainnetProtoID,
    name: 'Everscale',
    group: 'mainnet',
    endpoint: 'https://jrpc.everwallet.net',
    networkType: NetworkType.ever,
    canBeEdited: false,
    blockExplorerUrl: 'https://everscan.io',
    manifestUrl:
        'https://raw.githubusercontent.com/broxus/ton-assets/master/manifest.json',
    sortingOrder: 1,
  ),
  ConnectionData.gqlPreset(
    id: 'preset_ever_mainnet_gql',
    name: 'Everscale (reserve)',
    group: 'mainnet',
    endpoints: [
      'https://mainnet.evercloud.dev/89a3b8f46a484f2ea3bdd364ddaee3a3/graphql',
    ],
    networkType: NetworkType.ever,
    canBeEdited: false,
    blockExplorerUrl: 'https://everscan.io',
    manifestUrl:
        'https://raw.githubusercontent.com/broxus/ton-assets/master/manifest.json',
    sortingOrder: 2,
  ),
];

/// Presets for venom network
final _venomPresets = [
  ConnectionData.protoPreset(
    id: venomMainnetProtoID,
    name: 'Venom',
    group: 'venom_mainnet',
    endpoint: 'https://jrpc.venom.foundation',
    networkType: NetworkType.venom,
    canBeEdited: false,
    blockExplorerUrl: 'https://venomscan.com',
    manifestUrl: 'https://cdn.venom.foundation/assets/mainnet/manifest.json',
    sortingOrder: 3,
  ),
];

final _tychoPresets = [
  ConnectionData.protoPreset(
    id: tychoTestnetProtoID,
    name: 'Tycho Testnet',
    group: 'tycho_testnet',
    endpoint: 'https://rpc-testnet.tychoprotocol.com/',
    networkType: NetworkType.tycho,
    canBeEdited: false,
    blockExplorerUrl: 'https://testnet.tychoprotocol.com/',
    manifestUrl:
        'https://raw.githubusercontent.com/broxus/ton-assets/refs/heads/tychotestnet/manifest.json',
    sortingOrder: 4,
  ),
];

final _tonPresets = [
  ConnectionData.protoPreset(
    id: tonMainnetProtoID,
    name: 'TON',
    group: 'ton',
    endpoint: 'https://jrpc-ton.broxus.com',
    networkType: NetworkType.ton,
    canBeEdited: false,
    blockExplorerUrl: 'https://tonviewer.com',
    manifestUrl:
        'https://raw.githubusercontent.com/broxus/ton-assets/refs/heads/ton/manifest.json',
    sortingOrder: 5,
  ),
];

/// Presets for different custom network
final _customPresets = <ConnectionData>[];
