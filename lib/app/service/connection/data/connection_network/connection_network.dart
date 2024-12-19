import 'package:app/app/service/connection/data/connection_data/connection_data.dart';
import 'package:app/app/service/connection/data/connection_transport/connection_transport_data.dart';
import 'package:app/app/service/connection/default_network.dart';
import 'package:collection/collection.dart';

class ConnectionNetwork {
  ConnectionNetwork({
    required String defaultConnectionId,
    List<ConnectionData>? networks,
    Map<String, ConnectionTransportData>? transports,
  })  : networks = networks ?? [],
        transports = transports ?? {},
        defaultNetwork = networks?.firstWhereOrNull(
              (n) => n.id == defaultConnectionId,
            ) ??
            networks?.firstOrNull ??
            defaultPresetNetwork;

  final List<ConnectionData> networks;
  final Map<String, ConnectionTransportData> transports;

  late final ConnectionData defaultNetwork;
  late final String defaultConnectionId = defaultNetwork.id;
}
