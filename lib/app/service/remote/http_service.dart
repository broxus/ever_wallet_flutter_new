import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

/// Service that makes pure http requests.
/// It's used in nekoton's <Transport> or it may be used in app anywhere.
@singleton
class HttpService {
  Future<String> postTransportData({
    required String endpoint,
    required Map<String, String> headers,
    required String data,
  }) async {
    final response = await http.post(
      Uri.parse(endpoint),
      headers: headers,
      body: data,
    );

    return response.body;
  }

  Future<String> getTransportData(String endpoint) async {
    final response = await http.get(Uri.parse(endpoint));

    return response.body;
  }
}
