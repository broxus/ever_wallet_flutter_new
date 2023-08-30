import 'package:app/data/models/connection_data.dart';
import 'package:app/data/models/network_type.dart';

/// Presets for ever network
const everPresets = <ConnectionData>[
  ConnectionData.proto(
    name: 'Mainnet (PROTO)',
    networkId: 1,
    group: 'mainnet',
    endpoint: 'https://jrpc.everwallet.net/proto',
    networkType: NetworkType.ever,
  ),
  ConnectionData.gql(
    name: 'Mainnet (GQL)',
    networkId: 1,
    group: 'mainnet',
    endpoints: [
      'https://mainnet.evercloud.dev/89a3b8f46a484f2ea3bdd364ddaee3a3/graphql',
    ],
    timeout: Duration(milliseconds: 60000),
    local: false,
    networkType: NetworkType.ever,
  ),
  ConnectionData.gql(
    name: 'Testnet',
    networkId: 2,
    group: 'testnet',
    endpoints: [
      'https://devnet.evercloud.dev/89a3b8f46a484f2ea3bdd364ddaee3a3/graphql',
    ],
    timeout: Duration(milliseconds: 60000),
    local: false,
    networkType: NetworkType.ever,
  ),
];

/// Presets for venom network
const venomPresets = [
  // venom is in test, uncomment it later
  // ConnectionData.jrpc(
  //   name: 'Mainnet Venom (JRPC)',
  //   networkId: 1000,
  //   group: 'venom_mainnet',
  //   endpoint: 'https://jrpc.venom.foundation/rpc',
  //   networkType: NetworkType.venom,
  // ),
  ConnectionData.proto(
    name: 'Testnet Venom',
    networkId: 1010,
    group: 'testnet',
    endpoint: 'https://jrpc-testnet.venom.foundation/proto',
    networkType: NetworkType.venom,
  ),
];

/// Presets for different custom network
const customPresets = <ConnectionData>[
  ConnectionData.gql(
    name: 'fld.ton.dev',
    networkId: 10,
    group: 'fld',
    endpoints: [
      'https://gql.custler.net/graphql',
    ],
    timeout: Duration(milliseconds: 60000),
    local: false,
    networkType: NetworkType.custom,
  ),
  ConnectionData.gql(
    name: 'Gosh',
    networkId: 30,
    group: 'gosh',
    endpoints: [
      'https://network.gosh.sh',
    ],
    timeout: Duration(milliseconds: 60000),
    local: false,
    networkType: NetworkType.custom,
  ),
  ConnectionData.gql(
    name: 'Local node',
    networkId: 31337,
    group: 'localnet',
    endpoints: [
      'https://127.0.0.1',
    ],
    timeout: Duration(milliseconds: 60000),
    local: false,
    networkType: NetworkType.custom,
  ),
];
