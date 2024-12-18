import 'dart:async';
import 'dart:convert';

import 'package:app/app/service/connection/data/connection_data/connection_data.dart';
import 'package:app/app/service/connection/data/connection_network/connection_network.dart';
import 'package:app/app/service/connection/data/connection_transport/connection_transport_data.dart';
import 'package:app/app/service/connection/data/transport_icons.dart';
import 'package:app/app/service/connection/mapping/connection_network_mapper.dart';
import 'package:app/app/service/storage_service/secure_storage_service.dart';
import 'package:app/core/app_build_type.dart';
import 'package:app/http/api/presets/presets_api.dart';
import 'package:app/runner.dart';
import 'package:crypto/crypto.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

const _presetsDomain = 'presets';

@singleton
class PresetsConnectionService {
  PresetsConnectionService(
    this._presetsApi,
    this._secureStorage,
  );

  static const container = _presetsDomain;

  final PresetsApi _presetsApi;
  final SecureStorageService _secureStorage;

  final _presetsConnectionsSubj = BehaviorSubject<ConnectionNetwork?>();

  static final _logger = Logger('PresetsConnectionService');

  ConnectionNetwork? get _data => _presetsConnectionsSubj.valueOrNull;

  List<ConnectionData> get networks => _data?.networks ?? [];

  Map<String, ConnectionTransportData> get transports =>
      _data?.transports ?? {};

  String? get defaultConnectionId => _data?.defaultConnectionId;

  ConnectionData? get defaultNetwork => _data?.defaultNetwork;

  String? currentPresetId;

  String get _configFileName => switch (currentAppBuildType) {
        AppBuildType.production => 'connections_prod.json',
        _ => 'connections_dev.json',
      };

  TransportIcons getTransportIconsByNetwork(String networkType) {
    return transports[networkType]?.icons ?? TransportIcons();
  }

  Future<void> fetchConnectionsList() async {
    ConnectionNetwork? data;

    try {
      final response = await _presetsApi.getPresetConfig(_configFileName);
      final str = response.data;

      unawaited(_updateCacheIfNeed(str));

      data = mapToConnectionNetworkFromJson(
        jsonDecode(str) as Map<String, dynamic>,
      );
    } catch (e, s) {
      _logger.severe('Error fetch connections', e, s);
      try {
        final cache = await _secureStorage.getConnectionJson();
        if (cache != null) {
          data = mapToConnectionNetworkFromJson(
            await jsonDecode(cache) as Map<String, dynamic>,
          );
        }
      } catch (e, s) {
        _logger.severe('Error get connections from cache', e, s);
      }
    }

    _presetsConnectionsSubj.add(data);
  }

  Future<void> _updateCacheIfNeed(String data) async {
    final currentSha256 = sha256
        .convert(
          utf8.encode(data),
        )
        .toString();

    String? cachedSha256;

    try {
      cachedSha256 = await _secureStorage.getConnectionJsonHash();
    } catch (e, s) {
      _logger.severe('Error get hash', e, s);
    }

    if (currentSha256 != cachedSha256) {
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
}
