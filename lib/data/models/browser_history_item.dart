import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'browser_history_item.freezed.dart';

part 'browser_history_item.g.dart';

@freezed
class BrowserHistoryItem with _$BrowserHistoryItem {
  const factory BrowserHistoryItem({
    /// The id of the tab.
    required String id,
    required String title,
    required String url,
    required DateTime visitTime,
  }) = _BrowserHistoryItemDto;

  factory BrowserHistoryItem.create({
    required String title,
    required String url,
  }) =>
      BrowserHistoryItem(
        id: const Uuid().v4(),
        title: title,
        url: url,
        visitTime: DateTime.now(),
      );

  const BrowserHistoryItem._();

  factory BrowserHistoryItem.fromJson(Map<String, dynamic> json) =>
      _$BrowserHistoryItemFromJson(json);
}
