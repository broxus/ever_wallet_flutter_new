import 'package:freezed_annotation/freezed_annotation.dart';

part 'browser_tab.freezed.dart';

part 'browser_tab.g.dart';

@freezed
class BrowserTab with _$BrowserTab {
  const factory BrowserTab({
    required String url,
    required String? image,
    required String? title,
    required int lastScrollPosition,
  }) = _BrowserTab;

  factory BrowserTab.fromJson(Map<String, dynamic> json) =>
      _$BrowserTabFromJson(json);
}
