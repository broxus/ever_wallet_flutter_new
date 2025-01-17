import 'package:app/app/service/connection/data/custom_network/custom_network_option.dart';
import 'package:app/utils/json/json_utils.dart';

List<CustomNetworkOption>? mapToCustomNetworkOptions(dynamic json) {
  if (json == null) {
    return null;
  }

  final list = castJsonList<Map<String, dynamic>>(json);
  final result = <CustomNetworkOption>[];

  for (final option in list) {
    final data = _mapToOption(option);
    if (data == null) {
      continue;
    }
    result.add(data);
  }

  return result;
}

CustomNetworkOption? _mapToOption(Map<String, dynamic> json) {
  final networkType = json['networkType'];

  if (networkType == null) {
    return null;
  }

  return CustomNetworkOption(
    networkType: networkType as String,
  );
}
