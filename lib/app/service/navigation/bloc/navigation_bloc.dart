import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/core/bloc/bloc_mixin.dart';
import 'package:app/di/di.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'navigation_bloc.freezed.dart';

part 'navigation_event.dart';

part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState>
    with BlocBaseMixin {
  NavigationBloc()
      : super(
          const NavigationState(),
        ) {
    on<_NavigatedTo>((event, emit) {
      if (event.state == state.state) {
        return;
      }

      emitSafe(
        state.copyWith(
          state: event.state,
          oldState: state.state,
        ),
      );
    });
  }

  StreamSubscription<NavigationServiceState>? _serviceSubscription;

  void init() {
    final navigationService = inject<NavigationService>();
    _serviceSubscription = navigationService.stateStream.listen((event) {
      add(NavigationEvent.navigatedTo(event));
    });
  }

  @override
  Future<void> close() {
    _serviceSubscription?.cancel();
    _serviceSubscription = null;

    return super.close();
  }
}
