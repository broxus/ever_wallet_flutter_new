import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

/// Service that makes pure http requests.
/// It's used in nekoton's <Transport> or it may be used in app anywhere.
@singleton
class HttpService {
  final _log = Logger('HttpService');

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
    _logResponse(endpoint, response, 'POST');

    return response.body;
  }

  Future<String> getTransportData(String endpoint) async {
    final response = await http.get(Uri.parse(endpoint));

    _logResponse(endpoint, response, 'GET');

    return response.body;
  }

  void _logResponse(String endpoint, http.Response response, String method) {
    final message =
        // ignore: lines_longer_than_80_chars
        '$method ${response.statusCode}, $endpoint, ${response.reasonPhrase ?? 'unknown reason'}';
    if (response.statusCode >= HttpStatus.badRequest) {
      _log.severe(message);
    } else {
      _log.finest(message);
    }
  }
}
