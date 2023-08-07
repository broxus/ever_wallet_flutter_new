part of 'browser_history_bloc.dart';

@freezed
class BrowserHistoryState with _$BrowserHistoryState {
  const factory BrowserHistoryState({
    required List<BrowserHistoryItem> items,
  }) = _BrowserHistoryState;
}
