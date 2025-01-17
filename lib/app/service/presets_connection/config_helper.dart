import 'dart:async';
import 'dart:convert';

import 'package:app/app/service/connection/data/connection_network/connection_network.dart';
import 'package:app/app/service/connection/mapping/connection_network_mapper.dart';
import 'package:app/app/service/storage_service/secure_storage_service.dart';
import 'package:app/bootstrap/sentry.dart';
import 'package:app/core/app_build_type.dart';
import 'package:app/core/exceptions/presets_connections_exceptions.dart';
import 'package:app/http/api/presets/presets_api.dart';
import 'package:app/runner.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';

class PresetsConnectionConfigHelper {
  PresetsConnectionConfigHelper(
    this._presetsApi,
    this._secureStorage,
    this._logger,
  );

  final PresetsApi _presetsApi;
  final SecureStorageService _secureStorage;
  final Logger _logger;
  final _sentry = SentryWorker.instance;

  Future<ConnectionNetwork?> get connections async =>
      await _getRemoteConnections() ??
      await _getCacheConnections() ??
      await _getLocalConnections();

  String get _configFileName => switch (currentAppBuildType) {
        AppBuildType.production => 'connections_prod.json',
        _ => 'connections_dev.json',
      };

  Future<ConnectionNetwork?> _getRemoteConnections() async {
    try {
      final response = await _presetsApi.getPresetConfig(_configFileName);
      final str = response.data;

      unawaited(_updateCacheIfNeed(str));

      return mapToConnectionNetworkFromJson(
        jsonDecode(str) as Map<String, dynamic>,
      );
    } catch (e, s) {
      _sentry.captureException(
        FetchPresetsConnectionsExceptions(
          switch (e) {
            DioException() => '${e.response?.data}',
            _ => '',
          },
        ),
        stackTrace: s,
      );
      _logger.severe('Error fetch connections', e, s);
      return null;
    }
  }

  Future<ConnectionNetwork?> _getCacheConnections() async {
    try {
      final cache = await _secureStorage.getConnectionJson();
      if (cache == null) {
        throw CachePresetsConnectionsExceptions('Cache is null');
      }

      return mapToConnectionNetworkFromJson(
        await jsonDecode(cache) as Map<String, dynamic>,
      );
    } catch (e, s) {
      _sentry.captureException(
        e is CachePresetsConnectionsExceptions
            ? e
            : CachePresetsConnectionsExceptions(e.toString()),
        stackTrace: s,
      );
      _logger.severe('Error get connections from cache', e, s);

      return null;
    }
  }

  Future<ConnectionNetwork?> _getLocalConnections() async {
    try {
      final cache =
          await rootBundle.loadString('assets/configs/connections.json');

      if (cache.isEmpty) {
        throw LocalPresetsConnectionsExceptions('Error read local file');
      }

      return mapToConnectionNetworkFromJson(
        await jsonDecode(cache) as Map<String, dynamic>,
      );
    } catch (e, s) {
      _sentry.captureException(
        e is LocalPresetsConnectionsExceptions
            ? e
            : LocalPresetsConnectionsExceptions(e.toString()),
        stackTrace: s,
      );
      _logger.severe('Error get local config file', e, s);

      return null;
    }
  }

  Future<void> _updateCacheIfNeed(String data) async {
    final currentSha256 = sha256.convert(utf8.encode(data)).toString();

    String? cachedSha256;

    try {
      cachedSha256 = await _secureStorage.getConnectionJsonHash();
    } catch (e, s) {
      _logger.severe('Error get hash', e, s);
    }

    if (currentSha256 == cachedSha256) {
      return;
    }

    try {
      await _secureStorage.setConnectionJsonHash(currentSha256);
    } catch (e, s) {
      _logger.severe('Error save hash', e, s);
    }

    try {
      await _secureStorage.setConnectionJson(data);
    } catch (e, s) {
      _logger.severe('Error save hash', e, s);
    }
  }
}
