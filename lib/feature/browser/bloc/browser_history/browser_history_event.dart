part of 'browser_history_bloc.dart';

@freezed
class BrowserHistoryEvent with _$BrowserHistoryEvent {
  const factory BrowserHistoryEvent.add({required BrowserHistoryItem item}) =
      _Add;
  const factory BrowserHistoryEvent.remove({required String id}) = _Remove;
  const factory BrowserHistoryEvent.clear() = _Clear;
  const factory BrowserHistoryEvent.set({
    required List<BrowserHistoryItem> items,
  }) = _Set;
  const factory BrowserHistoryEvent.setSearchString({required String value}) =
      _SetSearchString;
  const factory BrowserHistoryEvent.setIsEditing({required bool value}) =
      _SetIsEditing;
}
