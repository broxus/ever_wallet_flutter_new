import 'package:app/data/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'browser_tabs_bloc_event.dart';
part 'browser_tabs_bloc_state.dart';
part 'browser_tabs_bloc_bloc.freezed.dart';

class BrowserTabsBlocBloc
    extends Bloc<BrowserTabsBlocEvent, BrowserTabsBlocState> {
  BrowserTabsBlocBloc() : super(_Initial()) {
    on<BrowserTabsBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
