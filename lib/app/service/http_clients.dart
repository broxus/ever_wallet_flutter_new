import 'dart:io';
import 'dart:typed_data';

import 'package:app/app/service/service.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

abstract class BaseHttpClient {
  final _client = http.Client();
  late final _log = Logger(runtimeType.toString());

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

class JettonGqlHttpClient implements GqlConnectionHttpClient {
  JettonGqlHttpClient(this._storage);

  final AppStorageService _storage;

  @override
  Future<String> post({
    required String endpoint,
    required Map<String, String> headers,
    required String data,
  }) async {
    // dton requests could be cached permanently
    final key = _CacheKey(data);
    var value = _storage.getValue<String>(key);

    if (value == null) {
      final response = await http.post(
        Uri.parse(endpoint),
        headers: headers,
        body: data,
      );

      value = response.body;
      _storage.addValue(key, value);
    }

    return value;
  }

  @override
  Future<String> get(String endpoint) async {
    final response = await http.get(Uri.parse(endpoint));
    return response.body;
  }

  @override
  void dispose() {}
}

class _CacheKey implements StorageKey {
  _CacheKey(this._key);

  final String _key;

  @override
  String get value => 'dton-cache:$_key';
}
