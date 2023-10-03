part of 'browser_favicons_bloc.dart';

@freezed
class BrowserFaviconsEvent with _$BrowserFaviconsEvent {
  const factory BrowserFaviconsEvent.fetchItems({
    required List<Uri> uris,
  }) = _FetchItems;

  const factory BrowserFaviconsEvent.setItem({
    required Uri uri,
    required String? faviconURL,
  }) = _SetItem;
}
