part of 'hud_bloc.dart';

@freezed
class HudState with _$HudState {
  const factory HudState.visible() = _Visible;
  const factory HudState.invisible() = _Invisible;
}
