import 'package:app/app/router/router.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:app/feature/browser/browser_tabs_view/predefined_items.dart';
import 'package:app/generated/generated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class BrowserStartView extends StatefulWidget {
  const BrowserStartView({super.key});

  @override
  State<BrowserStartView> createState() => _BrowserStartViewState();
}

class _BrowserStartViewState extends State<BrowserStartView> {
  final _predefinedItems = predefinedItems();

  @override
  Widget build(BuildContext context) {
    final bookmarkItems = context.watch<BrowserBookmarksBloc>().state.items;
    final colors = context.themeStyle.colors;

    return ColoredBox(
      color: colors.appBackground,
      child: CustomScrollView(
        slivers: [
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
        ],
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
    return [
      _sectionHeaderBuilder(
        title: title,
        buttonText: buttonText,
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
            items[index],
          ),
          itemCount: items.length,
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
    final colors = context.themeStyle.colors;

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
                subtitleText: item.url,
                leading: CachedNetworkImage(
                  height: DimensSize.d40,
                  width: DimensSize.d40,
                  imageUrl: item.faviconUrl ?? '',
                  placeholder: (_, __) => CircularProgressIndicator(
                    color: colors.textSecondary,
                    strokeWidth: DimensStroke.medium,
                  ),
                  // TODO(nesquikm): what we should show when
                  // no favicon is available?
                  errorWidget: (_, __, ___) => const Icon(Icons.error),
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
    final uri = Uri.parse(item.url);

    context.read<BrowserTabsBloc>().add(
          BrowserTabsEvent.add(uri: uri),
        );

    context.goNamed(AppRoute.browser.name);
  }

  void _onItemLongPressed(BrowserBookmarkItem item) {
    if (item.id.isEmpty) {
      // This is a predefined item, so we can't remove it.
      return;
    }
  }

  void _onSeeAllPressed() {}
}
