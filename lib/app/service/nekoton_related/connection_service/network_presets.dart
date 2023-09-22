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
    name: 'Mainnet (PROTO)',
    group: 'mainnet',
    endpoint: 'https://jrpc.everwallet.net/proto',
    networkType: NetworkType.ever,
    canBeEdited: false,
    blockExplorerUrl: 'https://everscan.io',
    manifestUrl:
        'https://raw.githubusercontent.com/broxus/ton-assets/master/manifest.json',
  ),
  ConnectionData.gqlPreset(
    id: 'preset_ever_mainnet_gql',
    name: 'Mainnet (GQL)',
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
  ),
  ConnectionData.gqlPreset(
    id: 'preset_ever_testnet_gql',
    name: 'Testnet',
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
  ),
];

/// Presets for venom network
final _venomPresets = [
  // venom is in test, uncomment it later
  // ConnectionData.protoPreset(
  //   id: 'preset_venom_mainnet_proto',
  //   name: 'Mainnet Venom (PROTO)',
  //   networkId: 1000,
  //   group: 'venom_mainnet',
  //   endpoint: 'https://jrpc.venom.foundation/proto',
  //   networkType: NetworkType.venom,
  //   canBeEdited: false,
  // ),
  ConnectionData.protoPreset(
    id: 'preset_venom_testnet_proto',
    name: 'Testnet Venom',
    group: 'testnet',
    endpoint: 'https://jrpc-testnet.venom.foundation/proto',
    networkType: NetworkType.venom,
    canBeEdited: true,
    blockExplorerUrl: 'https://venomscan.com',
    manifestUrl:
        'https://raw.githubusercontent.com/BVFDT/venom-assets/master/manifest.json',
  ),
];

/// Presets for different custom network
final _customPresets = <ConnectionData>[
  ConnectionData.gqlPreset(
    id: 'preset_tonlabs_mainnet_gql',
    name: 'fld.ton.dev',
    group: 'fld',
    endpoints: [
      'https://gql.custler.net/graphql',
    ],
    timeout: defaultNetworkTimeout,
    networkType: NetworkType.custom,
    canBeEdited: true,
    blockExplorerUrl: '',
    manifestUrl: '',
  ),
  ConnectionData.gqlPreset(
    id: 'preset_tonlabs_testnet_gql',
    name: 'Gosh',
    group: 'gosh',
    endpoints: [
      'https://network.gosh.sh',
    ],
    timeout: defaultNetworkTimeout,
    networkType: NetworkType.custom,
    canBeEdited: true,
    blockExplorerUrl: '',
    manifestUrl: '',
  ),
];
