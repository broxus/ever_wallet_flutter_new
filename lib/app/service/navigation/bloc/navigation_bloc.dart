import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';
part 'navigation_bloc.freezed.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc()
      : super(
          const NavigationState(),
        ) {
    on<_NavigatedTo>((event, emit) {
      if (event.location == state.location) {
        return;
      }

      emit(
        state.copyWith(
          location: event.location,
          oldLocation: state.location,
        ),
      );
    });
  }
  StreamSubscription<String>? _locationSubscription;

  void init() {
    final navigationService = inject<NavigationService>();
    _locationSubscription = navigationService.locationStream.listen((event) {
      add(NavigationEvent.navigatedTo(event));
    });
  }

  @override
  Future<void> close() {
    _locationSubscription?.cancel();
    _locationSubscription = null;

    return super.close();
  }
}
