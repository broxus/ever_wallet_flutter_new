import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'browser_tab.freezed.dart';

part 'browser_tab.g.dart';

enum BrowserTabState {
  initial,
  loading,
  loaded,
  error,
}

@freezed
class BrowserTab with _$BrowserTab {
  const factory BrowserTab({
    @uriJsonConverter required Uri url,
    required String? image,
    required String? title,
    required int lastScrollPosition,
    required int id,
    @JsonKey(
      includeFromJson: false,
      includeToJson: false,
    )
    @Default(BrowserTabState.initial)
    BrowserTabState state,
    @JsonKey(
      includeFromJson: false,
      includeToJson: false,
    )
    @Default(0)
    int progress,
  }) = _BrowserTab;

  factory BrowserTab.fromJson(Map<String, dynamic> json) =>
      _$BrowserTabFromJson(json);
}
