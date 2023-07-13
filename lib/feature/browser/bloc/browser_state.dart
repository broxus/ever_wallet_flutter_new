part of 'browser_bloc.dart';

@freezed
class BrowserState with _$BrowserState {
  const factory BrowserState({
    required List<BrowserTab> tabs,
  }) = _BrowserState;

  const factory BrowserState.initial() = _Initial;
}
