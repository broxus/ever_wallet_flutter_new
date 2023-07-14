part of 'browser_tabs_bloc_bloc.dart';

@freezed
class BrowserTabsBlocState with _$BrowserTabsBlocState {
  const factory BrowserTabsBlocState({
    required List<BrowserTab> tabs,
    @Default(null) BrowserTab? activeTab,
  }) = _BrowserTabsBlocState;

  const factory BrowserTabsBlocState.initial() = _Initial;
}
