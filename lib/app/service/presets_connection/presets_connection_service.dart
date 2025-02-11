import 'dart:async';

import 'package:app/app/service/connection/data/connection_data/connection_data.dart';
import 'package:app/app/service/connection/data/connection_network/connection_network.dart';
import 'package:app/app/service/connection/data/connection_transport/connection_transport_data.dart';
import 'package:app/app/service/connection/data/default_active_asset.dart';
import 'package:app/app/service/connection/data/transport_icons.dart';
import 'package:app/app/service/connection/default_network.dart';
import 'package:app/app/service/connection/group.dart';
import 'package:app/app/service/presets_connection/config_helper.dart';
import 'package:app/app/service/storage_service/secure_storage_service.dart';
import 'package:app/http/api/presets/presets_api.dart';
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
  static final _logger = Logger('PresetsConnectionService');

  final PresetsApi _presetsApi;
  final SecureStorageService _secureStorage;

  final _presetsConnectionsSubj = BehaviorSubject<ConnectionNetwork?>();

  late final _configHelper = PresetsConnectionConfigHelper(
    _presetsApi,
    _secureStorage,
    _logger,
  );

  ConnectionNetwork? get _connectionNetwork => _presetsConnectionsSubj.value;

  List<String>? get customNetworkOptions =>
      _connectionNetwork?.customNetworkOptionTypes;

  ConnectionNetwork? get _data => _presetsConnectionsSubj.valueOrNull;

  List<ConnectionData> get networks => _data?.networks ?? [];

  Map<NetworkGroup, ConnectionTransportData> get transports =>
      _data?.transports ?? {};

  String? get defaultConnectionId => _data?.defaultConnectionId;

  ConnectionData get defaultNetwork =>
      _data?.defaultNetwork ?? defaultPresetNetwork;

  String? currentPresetId;

  TransportIcons getTransportIconsByNetwork(NetworkGroup networkGroup) {
    return transports[networkGroup]?.icons ?? TransportIcons();
  }

  List<DefaultActiveAsset> getDefaultActiveAsset(NetworkGroup group) {
    return transports[group]?.defaultActiveAssets ?? [];
  }

  Future<void> fetchConnectionsList() async {
    _presetsConnectionsSubj.add(await _configHelper.connections);
  }
}
