import 'package:app/data/models/browser_bookmark_item.dart';
import 'package:app/feature/browser/widgets/browser_resource_section.dart';
import 'package:app/feature/browser/widgets/buttons_edit_section.dart';
import 'package:app/feature/browserV2/screens/bookmarks/bookmarks_screen_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/focus_utils.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class BookmarksScreen extends ElementaryWidget<BookmarksScreenWidgetModel> {
  const BookmarksScreen({
    Key? key,
    WidgetModelFactory<BookmarksScreenWidgetModel> wmFactory =
        defaultBookmarksScreenWidgetModelFactory,
  }) : super(
          wmFactory,
          key: key,
        );

  @override
  Widget build(BookmarksScreenWidgetModel wm) {
    return Scaffold(
      appBar: DefaultAppBar(
        titleText: LocaleKeys.browserBookmarks.tr(),
      ),
      body: GestureDetector(
        onTap: resetFocus,
        child: TripleSourceBuilder(
          firstSource: wm.topDividerState,
          secondSource: wm.editState,
          thirdSource: wm.itemsState,
          builder: (
            _,
            bool? isShowDivider,
            bool? isEditing,
            List<BrowserBookmarkItem>? items,
          ) {
            if (items == null) {
              return const SizedBox.shrink();
            }

            return Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                CustomScrollView(
                  slivers: [
                    if (isShowDivider ?? false)
                      SliverPersistentHeader(
                        key: wm.listKey,
                        pinned: true,
                        delegate: CommonSliverDividerHeaderDelegate(
                          color: wm.colors.strokePrimary,
                        ),
                      ),
                    SliverReorderableList(
                      itemBuilder: (_, index) => _itemBuilder(
                        items[index],
                        index: index,
                        isEditing: isEditing ?? false,
                        theme: wm.themeStyleV2,
                        removeBookmark: wm.removeBookmark,
                        onPressed: wm.onBookmarkPressed,
                      ),
                      itemCount: items.length,
                      onReorder: wm.onReorder,
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: isEditing ?? false
                            ? DimensSizeV2.d190
                            : DimensSizeV2.d128,
                      ),
                    ),
                  ],
                  controller: wm.scrollController,
                ),
                ButtonsEditSection(
                  isEditing: isEditing ?? false,
                  editText: LocaleKeys.browserBookmarksEdit.tr(),
                  clearText: LocaleKeys.browserBookmarksClear.tr(),
                  doneText: LocaleKeys.browserBookmarksDone.tr(),
                  onPressedEdit: wm.onPressedEdit,
                  onPressedClear: wm.onPressedClear,
                  onPressedDone: wm.onPressedDone,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // ignore: long-method
  Widget _itemBuilder(
    BrowserBookmarkItem item, {
    required int index,
    required bool isEditing,
    required ThemeStyleV2 theme,
    required ValueChanged<BrowserBookmarkItem> removeBookmark,
    required ValueChanged<BrowserBookmarkItem> onPressed,
  }) {
    final colors = theme.colors;

    // TODO favicon
    // final faviconUrl =
    //     context.watch<BrowserFaviconsBloc>().getFaviconUrl(item.url) ?? '';

    return BrowserResourceSection(
      key: ValueKey(item.id),
      faviconUrl: '',
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
                onPressed: () => removeBookmark(item),
              ),
            )
          : null,
      onPressed: () => onPressed(item),
    );
  }
}
