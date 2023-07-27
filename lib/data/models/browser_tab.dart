import 'package:clock/clock.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:uuid/uuid.dart';

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
    /// The id of the tab.
    required String id,

    /// The url of the tab.
    @uriJsonConverter required Uri url,

    /// The screenshot of the tab.
    required String? image,

    /// The title of the tab.
    required String? title,

    /// The sorting position of the tab.
    required int sortingOrder,

    /// Transient field to store the state of the tab.
    @JsonKey(
      includeFromJson: false,
      includeToJson: false,
    )
    @Default(BrowserTabState.initial)
    BrowserTabState state,

    /// Transient field to store the progress of the tab.
    @JsonKey(
      includeFromJson: false,
      includeToJson: false,
    )
    @Default(0)
    int progress,
  }) = _BrowserTab;

  factory BrowserTab.create({
    required Uri url,
  }) =>
      BrowserTab(
        id: const Uuid().v4(),
        url: url,
        image: null,
        title: null,
        sortingOrder: DateTime.now().millisecondsSinceEpoch,
      );

  factory BrowserTab.fromJson(Map<String, dynamic> json) =>
      _$BrowserTabFromJson(json);
}
