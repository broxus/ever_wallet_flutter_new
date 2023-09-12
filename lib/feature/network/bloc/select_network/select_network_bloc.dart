import 'dart:async';

import 'package:app/app/service/nekoton_related/connection_service/network_presets.dart';
import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

part 'select_network_event.dart';
part 'select_network_state.dart';
part 'select_network_bloc.freezed.dart';

class SelectNetworkBloc extends Bloc<SelectNetworkEvent, SelectNetworkState> {
  SelectNetworkBloc(
    this.storageService,
  ) : super(
          SelectNetworkState(
            currentConnectionId: storageService.currentConnectionId,
            connections: storageService.connections,
          ),
        ) {
    _registerHandlers();

    _currentConnectionIdSubscription =
        storageService.currentConnectionIdStream.listen(
      (currentConnectionId) {
        add(SelectNetworkEvent.setCurrentConnectionId(id: currentConnectionId));
      },
    );

    _connectionsSubscription = storageService.connectionsStream.listen(
      (connections) {
        add(SelectNetworkEvent.setConnections(connections: connections));
      },
    );
  }

  final _log = Logger('SelectNetworkBloc');

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

      emit(
        state.copyWith(
          currentConnectionId: event.id,
        ),
      );

      storageService.saveCurrentConnectionId(event.id);
    });

    on<_setConnections>((event, emit) {
      emit(
        state.copyWith(
          connections: event.connections,
        ),
      );
    });
  }

  ConnectionData get currentConnection {
    final connections = state.connections;
    final currentConnectionId = state.currentConnectionId;

    return connections.firstWhere(
      (connection) => connection.id == currentConnectionId,
      orElse: () {
        _log.warning(
          'Current connection with id $currentConnectionId not found. '
          'Returning default connection',
        );

        return defaultNetwork;
      },
    );
  }
}
