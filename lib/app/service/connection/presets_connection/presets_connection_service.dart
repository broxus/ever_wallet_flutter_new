import 'package:app/data/models/models.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

const _presetsDomain = 'presets';

@singleton
class PresetsConnectionService {
  static const container = _presetsDomain;

  final _presetsConnectionsSubj = BehaviorSubject<ConnectionNetwork?>();

  ConnectionNetwork? get _data => _presetsConnectionsSubj.valueOrNull;

  List<ConnectionData> get networks => _data?.networks ?? [];

  String? get defaultConnectionId => _data?.defaultConnectionId;

  ConnectionData? get defaultNetwork => _data?.defaultNetwork;

  String? currentPresetId;

  Future<void> fetchConnectionsList() async {
    // TODO запрос
    final data = await Future.value(
      ConnectionNetwork(
        defaultConnectionId: 'preset_ever_mainnet_proto',
        networks: [
          ConnectionData.protoPreset(
            id: 'preset_ever_mainnet_proto',
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
          // ConnectionData.gqlPreset(
          //   id: 'preset_ever_mainnet_gql',
          //   name: 'Everscale (reserve)',
          //   group: 'mainnet',
          //   endpoints: [
          //     'https://mainnet.evercloud.dev/89a3b8f46a484f2ea3bdd364ddaee3a3/graphql',
          //   ],
          //   networkType: NetworkType.ever,
          //   canBeEdited: false,
          //   blockExplorerUrl: 'https://everscan.io',
          //   manifestUrl:
          //       'https://raw.githubusercontent.com/broxus/ton-assets/master/manifest.json',
          //   sortingOrder: 2,
          // ),
          ConnectionData.protoPreset(
            id: 'preset_venom_mainnet_proto',
            name: 'Venom',
            group: 'venom_mainnet',
            endpoint: 'https://jrpc.venom.foundation',
            networkType: NetworkType.venom,
            canBeEdited: false,
            blockExplorerUrl: 'https://venomscan.com',
            manifestUrl:
                'https://cdn.venom.foundation/assets/mainnet/manifest.json',
            sortingOrder: 3,
          ),
          ConnectionData.protoPreset(
            id: 'preset_tycho_testnet_proto',
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
        ],
      ),
    );

    _presetsConnectionsSubj.add(data);
  }
}
