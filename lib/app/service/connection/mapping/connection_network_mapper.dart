import 'package:app/app/service/connection/data/connection_network/connection_network.dart';
import 'package:app/app/service/connection/mapping/networks_mapper.dart';
import 'package:app/app/service/connection/mapping/tansports_mapper.dart';
import 'package:app/utils/json/json_utils.dart';

ConnectionNetwork mapToConnectionNetworkFromJson(Map<String, dynamic> json) {
  return ConnectionNetwork(
    defaultConnectionId: json['defaultConnectionId'] as String,
    networks: mapToConnectionDataList(
      castJsonList<Map<String, dynamic>>(json['networks']),
    ),
    transports: mapToTransports(
      castJsonList<Map<String, dynamic>>(json['transports']),
    ),
  );
}
