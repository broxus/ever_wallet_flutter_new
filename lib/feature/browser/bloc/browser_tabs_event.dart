part of 'browser_tabs_bloc.dart';

@freezed
class BrowserTabsEvent with _$BrowserTabsEvent {
  const factory BrowserTabsEvent.add({required Uri uri}) = _Add;
  const factory BrowserTabsEvent.addEmpty() = _AddEmpty;
  const factory BrowserTabsEvent.setUrl({required Uri uri}) = _SetUrl;
  const factory BrowserTabsEvent.remove({required int id}) = _Remove;
  const factory BrowserTabsEvent.setActive({required int id}) = _SetActive;
  const factory BrowserTabsEvent.closeAll() = _CloseAll;
  const factory BrowserTabsEvent.setTabs({required List<BrowserTab> tabs}) =
      _SetTabs;
  const factory BrowserTabsEvent.setActiveTabId({required int id}) =
      _SetActiveTabId;
}
