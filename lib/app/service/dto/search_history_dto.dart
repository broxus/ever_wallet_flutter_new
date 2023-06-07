// ignore_for_file: no-magic-number

import 'package:app/data/models/search_history.dart';
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

extension SiteMetaDataX on SearchHistory {
  SearchHistoryDto toDto() => SearchHistoryDto(
        url: url,
        openTime: openTime,
      );
}

extension SiteMetaDataDtoX on SearchHistoryDto {
  SearchHistory toModel() => SearchHistory(
        url: url,
        openTime: openTime,
      );
}
