// ignore_for_file: no-magic-number

import 'package:app/data/models/bookmark.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'bookmark_dto.freezed.dart';
part 'bookmark_dto.g.dart';

@freezed
class BookmarkDto with _$BookmarkDto {
  @HiveType(typeId: 3)
  const factory BookmarkDto({
    @HiveField(0) required int id,
    @HiveField(1) required String name,
    @HiveField(2) required String url,
  }) = _BookmarkDto;
}

extension BookmarkX on Bookmark {
  BookmarkDto toDto() => BookmarkDto(
        id: id,
        name: name,
        url: url,
      );
}

extension BookmarkDtoX on BookmarkDto {
  Bookmark toModel() => Bookmark(
        id: id,
        name: name,
        url: url,
      );
}
