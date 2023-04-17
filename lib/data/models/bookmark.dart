import 'package:freezed_annotation/freezed_annotation.dart';

part 'bookmark.freezed.dart';

@freezed
class Bookmark with _$Bookmark {
  const factory Bookmark({
    required int id,
    required String name,
    required String url,
  }) = _Bookmark;
}
