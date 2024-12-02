import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin BlocMixin<Event, State> on Bloc<Event, State> {
  void addSafe(Event event) {
    if (isClosed) {
      return;
    }
    try {
      add(event);
    } catch (_) {}
  }
}

mixin BlocBaseMixin<T> on BlocBase<T> {
  @protected
  @visibleForTesting
  void emitSafe(T state) {
    if (isClosed) {
      return;
    }
    try {
      emit(state);
    } catch (_) {}
  }
}
