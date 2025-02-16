import 'package:app/app/router/app_route.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/browser_bookmark_item.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browserV2/screens/bookmarks/bookmarks_screen.dart';
import 'package:app/feature/browserV2/screens/bookmarks/bookmarks_screen_model.dart';
import 'package:app/feature/browserV2/widgets/bottomsheets/bookmarks_clear_bottom_sheet.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Factory method for creating [BookmarksScreenWidgetModel]
BookmarksScreenWidgetModel defaultBookmarksScreenWidgetModelFactory(
  BuildContext context,
) {
  return BookmarksScreenWidgetModel(
    BookmarksScreenModel(
      createPrimaryErrorHandler(context),
      inject(),
    ),
  );
}

/// [WidgetModel] для [BookmarksScreen]
class BookmarksScreenWidgetModel
    extends CustomWidgetModel<BookmarksScreen, BookmarksScreenModel> {
  BookmarksScreenWidgetModel(
    super.model,
  );

  late final _topDividerState = createNotifier<bool>(false);
  late final _editState = createNotifier<bool>(false);
  late final _itemsState = createNotifier<List<BrowserBookmarkItem>>(
    model.sortedBookmarks,
  );

  final listKey = GlobalKey<SliverReorderableListState>();

  late final scrollController = createScrollController()
    ..addListener(_handleScroll);

  ListenableState<bool> get topDividerState => _topDividerState;

  ListenableState<bool> get editState => _editState;

  ListenableState<List<BrowserBookmarkItem>> get itemsState => _itemsState;

  ThemeStyle get themeStyle => context.themeStyle;

  ThemeStyleV2 get themeStyleV2 => context.themeStyleV2;

  ColorsPalette get colors => themeStyle.colors;

  void onReorder(int oldIndex, int newIndex) {
    // final items = model.sortedBookmarks;
    final items = [...?_itemsState.value];

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

    model.setBookmark(
      item.copyWith(
        sortingOrder: newItemSO,
      ),
    );
  }

  void removeBookmark(BrowserBookmarkItem item) {
    model.removeBookmark(item.id);
  }

  void onBookmarkPressed(BrowserBookmarkItem item) {
    // final uri = item.url;

    // TODO open tab
    // context.read<BrowserTabsBloc>().add(
    //       BrowserTabsEvent.add(uri: uri),
    //     );

    context.goNamed(AppRoute.browser.name);
  }

  void onPressedEdit() => _editState.accept(true);

  void onPressedDone() => _editState.accept(false);

  void onPressedClear() {
    showBrowserClearBookmarksSheet(
      context: context,
      onClearPressed: _onClearPressed,
    );
  }

  void _onClearPressed() {
    _editState.accept(false);
    model.clearBookmarks();
    context.goNamed(AppRoute.browser.name);
  }

  void _handleScroll() {
    _topDividerState.accept(scrollController.position.pixels > 0);
  }
}
