import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_history.freezed.dart';

part 'search_history.g.dart';

@freezed
class SearchHistory with _$SearchHistory {
  const factory SearchHistory({
    required String url,
    required DateTime openTime,
  }) = _SearchHistoryDto;

  factory SearchHistory.fromJson(Map<String, dynamic> json) =>
      _$SearchHistoryFromJson(json);
}
