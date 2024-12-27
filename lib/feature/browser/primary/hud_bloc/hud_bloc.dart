import 'package:app/core/bloc/bloc_mixin.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'hud_bloc.freezed.dart';

part 'hud_event.dart';

part 'hud_state.dart';

class HudBloc extends Bloc<HudEvent, HudState> with BlocBaseMixin {
  HudBloc() : super(const _Visible()) {
    on<_Show>((event, emit) {
      emitSafe(const HudState.visible());
    });
    on<_Hide>((event, emit) {
      emitSafe(const HudState.invisible());
    });
  }
}
