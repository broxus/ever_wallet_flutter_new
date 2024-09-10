import 'package:app/app/router/router.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:app/feature/browser/widgets/browser_resource_section.dart';
import 'package:app/feature/browser/widgets/buttons_edit_section.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class BookmarksView extends StatefulWidget {
  const BookmarksView({super.key});

  @override
  State<BookmarksView> createState() => _BookmarksViewState();
}

class _BookmarksViewState extends State<BookmarksView> {
  final GlobalKey<SliverReorderableListState> _listKey =
      GlobalKey<SliverReorderableListState>();
  final _scrollController = ScrollController();
  bool _showTopDivider = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(
      () {
        final showTopDivider = _scrollController.position.pixels > 0;
        if (showTopDivider != _showTopDivider) {
          setState(() {
            _showTopDivider = showTopDivider;
          });
        }
      },
    );

    _setIsEditing(false);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    final isEditing = context.watch<BrowserBookmarksBloc>().state.isEditing;
    final items = context.watch<BrowserBookmarksBloc>().getSortedItems();

    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        CustomScrollView(
          slivers: [
            if (_showTopDivider)
              SliverPersistentHeader(
                key: _listKey,
                pinned: true,
                delegate: CommonSliverDividerHeaderDelegate(
                  color: colors.strokePrimary,
                ),
              ),
            SliverReorderableList(
              itemBuilder: (_, index) => _itemBuilder(
                items[index],
                index: index,
                isEditing: isEditing,
              ),
              itemCount: items.length,
              onReorder: _onReorder,
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: isEditing ? DimensSizeV2.d190 : DimensSizeV2.d128,
              ),
            ),
          ],
          controller: _scrollController,
        ),
        ButtonsEditSection(
          isEditing: isEditing,
          editText: LocaleKeys.browserBookmarksEdit.tr(),
          clearText: LocaleKeys.browserBookmarksClear.tr(),
          doneText: LocaleKeys.browserBookmarksDone.tr(),
          onPressedEdit: () => _setIsEditing(true),
          onPressedClear: _onClearPressed,
          onPressedDone: () => _setIsEditing(false),
        ),
      ],
    );
  }

  // ignore: long-method
  Widget _itemBuilder(
    BrowserBookmarkItem item, {
    required int index,
    required bool isEditing,
  }) {
    final colors = context.themeStyleV2.colors;

    final faviconUrl =
        context.watch<BrowserFaviconsBloc>().getFaviconUrl(item.url) ?? '';

    return BrowserResourceSection(
      key: ValueKey(item.id),
      faviconUrl: faviconUrl,
      titleText: item.title,
      subTitleText: item.url.toString(),
      padding: const EdgeInsets.only(
        top: DimensSizeV2.d8,
        bottom: DimensSizeV2.d8,
        left: DimensSizeV2.d16,
      ),
      trailing: ReorderableDragStartListener(
        index: index,
        enabled: isEditing,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DimensSizeV2.d16,
          ),
          child: SvgPicture.asset(
            isEditing
                ? Assets.images.burger.path
                : Assets.images.caretRight.path,
            width: DimensSizeV2.d20,
            height: DimensSizeV2.d20,
            colorFilter: isEditing
                ? colors.content3.colorFilter
                : colors.content0.colorFilter,
            //
          ),
        ),
      ),
      postfix: isEditing
          ? Padding(
              padding: const EdgeInsets.only(left: DimensSizeV2.d4),
              child: GhostButton(
                buttonShape: ButtonShape.circle,
                icon: LucideIcons.trash2,
                onPressed: () => _removeBookmarkItem(item),
              ),
            )
          : null,
      onPressed: () => _onItemPressed(item),
    );
  }

  void _setIsEditing(bool value) {
    context.read<BrowserBookmarksBloc>().add(
          BrowserBookmarksEvent.setIsEditing(
            value: value,
          ),
        );
  }

  void _onClearPressed() {
    _setIsEditing(false);
    context
        .read<BrowserBookmarksBloc>()
        .add(const BrowserBookmarksEvent.clear());
    context.goNamed(AppRoute.browser.name);
  }

  void _onItemPressed(BrowserBookmarkItem item) {
    final uri = item.url;

    context.read<BrowserTabsBloc>().add(
          BrowserTabsEvent.add(uri: uri),
        );

    context.goNamed(AppRoute.browser.name);
  }

  void _removeBookmarkItem(BrowserBookmarkItem item) {
    context.read<BrowserBookmarksBloc>().add(
          BrowserBookmarksEvent.remove(
            id: item.id,
          ),
        );
  }

  void _onReorder(int oldIndex, int newIndex) {
    final items = context.read<BrowserBookmarksBloc>().getSortedItems();

    final item = items[oldIndex];

    final newPrevItem =
        newIndex > 0 ? items.elementAtOrNull(newIndex - 1) : null;
    final newPrevItemSO = newPrevItem?.sortingOrder;
    final newNextItem = items.elementAtOrNull(newIndex);
    final newNextItemSO = newNextItem?.sortingOrder;

    final newItemSO = switch ((newPrevItemSO, newNextItemSO)) {
      (null, null) => 0.0,
      (null, final double next) => next + 1,
      (final double prev, final double next) => (next - prev) / 2 + prev,
      (final double prev, null) => prev - 1,
    };

    final newItem = item.copyWith(
      sortingOrder: newItemSO,
    );

    context.read<BrowserBookmarksBloc>().add(
          BrowserBookmarksEvent.setItem(
            item: newItem,
          ),
        );
  }
}
