import 'package:app/utils/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:uuid/uuid.dart';

part 'browser_bookmark_item.freezed.dart';
part 'browser_bookmark_item.g.dart';

@freezed
class BrowserBookmarkItem with _$BrowserBookmarkItem {
  const factory BrowserBookmarkItem({
    required String id,
    required String title,
    @uriJsonConverter required Uri url,
    required double sortingOrder,
  }) = _BrowserBookmarkItem;

  factory BrowserBookmarkItem.fromJson(Map<String, dynamic> json) =>
      _$BrowserBookmarkItemFromJson(json);

  factory BrowserBookmarkItem.create({
    required String title,
    required Uri url,
  }) =>
      BrowserBookmarkItem(
        id: const Uuid().v4(),
        title: title,
        url: url,
        sortingOrder: NtpTime.now().millisecondsSinceEpoch.toDouble(),
      );
}
