import 'dart:async';

import 'package:app/app/service/connection/data/connection_data/connection_data.dart';
import 'package:app/app/service/connection/presets_connection_service.dart';
import 'package:app/app/service/service.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

part 'manage_networks_bloc.freezed.dart';

part 'manage_networks_event.dart';

part 'manage_networks_state.dart';

class ManageNetworksBloc
    extends Bloc<ManageNetworksEvent, ManageNetworksState> {
  ManageNetworksBloc(
    this.storageService,
    this._presetsConnectionService,
  ) : super(
          ManageNetworksState(
            currentConnectionId: storageService.currentConnectionId,
            connections: storageService.connections,
          ),
        ) {
    _registerHandlers();

    _currentConnectionIdSubscription =
        storageService.currentConnectionIdStream.listen(
      (currentConnectionId) {
        add(
          ManageNetworksEvent.setCurrentConnectionId(
            id: currentConnectionId,
          ),
        );
      },
    );

    _connectionsSubscription = storageService.connectionsStream.listen(
      (connections) {
        add(
          ManageNetworksEvent.setConnections(
            connections: connections,
          ),
        );
      },
    );
  }

  final _log = Logger('ManageNetworksBloc');

  ConnectionsStorageService storageService;
  final PresetsConnectionService _presetsConnectionService;

  StreamSubscription<String>? _currentConnectionIdSubscription;
  StreamSubscription<List<ConnectionData>>? _connectionsSubscription;

  ConnectionData? get _defaultNetwork =>
      _presetsConnectionService.defaultNetwork;

  @override
  Future<void> close() {
    _currentConnectionIdSubscription?.cancel();
    _connectionsSubscription?.cancel();

    return super.close();
  }

  void _registerHandlers() {
    on<_setCurrentConnectionId>((event, emit) {
      if (event.id == state.currentConnectionId) {
        return;
      }

      emit(
        state.copyWith(
          currentConnectionId: event.id,
        ),
      );
    });

    on<_updateCurrentConnectionId>((event, emit) {
      storageService.saveCurrentConnectionId(event.id);
    });

    on<_setConnections>((event, emit) {
      emit(
        state.copyWith(
          connections: event.connections,
        ),
      );
    });

    on<_addConnection>((event, emit) {
      storageService.addConnection(event.connection);
    });

    on<_updateConnection>((event, emit) {
      storageService.updateConnection(event.connection);
    });

    on<_removeConnection>((event, emit) {
      storageService.removeConnection(event.id);
    });

    on<_revertConnection>((event, emit) {
      storageService.revertConnection(event.id);
    });
  }

  ConnectionData? get currentConnection {
    final currentConnectionId = state.currentConnectionId;

    if (currentConnectionId == null) {
      return null;
    }

    final connection = getConnection(currentConnectionId);
    if (connection != null) {
      return connection;
    }

    _log.warning(
      'Current connection with id $currentConnectionId not found. '
      'Returning default connection',
    );

    return _defaultNetwork;
  }

  ConnectionData? getConnection(String connectionId) {
    final connections = state.connections;

    return connections.firstWhereOrNull(
      (connection) => connection.id == connectionId,
    );
  }
}
