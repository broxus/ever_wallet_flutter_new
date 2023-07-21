part of 'browser_tabs_bloc.dart';

@freezed
class BrowserTabsBlocState with _$BrowserTabsBlocState {
  const factory BrowserTabsBlocState({
    required List<BrowserTab> tabs,
    required int currentTabId,
  }) = _BrowserTabsBlocState;
}
