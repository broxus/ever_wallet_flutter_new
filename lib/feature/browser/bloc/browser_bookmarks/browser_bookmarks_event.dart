part of 'browser_bookmarks_bloc.dart';

@freezed
class BrowserBookmarksEvent with _$BrowserBookmarksEvent {
  const factory BrowserBookmarksEvent.setItem({
    required BrowserBookmarkItem item,
  }) = _SetItem;
  const factory BrowserBookmarksEvent.remove({required String id}) = _Remove;
  const factory BrowserBookmarksEvent.clear() = _Clear;
  const factory BrowserBookmarksEvent.set({
    required List<BrowserBookmarkItem> items,
  }) = _Set;
  const factory BrowserBookmarksEvent.setSearchString({required String value}) =
      _SetSearchString;
  const factory BrowserBookmarksEvent.setIsEditing({required bool value}) =
      _SetIsEditing;
}
