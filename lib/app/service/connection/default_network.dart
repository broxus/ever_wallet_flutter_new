import 'package:app/app/service/connection/data/connection_data/connection_data.dart';

final defaultPresetNetwork = ConnectionData.protoPreset(
  id: 'preset_ever_mainnet_proto',
  name: 'Everscale',
  group: 'mainnet',
  endpoint: 'https://jrpc.everwallet.net',
  networkType: 'ever',
  blockExplorerUrl: 'https://everscan.io',
  manifestUrl:
      'https://raw.githubusercontent.com/broxus/ton-assets/master/manifest.json',
  canBeEdited: false,
  sortingOrder: 1,
);
