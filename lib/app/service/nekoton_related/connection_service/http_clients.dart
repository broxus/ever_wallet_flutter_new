import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

abstract class BaseHttpClient {
  final _client = Client();
  final _log = Logger('HttpService');

  void _logResponse(String endpoint, Response response, String method) {
    final message =
        // ignore: lines_longer_than_80_chars
        '$method ${response.statusCode}, $endpoint, ${response.reasonPhrase ?? 'unknown reason'}';
    if (response.statusCode >= HttpStatus.badRequest) {
      _log.severe(message);
    } else {
      _log.finest(message);
    }
  }

  void dispose() {
    _client.close();
  }
}

class JrpcHttpClient extends BaseHttpClient
    implements JrpcConnectionHttpClient {
  @override
  Future<String> post({
    required String endpoint,
    required Map<String, String> headers,
    required String data,
  }) async {
    final response = await _client.post(
      Uri.parse(endpoint),
      headers: headers,
      body: data,
    );
    _logResponse(endpoint, response, 'POST');

    return response.body;
  }
}

class ProtoHttpClient extends BaseHttpClient
    implements ProtoConnectionHttpClient {
  @override
  Future<Uint8List> post({
    required String endpoint,
    required Map<String, String> headers,
    required Uint8List dataBytes,
  }) async {
    final response = await _client.post(
      Uri.parse(endpoint),
      headers: headers,
      body: dataBytes,
    );
    _logResponse(endpoint, response, 'POST');

    return response.bodyBytes;
  }
}

class GqlHttpClient extends BaseHttpClient implements GqlConnectionHttpClient {
  @override
  Future<String> get(String endpoint) async {
    final response = await _client.get(Uri.parse(endpoint));
    _logResponse(endpoint, response, 'GET');
    return response.body;
  }

  @override
  Future<String> post({
    required String endpoint,
    required Map<String, String> headers,
    required String data,
  }) async {
    final response = await _client.post(
      Uri.parse(endpoint),
      headers: headers,
      body: data,
    );
    _logResponse(endpoint, response, 'POST');

    return response.body;
  }
}
