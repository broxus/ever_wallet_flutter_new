import 'dart:io';
import 'dart:ui' as ui;

import 'package:app/app/router/router.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:app/feature/browser/browser_tabs_view/predefined_items.dart';
import 'package:app/generated/generated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Item count limit for each section
const _itemCountLimit = 6;

/// Card height
const _cardHeight = 116.0;

/// Card viewport fraction
const _cardViewportFraction = 0.85;

/// How ofter we can take screenshot
const Duration _screenShotPeriodDuration = Duration(seconds: 5);

class BrowserStartView extends StatefulWidget {
  const BrowserStartView({super.key});

  @override
  State<BrowserStartView> createState() => _BrowserStartViewState();
}

class _BrowserStartViewState extends State<BrowserStartView> {
  final _log = Logger('_BrowserStartViewState');

  final _predefinedItems = predefinedItems();
  final _predefinedCards = predefinedCards();
  final _cardController = PageController(
    viewportFraction: _cardViewportFraction,
  );
  final _globalKey = GlobalKey();
  DateTime? _lastScreenshotTime;

  @override
  void dispose() {
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;
    final bookmarkItems =
        context.watch<BrowserBookmarksBloc>().getSortedItems();
    final searchText = context.watch<BrowserTabsBloc>().state.searchText;

    if (searchText.isEmpty) {
      _saveScreenshot();
    }

    final slivers = searchText.isEmpty
        ? [
            ..._sectionBuilder(
              title: LocaleKeys.browserBookmarks.tr(),
              items: bookmarkItems,
              buttonText: LocaleKeys.browserSeeAll.tr(),
              buttonOnPressed: _onSeeAllPressed,
            ),
            ..._sectionBuilder(
              title: LocaleKeys.browserPopularResources.tr(),
              items: _predefinedItems,
            ),
            ..._cardsBuilder(),
          ]
        : _searchResultBuilder(
            items: [...bookmarkItems, ..._predefinedItems],
            searchText: searchText,
          );

    return RepaintBoundary(
      key: _globalKey,
      child: ColoredBox(
        color: colors.appBackground,
        child: CustomScrollView(
          slivers: slivers,
        ),
      ),
    );
  }

