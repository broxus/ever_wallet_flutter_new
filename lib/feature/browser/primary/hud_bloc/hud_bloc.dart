import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'hud_event.dart';
part 'hud_state.dart';
part 'hud_bloc.freezed.dart';

class HudBloc extends Bloc<HudEvent, HudState> {
  HudBloc() : super(const _Visible()) {
    on<_Show>((event, emit) {
      emit(const HudState.visible());
    });
    on<_Hide>((event, emit) {
      emit(const HudState.invisible());
    });
  }
}
