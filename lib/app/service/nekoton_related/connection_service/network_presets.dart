import 'package:app/data/models/connection_data.dart';
import 'package:app/data/models/network_type.dart';

const defaultNetworkTimeout = Duration(milliseconds: 60000);

const _everMainnetProtoId = 'preset_ever_mainnet_proto';

const defaultNetworkId = _everMainnetProtoId;

final networkPresets = [..._everPresets, ..._venomPresets, ..._customPresets];

final defaultNetwork = networkPresets.firstWhere(
  (element) => element.id == defaultNetworkId,
);

/// Presets for ever network
final _everPresets = <ConnectionData>[
  ConnectionData.protoPreset(
    id: _everMainnetProtoId,
    name: 'Mainnet (PROTO)',
    networkId: 1,
    group: 'mainnet',
    endpoint: 'https://jrpc.everwallet.net/proto',
    networkType: NetworkType.ever,
  ),
  ConnectionData.gqlPreset(
    id: 'preset_ever_mainnet_gql',
    name: 'Mainnet (GQL)',
    networkId: 1,
    group: 'mainnet',
    endpoints: [
      'https://mainnet.evercloud.dev/89a3b8f46a484f2ea3bdd364ddaee3a3/graphql',
    ],
    timeout: defaultNetworkTimeout,
    networkType: NetworkType.ever,
  ),
  ConnectionData.gqlPreset(
    id: 'preset_ever_testnet_gql',
    name: 'Testnet',
    networkId: 2,
    group: 'testnet',
    endpoints: [
      'https://devnet.evercloud.dev/89a3b8f46a484f2ea3bdd364ddaee3a3/graphql',
    ],
    timeout: defaultNetworkTimeout,
    networkType: NetworkType.ever,
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
  // ),
  ConnectionData.protoPreset(
    id: 'preset_venom_testnet_proto',
    name: 'Testnet Venom',
    networkId: 1010,
    group: 'testnet',
    endpoint: 'https://jrpc-testnet.venom.foundation/proto',
    networkType: NetworkType.venom,
  ),
];

/// Presets for different custom network
final _customPresets = <ConnectionData>[
  ConnectionData.gqlPreset(
    id: 'preset_tonlabs_mainnet_gql',
    name: 'fld.ton.dev',
    networkId: 10,
    group: 'fld',
    endpoints: [
      'https://gql.custler.net/graphql',
    ],
    timeout: defaultNetworkTimeout,
    networkType: NetworkType.custom,
  ),
  ConnectionData.gqlPreset(
    id: 'preset_tonlabs_testnet_gql',
    name: 'Gosh',
    networkId: 30,
    group: 'gosh',
    endpoints: [
      'https://network.gosh.sh',
    ],
    timeout: defaultNetworkTimeout,
    networkType: NetworkType.custom,
  ),
];
