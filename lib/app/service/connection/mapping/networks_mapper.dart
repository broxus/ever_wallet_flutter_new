
import 'package:app/app/service/connection/data/connection_data/connection_data.dart';
import 'package:app/utils/parse_utils.dart';

List<ConnectionData> mapToConnectionDataList(
    List<Map<String, dynamic>> list,
    ) {
  final result = <ConnectionData>[];

  for (final network in list) {
    final type = network['type'] as String;

    ConnectionData? data;

    final id = network['id'] as String;
    final name = network['name'] as String;
    final group = network['group'] as String;
    final endpoints = network['endpoints'] as List<String>;
    final networkType = network['networkType'] as String;
    final blockExplorerUrl = network['blockExplorerUrl'] as String;
    final manifestUrl = network['manifestUrl'] as String;
    final sortingOrder = parseToDouble(network['sortingOrder']) ?? 1;

    switch (type) {
      case 'proto':
        data = ConnectionData.protoPreset(
          id: id,
          name: name,
          group: group,
          endpoint: endpoints.first,
          networkType: networkType,
          blockExplorerUrl: blockExplorerUrl,
          manifestUrl: manifestUrl,
          canBeEdited: false,
          sortingOrder: sortingOrder,
        );
      case 'gql':
        data = ConnectionData.gqlPreset(
          id: id,
          name: name,
          group: group,
          endpoints: endpoints,
          networkType: networkType,
          blockExplorerUrl: blockExplorerUrl,
          manifestUrl: manifestUrl,
          canBeEdited: false,
          sortingOrder: sortingOrder,
          latencyDetectionInterval:
          parseToInt(network['latencyDetectionInterval']),
          maxLatency: parseToInt(network['maxLatency']),
          endpointSelectionRetryCount:
          parseToInt(network['endpointSelectionRetryCount']),
        );
      case 'jrpc':
        data = ConnectionData.jrpcPreset(
          id: id,
          name: name,
          group: group,
          endpoint: endpoints.first,
          networkType: networkType,
          blockExplorerUrl: blockExplorerUrl,
          manifestUrl: manifestUrl,
          canBeEdited: false,
          sortingOrder: sortingOrder,
        );
      default:
        continue;
    }

    result.add(data);
  }

  return result;
}