// ignore_for_file: no-magic-number

import 'package:app/data/models/browser_history_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'search_history_dto.freezed.dart';
part 'search_history_dto.g.dart';

/// Title and image are taken via SiteMetaData with SitesMetaDataRepository
@freezed
class SearchHistoryDto with _$SearchHistoryDto {
  @HiveType(typeId: 56)
  const factory SearchHistoryDto({
    @HiveField(0) required String url,
    @HiveField(1) required DateTime openTime,
  }) = _SearchHistoryDto;
}

extension SiteMetaDataX on BrowserHistoryItem {
  SearchHistoryDto toDto() => SearchHistoryDto(
        url: url.toString(),
        openTime: visitTime,
      );
}

extension SiteMetaDataDtoX on SearchHistoryDto {
  BrowserHistoryItem toModel(int id) => BrowserHistoryItem(
        url: Uri.parse(url),
        visitTime: openTime,
        title: '',
        id: '$id',
      );
}
