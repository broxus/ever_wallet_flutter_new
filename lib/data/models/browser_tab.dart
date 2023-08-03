import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
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
    required String? imageId,

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
        imageId: null,
        title: null,
        sortingOrder: DateTime.now().millisecondsSinceEpoch,
      );

  const BrowserTab._();

  factory BrowserTab.fromJson(Map<String, dynamic> json) =>
      _$BrowserTabFromJson(json);

  static String get tabsDirectoryPath {
    final appDocsDir =
        inject<GeneralStorageService>().applicationDocumentsDirectory;

    return '$appDocsDir/tabs';
  }

  // Yeah, in future we probably should support several screenshots per tab.
  static String get newImageId => const Uuid().v4();

  static String getTabDirectoryPath(String id) {
    return '$tabsDirectoryPath/$id';
  }

  String get imageDirectoryPath {
    return getTabDirectoryPath(id);
  }

  String? get imagePath {
    return imageId == null ? null : '${getTabDirectoryPath(id)}/$imageId';
  }

  String getImagePath(String imageId) {
    return '${getTabDirectoryPath(id)}/$imageId';
  }
}
