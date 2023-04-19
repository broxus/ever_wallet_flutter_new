import 'package:freezed_annotation/freezed_annotation.dart';

part 'bookmark.freezed.dart';

part 'bookmark.g.dart';

@freezed
class Bookmark with _$Bookmark {
  const factory Bookmark({
    required int id,
    required String name,
    required String url,
  }) = _Bookmark;

  factory Bookmark.fromJson(Map<String, dynamic> json) =>
      _$BookmarkFromJson(json);
}
