import 'dart:io';
import 'dart:ui' as ui;

import 'package:app/app/router/router.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:app/feature/browser/browser_tabs_view/predefined_items.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Item count limit for each section
const _itemCountLimit = 6;

/// Card height
const _cardHeight = 116.0;

/// Card viewport fraction
const _cardViewportFraction = 0.85;

/// How often we can take screenshot
const Duration _screenShotPeriodDuration = Duration(seconds: 5);

class BrowserStartView extends StatefulWidget {
  const BrowserStartView({super.key});

  @override
  State<BrowserStartView> createState() => _BrowserStartViewState();
}

class _BrowserStartViewState extends State<BrowserStartView> {
  final _predefinedItems = predefinedItems();
  final _predefinedCards = predefinedCards();
  final _cardController = PageController(
    viewportFraction: _cardViewportFraction,
  );
  final _globalKey = GlobalKey();
  DateTime? _lastScreenshotTime;

  ThemeStyleV2 get _themeStyleV2 => context.themeStyleV2;

  @override
  void dispose() {
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = _themeStyleV2.colors;
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
        color: colors.background0,
        child: CustomScrollView(
          slivers: [
            ...slivers,
            const SliverToBoxAdapter(
              child: _KeyboardPadding(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveScreenshot() async {
    final now = NtpTime.now();
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
      } catch (_) {}
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
        padding: const EdgeInsets.symmetric(vertical: DimensSize.d20),
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
      padding: const EdgeInsets.only(
        bottom: DimensSizeV2.d8,
        left: DimensSizeV2.d16,
        right: DimensSizeV2.d16,
      ),
      child: _ResourceItem(
        onPressed: () => _onItemPressed(item),
        title: item.title,
        url: item.url,
        trailing: SvgPicture.asset(
          Assets.images.caretRight.path,
          width: DimensSizeV2.d20,
          height: DimensSizeV2.d20,
          colorFilter: context.themeStyleV2.colors.content0.colorFilter,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: DimensSizeV2.d8,
          horizontal: DimensSizeV2.d16,
        ),
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
            mainAxisExtent: DimensSize.d56,
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
    final textStyles = _themeStyleV2.textStyles;

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          left: DimensSize.d16,
          top: DimensSize.d24,
          bottom: DimensSize.d20,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: textStyles.headingLarge,
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
    return _ResourceItem(
      key: ValueKey(item.id),
      onPressed: () => _onItemPressed(item),
      onLongPress: () => _onItemLongPressed(item),
      title: item.title,
      url: item.url,
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
              padEnds: false,
              controller: _cardController,
              itemBuilder: (_, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? DimensSizeV2.d16 : 0,
                    right: DimensSizeV2.d12,
                  ),
                  child: _cardItemBuilder(_predefinedCards[index]),
                );
              },
              itemCount: _predefinedCards.length,
            ),
          ),
        ),
      ),
    ];
  }

  Widget _cardItemBuilder(BrowserCard card) {
    final colors = _themeStyleV2.colors;
    final textStyles = _themeStyleV2.textStyles;

    return InkWell(
      onTap: () => _onCardPressed(card),
      child: ShapedContainerRow(
        color: colors.backgroundAccent,
        mainAxisSize: MainAxisSize.min,
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: DimensSize.d20,
                bottom: DimensSize.d20,
                left: DimensSize.d16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    card.title,
                    style: textStyles.labelMedium.copyWith(
                      height: 24 / 16,
                    ),
                  ),
                  Text(
                    card.description,
                    style: textStyles.labelXSmall.copyWith(
                      height: 15.6 / 12,
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

class _KeyboardPadding extends StatelessWidget {
  const _KeyboardPadding();

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets,
      duration: const Duration(milliseconds: 250),
    );
  }
}

class _ResourceItem extends StatelessWidget {
  const _ResourceItem({
    required this.title,
    required this.url,
    required this.onPressed,
    this.onLongPress,
    this.trailing,
    this.padding,
    super.key,
  });

  final String title;
  final Uri url;
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final Widget? trailing;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final faviconUrl =
        context.watch<BrowserFaviconsBloc>().getFaviconUrl(url) ?? '';

    final themeStyleV2 = context.themeStyleV2;

    return PressScaleWidget(
      onPressed: onPressed,
      onLongPress: onLongPress,
      child: Container(
        decoration: BoxDecoration(
          color: themeStyleV2.colors.background1,
          borderRadius: BorderRadius.circular(DimensSizeV2.d12),
        ),
        padding: padding ?? const EdgeInsets.all(DimensSizeV2.d8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CachedNetworkImage(
                    height: DimensSize.d40,
                    width: DimensSize.d40,
                    imageUrl: faviconUrl,
                    placeholder: (_, __) =>
                        const CommonCircularProgressIndicator(),
                    errorWidget: (_, __, ___) => CommonIconWidget.svg(
                      svg: Assets.images.web.path,
                    ),
                  ),
                  const SizedBox(width: DimensSizeV2.d8),
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: themeStyleV2.textStyles.labelSmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: DimensSizeV2.d2),
                        // TODO(knightforce): Bad practice transform in build
                        Text(
                          url.toString(),
                          style: themeStyleV2.textStyles.labelXSmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
