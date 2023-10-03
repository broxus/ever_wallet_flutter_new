// ignore_for_file: no-magic-number

import 'dart:math';

import 'package:app/data/models/browser_bookmark_item.dart';
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

extension BookmarkX on BrowserBookmarkItem {
  BookmarkDto toDto() => BookmarkDto(
        id: int.tryParse(id) ?? Random().nextInt(-1 >>> 1),
        name: title,
        url: url.toString(),
      );
}

extension BookmarkDtoX on BookmarkDto {
  BrowserBookmarkItem toModel() => BrowserBookmarkItem(
        id: '$id',
        title: name,
        url: Uri.parse(url),
        sortingOrder: -1,
      );
}
