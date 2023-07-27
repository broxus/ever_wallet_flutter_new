// ignore_for_file: no-magic-number

import 'dart:typed_data';

import 'package:app/data/models/browser_tab.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'browser_tab_dto.freezed.dart';

part 'browser_tab_dto.g.dart';

@freezed
class BrowserTabDto with _$BrowserTabDto {
  @HiveType(typeId: 55)
  const factory BrowserTabDto({
    @HiveField(0) required String url,
    @HiveField(1) required String? image,
    @HiveField(2) required String? title,
    @HiveField(3, defaultValue: 0) required int lastScrollPosition,
    @HiveField(4) Uint8List? screenshot,
  }) = _BrowserTab;
}

extension BrowserTabX on BrowserTab {
  BrowserTabDto toDto() => BrowserTabDto(
        url: url.toString(),
        lastScrollPosition: 0,
        image: image,
        title: title,
      );
}

extension BrowserTabDtoX on BrowserTabDto {
  BrowserTab toModel(int id) => BrowserTab(
        url: Uri.parse(url),
        sortingOrder: DateTime.now().millisecondsSinceEpoch,
        image: image,
        title: title,
        id: '$id',
      );
}
