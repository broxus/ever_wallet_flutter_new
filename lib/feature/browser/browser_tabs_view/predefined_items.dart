// ignore_for_file: no-magic-number

import 'package:app/data/models/models.dart';

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

// TODO(knightforce): temporarily hiding
List<BrowserBookmarkItem> predefinedItems() => [
      // Example:
      // BrowserBookmarkItem(
      //   id: 'temp',
      //   title: LocaleKeys.temp.tr(),
      //   url: Uri.parse(LocaleKeys.tempUrl.tr()),
      //   sortingOrder: 1,
      // ),
    ]..sort(
        (a, b) => (b.sortingOrder - a.sortingOrder).sign.toInt(),
      );

// TODO(knightforce): temporarily hiding
List<BrowserCard> predefinedCards() => [
      // Example:
      // BrowserCard(
      //   title: LocaleKeys.temp.tr(),
      //   description: LocaleKeys.temp.tr(),
      //   url: Uri.parse(LocaleKeys.tempUrl.tr()),
      //   imagePath: Assets.images.temp.path,
      // ),
    ];
