// ignore_for_file: no-magic-number

import 'package:app/data/models/models.dart';
import 'package:app/generated/generated.dart';

class BrowserCard {
  BrowserCard({
    required this.title,
    required this.description,
    required this.url,
    required this.imagePath,
  });
  final String title;
  final String description;
  final Uri url;
  final String imagePath;
}

List<BrowserBookmarkItem> predefinedItems() => [
      BrowserBookmarkItem(
        id: '',
        title: LocaleKeys.browserLink01Title.tr(),
        url: Uri.parse(LocaleKeys.browserLink01Url.tr()),
        faviconUrl: LocaleKeys.browserLink01Favicon.tr(),
        sortingOrder: 6,
      ),
      BrowserBookmarkItem(
        id: '',
        title: LocaleKeys.browserLink02Title.tr(),
        url: Uri.parse(LocaleKeys.browserLink02Url.tr()),
        faviconUrl: LocaleKeys.browserLink02Favicon.tr(),
        sortingOrder: 5,
      ),
      BrowserBookmarkItem(
        id: '',
        title: LocaleKeys.browserLink03Title.tr(),
        url: Uri.parse(LocaleKeys.browserLink03Url.tr()),
        faviconUrl: LocaleKeys.browserLink03Favicon.tr(),
        sortingOrder: 4,
      ),
      BrowserBookmarkItem(
        id: '',
        title: LocaleKeys.browserLink04Title.tr(),
        url: Uri.parse(LocaleKeys.browserLink04Url.tr()),
        faviconUrl: LocaleKeys.browserLink04Favicon.tr(),
        sortingOrder: 3,
      ),
      BrowserBookmarkItem(
        id: '',
        title: LocaleKeys.browserLink05Title.tr(),
        url: Uri.parse(LocaleKeys.browserLink05Url.tr()),
        faviconUrl: LocaleKeys.browserLink05Favicon.tr(),
        sortingOrder: 2,
      ),
      BrowserBookmarkItem(
        id: '',
        title: LocaleKeys.browserLink06Title.tr(),
        url: Uri.parse(LocaleKeys.browserLink06Url.tr()),
        faviconUrl: LocaleKeys.browserLink06Favicon.tr(),
        sortingOrder: 1,
      ),
    ]..sort(
        (a, b) => (b.sortingOrder - a.sortingOrder).sign.toInt(),
      );

List<BrowserCard> predefinedCards() => [
      BrowserCard(
        title: LocaleKeys.browserCardLink01Title.tr(),
        description: LocaleKeys.browserCardLink01Description.tr(),
        url: Uri.parse(LocaleKeys.browserCardLink01Url.tr()),
        imagePath: Assets.images.browserCard01.path,
      ),
      BrowserCard(
        title: LocaleKeys.browserCardLink02Title.tr(),
        description: LocaleKeys.browserCardLink02Description.tr(),
        url: Uri.parse(LocaleKeys.browserCardLink02Url.tr()),
        imagePath: Assets.images.browserCard02.path,
      ),
    ];
