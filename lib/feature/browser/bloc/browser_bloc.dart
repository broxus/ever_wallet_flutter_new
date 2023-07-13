import 'package:app/data/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'browser_event.dart';
part 'browser_state.dart';
part 'browser_bloc.freezed.dart';

class BrowserBloc extends Bloc<BrowserEvent, BrowserState> {
  BrowserBloc() : super(_Initial()) {
    on<BrowserEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
