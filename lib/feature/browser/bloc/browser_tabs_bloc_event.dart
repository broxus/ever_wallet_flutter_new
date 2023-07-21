part of 'browser_tabs_bloc.dart';

@freezed
class BrowserTabsBlocEvent with _$BrowserTabsBlocEvent {
  const factory BrowserTabsBlocEvent.add({required Uri uri}) = _Add;
  const factory BrowserTabsBlocEvent.remove({required int id}) = _Remove;
  const factory BrowserTabsBlocEvent.setActive({required int id}) = _SetActive;
  const factory BrowserTabsBlocEvent.closeAll() = _CloseAll;
  const factory BrowserTabsBlocEvent.setTabs({required List<BrowserTab> tabs}) =
      _SetTabs;
  const factory BrowserTabsBlocEvent.setActiveTabId({required int id}) =
      _SetActiveTabId;
}
