part of 'browser_favicons_bloc.dart';

@freezed
class BrowserFaviconsState with _$BrowserFaviconsState {
  const factory BrowserFaviconsState({
    required Map<Uri, String?> items,
  }) = _BrowserFaviconsState;
}
