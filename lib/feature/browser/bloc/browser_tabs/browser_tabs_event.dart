part of 'browser_tabs_bloc.dart';

@freezed
class BrowserTabsEvent with _$BrowserTabsEvent {
  const factory BrowserTabsEvent.add({required Uri uri}) = _Add;
  const factory BrowserTabsEvent.addEmpty() = _AddEmpty;
  const factory BrowserTabsEvent.setUrl({
    required String id,
    required Uri uri,
  }) = _SetUrl;
  const factory BrowserTabsEvent.setScreenshot({
    required String id,
    required String imageId,
  }) = _SetScreenshot;
  const factory BrowserTabsEvent.setState({
    required String id,
    BrowserTabStateType? state,
    int? progress,
    String? errorMessage,
    String? title,
    String? faviconUrl,
    bool? canGoBack,
    bool? canGoForward,
    VoidCallback? goBack,
    VoidCallback? goForward,
    VoidCallback? refresh,
  }) = _SetState;
  const factory BrowserTabsEvent.remove({required String id}) = _Remove;
  const factory BrowserTabsEvent.setActive({required String id}) = _SetActive;
  const factory BrowserTabsEvent.closeAll() = _CloseAll;
  const factory BrowserTabsEvent.setTabs({required List<BrowserTab> tabs}) =
      _SetTabs;
  const factory BrowserTabsEvent.setActiveTabId({required String? id}) =
      _SetActiveTabId;
  const factory BrowserTabsEvent.clearCache() = _ClearCache;
  const factory BrowserTabsEvent.cacheCleared() = _CacheCleared;
}
