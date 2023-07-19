part of 'browser_tabs_bloc_bloc.dart';

@freezed
class BrowserTabsBlocEvent with _$BrowserTabsBlocEvent {
  const factory BrowserTabsBlocEvent.addTab({required Uri uri}) = _AddTab;
  const factory BrowserTabsBlocEvent.closeAll() = _CloseAll;
}
