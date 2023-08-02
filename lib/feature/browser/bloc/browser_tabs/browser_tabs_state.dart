part of 'browser_tabs_bloc.dart';

@freezed
class BrowserTabsState with _$BrowserTabsState {
  const factory BrowserTabsState({
    required List<BrowserTab> tabs,
    required String? currentTabId,
    required Map<String, BrowserTabState> tabsState,
  }) = _BrowserTabsState;
}
