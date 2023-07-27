part of 'browser_tabs_bloc.dart';

@freezed
class BrowserTabsState with _$BrowserTabsState {
  const factory BrowserTabsState({
    required List<BrowserTab> tabs,
    required int currentTabId,
    required BrowserTabState state,
    required int progress,
  }) = _BrowserTabsState;
}
