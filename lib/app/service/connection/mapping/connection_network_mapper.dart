import 'package:app/app/service/connection/data/connection_network/connection_network.dart';
import 'package:app/app/service/connection/mapping/networks_mapper.dart';
import 'package:app/app/service/connection/mapping/tansports_mapper.dart';

ConnectionNetwork mapToConnectionNetworkFromJson(Map<String, dynamic> json) {
  return ConnectionNetwork(
    defaultConnectionId: json['defaultConnectionId'] as String,
    networks: mapToConnectionDataList(
      json['networks'] as List<Map<String, dynamic>>,
    ),
    transports: mapToTransports(
      json['transports'] as List<Map<String, dynamic>>,
    ),
  );
}