  Future<void> _saveScreenshot() async {
    final now = DateTime.now();
    if (_lastScreenshotTime != null &&
        now.difference(_lastScreenshotTime!) < _screenShotPeriodDuration) {
      return;
    }

    _lastScreenshotTime = now;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        final boundary = _globalKey.currentContext?.findRenderObject()
            as RenderRepaintBoundary?;

        final image = await boundary!.toImage(pixelRatio: 2);

        final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
        final pngBytes = byteData?.buffer.asUint8List().toList();
        if (pngBytes == null) {
          throw Exception("Can't convert image to bytes");
        }

        final file = File(BrowserTab.defaultImagePath);
        await file.writeAsBytes(pngBytes);

        await FileImage(File(BrowserTab.defaultImagePath)).evict();
      } catch (e, s) {
        _log.severe('Error while saving screenshot: $e', null, s);
      }
    });
  }

  List<Widget> _searchResultBuilder({
    required List<BrowserBookmarkItem> items,
    required String searchText,
  }) {
    // TODO(nesquikm): We probably should create bloc to handle
    // this kind of logic
    final filteredItems = items.where((item) {
      final title = item.title.toLowerCase();
      final url = item.url.toString().toLowerCase();
      final search = searchText.toLowerCase();

      return title.contains(search) || url.contains(search);
    }).toList();

    if (filteredItems.isEmpty) {
      return [
        _searchResultEmptyBuilder(),
      ];
    }

    return [
      SliverPadding(
        padding: const EdgeInsets.symmetric(vertical: DimensSize.d16),
        sliver: SliverList.builder(
          itemCount: filteredItems.length,
          itemBuilder: (_, index) => _searchResultItemBuilder(
            filteredItems[index],
          ),
        ),
      ),
    ];
  }

  Widget _searchResultItemBuilder(BrowserBookmarkItem item) {
    return Padding(
      key: ValueKey(item.id),
      padding: const EdgeInsets.symmetric(
        vertical: DimensSize.d4,
        horizontal: DimensSize.d16,
      ),
      child: SeparatedRow(
        children: [
          Expanded(
            child: ShapedContainerColumn(
              mainAxisSize: MainAxisSize.min,
              margin: EdgeInsets.zero,
              children: [
                CommonListTile(
                  titleText: item.title,
                  subtitleText: item.url.toString(),
                  leading: CachedNetworkImage(
                    height: DimensSize.d40,
                    width: DimensSize.d40,
                    imageUrl: item.faviconUrl ?? '',
                    placeholder: (_, __) =>
                        const CommonCircularProgressIndicator(),
                    errorWidget: (_, __, ___) => CommonIconWidget.svg(
                      svg: Assets.images.web.path,
                    ),
                  ),
                  trailing: CommonButtonIconWidget.svg(
                    svg: Assets.images.caretRight.path,
                  ),
                  onPressed: () => _onItemPressed(item),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchResultEmptyBuilder() {
    return SliverFillRemaining(
      child: Center(
        child: SeparatedColumn(
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonIconWidget.svg(
              svg: Assets.images.searchEmpty.path,
              size: DimensSize.d56,
            ),
            Text(
              LocaleKeys.browserStartEmptySearch.tr(),
              style: StyleRes.primaryRegular.copyWith(
                color: context.themeStyle.colors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _sectionBuilder({
    required String title,
    required List<BrowserBookmarkItem> items,
    String? buttonText,
    VoidCallback? buttonOnPressed,
  }) {
    if (items.isEmpty) {
      return [];
    }

    final sortedLimitedItems = items.take(_itemCountLimit).toList();

    final buttonEnabled = items.length > _itemCountLimit;

    return [
      _sectionHeaderBuilder(
        title: title,
        buttonText: buttonEnabled ? buttonText : null,
        buttonOnPressed: buttonOnPressed,
      ),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
        sliver: SliverGrid.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: DimensSize.d8,
            crossAxisSpacing: DimensSize.d8,
            mainAxisExtent: DimensSize.d92,
          ),
          itemBuilder: (_, index) => _itemBuilder(
            sortedLimitedItems[index],
          ),
          itemCount: sortedLimitedItems.length,
        ),
      ),
    ];
  }

  Widget _sectionHeaderBuilder({
    required String title,
    String? buttonText,
    VoidCallback? buttonOnPressed,
  }) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          left: DimensSize.d16,
          top: DimensSize.d8,
          bottom: DimensSize.d8,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: StyleRes.primaryBold,
              ),
            ),
            if (buttonText != null)
              SmallButton.ghost(
                text: buttonText,
                onPressed: buttonOnPressed,
              ),
          ],
        ),
      ),
    );
  }

  Widget _itemBuilder(BrowserBookmarkItem item) {
    return SeparatedRow(
      key: ValueKey(item.id),
      children: [
        Expanded(
          child: ShapedContainerColumn(
            mainAxisSize: MainAxisSize.min,
            margin: EdgeInsets.zero,
            children: [
              CommonListTile(
                titleText: item.title,
                subtitleText: item.url.toString(),
                leading: CachedNetworkImage(
                  height: DimensSize.d40,
                  width: DimensSize.d40,
                  imageUrl: item.faviconUrl ?? '',
                  placeholder: (_, __) =>
                      const CommonCircularProgressIndicator(),
                  errorWidget: (_, __, ___) => CommonIconWidget.svg(
                    svg: Assets.images.web.path,
                  ),
                ),
                onPressed: () => _onItemPressed(item),
                onLongPressed: () => _onItemLongPressed(item),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _onItemPressed(BrowserBookmarkItem item) {
    _openUrl(item.url);
  }

  void _onItemLongPressed(BrowserBookmarkItem item) {
    if (item.id.isEmpty) {
      // This is a predefined item, so we can't remove it.
      return;
    }

    showBrowserBookmarkSheet(
      context: context,
      item: item,
    );
  }

  void _onSeeAllPressed() {
    context.goNamed(AppRoute.browserBookmarks.name);
  }

  List<Widget> _cardsBuilder() {
    return [
      SliverPadding(
        padding: const EdgeInsets.only(
          top: DimensSize.d32,
        ),
        sliver: SliverToBoxAdapter(
          child: SizedBox(
            height: _cardHeight,
            child: PageView.builder(
              controller: _cardController,
              itemBuilder: (_, index) =>
                  _cardItemBuilder(_predefinedCards[index]),
              itemCount: _predefinedCards.length,
            ),
          ),
        ),
      ),
    ];
  }

  Widget _cardItemBuilder(BrowserCard card) {
    final colors = context.themeStyle.colors;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: DimensSize.d8,
      ),
      child: InkWell(
        onTap: () => _onCardPressed(card),
        child: ShapedContainerRow(
          color: colors.blue,
          mainAxisSize: MainAxisSize.min,
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: DimensSize.d16,
                  vertical: DimensSize.d20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      card.title,
                      style: StyleRes.primaryBold.copyWith(
                        color: colors.textContrast,
                      ),
                    ),
                    Text(
                      card.description,
                      style: StyleRes.addRegular.copyWith(
                        color: colors.textContrast,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CommonIconWidget.svg(
              svg: card.imagePath,
            ),
          ],
        ),
      ),
    );
  }

  void _onCardPressed(BrowserCard card) {
    _openUrl(card.url);
  }

  void _openUrl(Uri url) {
    final currentTabId = context.read<BrowserTabsBloc>().activeTab?.id;
    if (currentTabId == null) {
      context.read<BrowserTabsBloc>().add(
            BrowserTabsEvent.add(uri: url),
          );

      return;
    }
    context.read<BrowserTabsBloc>().add(
          BrowserTabsEvent.setUrl(id: currentTabId, uri: url),
        );
  }
}
