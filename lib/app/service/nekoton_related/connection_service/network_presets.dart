import 'package:app/data/models/connection_data.dart';
import 'package:app/data/models/network_type.dart';

const defaultNetworkTimeout = Duration(milliseconds: 60000);

const _everMainnetProtoId = 'preset_ever_mainnet_proto';

const defaultConnectionkId = _everMainnetProtoId;

final networkPresets = [..._everPresets, ..._venomPresets, ..._customPresets];

final defaultNetwork = networkPresets.firstWhere(
  (element) => element.id == defaultConnectionkId,
);

/// Presets for ever network
final _everPresets = <ConnectionData>[
  ConnectionData.protoPreset(
    id: _everMainnetProtoId,
    name: 'Everscale',
    group: 'mainnet',
    endpoint: 'https://jrpc.everwallet.net/proto',
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
    timeout: defaultNetworkTimeout,
    networkType: NetworkType.ever,
    canBeEdited: false,
    blockExplorerUrl: 'https://everscan.io',
    manifestUrl:
        'https://raw.githubusercontent.com/broxus/ton-assets/master/manifest.json',
    sortingOrder: 2,
  ),
  ConnectionData.gqlPreset(
    id: 'preset_ever_testnet_gql',
    name: 'Everscale (testnet)',
    group: 'testnet',
    endpoints: [
      'https://devnet.evercloud.dev/89a3b8f46a484f2ea3bdd364ddaee3a3/graphql',
    ],
    timeout: defaultNetworkTimeout,
    networkType: NetworkType.ever,
    canBeEdited: true,
    blockExplorerUrl: 'https://everscan.io',
    manifestUrl:
        'https://raw.githubusercontent.com/broxus/ton-assets/master/manifest.json',
    sortingOrder: 3,
  ),
];

/// Presets for venom network
final _venomPresets = [
  // venom is in test, uncomment it later
  // ConnectionData.protoPreset(
  //   id: 'preset_venom_mainnet_proto',
  //   name: 'Mainnet Venom (PROTO)',
  //   group: 'venom_mainnet',
  //   endpoint: 'https://jrpc.venom.foundation/proto',
  //   networkType: NetworkType.venom,
  //   canBeEdited: false,
  //   sortingOrder: 4,
  // ),
  ConnectionData.protoPreset(
    id: 'preset_venom_testnet_proto',
    name: 'Venom (testnet)',
    group: 'testnet',
    endpoint: 'https://jrpc-testnet.venom.foundation',
    networkType: NetworkType.venom,
    canBeEdited: true,
    blockExplorerUrl: 'https://testnet.venomscan.com',
    manifestUrl: 'https://cdn.venom.foundation/assets/testnet/manifest.json',
    sortingOrder: 5,
  ),
];

/// Presets for different custom network
final _customPresets = <ConnectionData>[];
