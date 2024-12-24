import 'dart:async';

import 'package:app/app/service/nekoton_related/connection_service/network_presets.dart';
import 'package:app/app/service/service.dart';
import 'package:app/core/bloc/bloc_mixin.dart';
import 'package:app/data/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

part 'manage_networks_bloc.freezed.dart';

part 'manage_networks_event.dart';

part 'manage_networks_state.dart';

class ManageNetworksBloc extends Bloc<ManageNetworksEvent, ManageNetworksState>
    with BlocBaseMixin {
  ManageNetworksBloc(
    this.storageService,
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

  StreamSubscription<String>? _currentConnectionIdSubscription;
  StreamSubscription<List<ConnectionData>>? _connectionsSubscription;

  ConnectionsStorageService storageService;

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

      emitSafe(
        state.copyWith(
          currentConnectionId: event.id,
        ),
      );
    });

    on<_updateCurrentConnectionId>((event, emit) {
      storageService.saveCurrentConnectionId(event.id);
    });

    on<_setConnections>((event, emit) {
      emitSafe(
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

  ConnectionData get currentConnection {
    final currentConnectionId = state.currentConnectionId;

    final connection = getConnection(currentConnectionId);
    if (connection != null) {
      return connection;
    }

    _log.warning(
      'Current connection with id $currentConnectionId not found. '
      'Returning default connection',
    );

    return defaultNetwork;
  }

  ConnectionData? getConnection(String connectionId) {
    final connections = state.connections;

    return connections.firstWhereOrNull(
      (connection) => connection.id == connectionId,
    );
  }
}
