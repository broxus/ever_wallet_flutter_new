import 'package:app/data/models/connection/connection_data/connection_data.dart';
import 'package:app/data/models/connection/connection_transport/connection_transport_data.dart';
import 'package:collection/collection.dart';

class ConnectionNetwork {
  ConnectionNetwork({
    required this.defaultConnectionId,
    List<ConnectionData>? networks,
    List<ConnectionTransportData>? transports,
  })  : networks = networks ?? [],
        transports = transports ?? [];

  final String defaultConnectionId;
  final List<ConnectionData> networks;
  final List<ConnectionTransportData> transports;

  late final ConnectionData? defaultNetwork = networks.firstWhereOrNull(
        (n) => n.id == defaultConnectionId,
      ) ??
      networks.firstOrNull;
}
