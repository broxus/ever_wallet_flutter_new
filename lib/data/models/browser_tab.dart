import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'browser_tab.freezed.dart';

part 'browser_tab.g.dart';

@freezed
class BrowserTab with _$BrowserTab {
  const factory BrowserTab({
    @uriJsonConverter required Uri url,
    required String? image,
    required String? title,
    required int lastScrollPosition,
  }) = _BrowserTab;

  factory BrowserTab.fromJson(Map<String, dynamic> json) =>
      _$BrowserTabFromJson(json);
}
