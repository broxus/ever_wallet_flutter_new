part of 'browser_bookmarks_bloc.dart';

@freezed
class BrowserBookmarksState with _$BrowserBookmarksState {
  const factory BrowserBookmarksState({
    required List<BrowserBookmarkItem> items,
    required bool isEditing,
  }) = _BrowserBookmarksState;
}
