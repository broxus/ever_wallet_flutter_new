import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

part 'browser_tab.freezed.dart';
part 'browser_tab.g.dart';

@freezed
class BrowserTab with _$BrowserTab {
  const factory BrowserTab({
    /// The id of the tab.
    required String id,

    /// The url of the tab.
    @uriJsonConverter required Uri url,

    /// The screenshot path of the tab.
    required String? imagePath,

    /// The title of the tab.
    required String? title,

    /// The sorting position of the tab.
    required int sortingOrder,
  }) = _BrowserTab;

  factory BrowserTab.create({
    required Uri url,
  }) =>
      BrowserTab(
        id: const Uuid().v4(),
        url: url,
        imagePath: null,
        title: null,
        sortingOrder: DateTime.now().millisecondsSinceEpoch,
      );

  const BrowserTab._();

  factory BrowserTab.fromJson(Map<String, dynamic> json) =>
      _$BrowserTabFromJson(json);

  static Future<String> get tabsDirectoryPath async {
    final appDocsDir = (await getApplicationDocumentsDirectory()).path;

    return '$appDocsDir/tabs';
  }

  static Future<String> getTabsDirectoryPath(String id) async {
    return '${await tabsDirectoryPath}/$id';
  }

  Future<String> get imageDirectoryPath async {
    return getTabsDirectoryPath(id);
  }
}
