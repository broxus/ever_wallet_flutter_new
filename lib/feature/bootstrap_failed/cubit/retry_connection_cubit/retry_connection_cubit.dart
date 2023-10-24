import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:bloc/bloc.dart';
import 'package:logging/logging.dart';

/// Cubit that allows trigger bootstrap rerun after network was changed.
/// There is no any state, this is just a subscription.
class RetryConnectionCubit extends Cubit<void> {
  RetryConnectionCubit(
    this.storageService,
    this.bootstrapService,
  ) : super(null) {
    _currentConnectionIdSubscription =
        storageService.currentConnectionIdStream.skip(1).listen(
      (connectionId) {
        Logger('R etryConnectionCubit')
            .info('Retry bootstrap connection setting up: $connectionId');
        bootstrapService.rerunFailedSteps();
      },
    );
  }

  final BootstrapService bootstrapService;
  final ConnectionsStorageService storageService;

  StreamSubscription<String>? _currentConnectionIdSubscription;

  @override
  Future<void> close() {
    _currentConnectionIdSubscription?.cancel();

    return super.close();
  }
}
