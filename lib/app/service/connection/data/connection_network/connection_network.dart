import 'package:app/app/service/connection/data/connection_data/connection_data.dart';
import 'package:app/app/service/connection/data/connection_transport/connection_transport_data.dart';
import 'package:app/app/service/connection/data/custom_network/custom_network_option.dart';
import 'package:app/app/service/connection/default_network.dart';
import 'package:app/app/service/connection/group.dart';
import 'package:collection/collection.dart';

class ConnectionNetwork {
  ConnectionNetwork({
    required String defaultConnectionId,
    List<ConnectionData>? networks,
    Map<NetworkGroup, ConnectionTransportData>? transports,
    this.customNetworkOptions,
  })  : networks = networks ?? [],
        transports = transports ?? {},
        defaultNetwork = networks?.firstWhereOrNull(
              (n) => n.id == defaultConnectionId,
            ) ??
            networks?.firstOrNull ??
            defaultPresetNetwork;

  final List<ConnectionData> networks;
  final Map<NetworkGroup, ConnectionTransportData> transports;
  final List<CustomNetworkOption>? customNetworkOptions;

  late final ConnectionData defaultNetwork;

  late final String defaultConnectionId = defaultNetwork.id;

  late final List<String>? customNetworkOptionTypes =
      customNetworkOptions == null
          ? ['ever', 'tycho', 'custom']
          : [
              for (final option in customNetworkOptions!) option.networkType,
            ];
}
