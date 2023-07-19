part of 'hud_bloc.dart';

@freezed
class HudEvent with _$HudEvent {
  const factory HudEvent.show() = _Show;
  const factory HudEvent.hide() = _Hide;
}
