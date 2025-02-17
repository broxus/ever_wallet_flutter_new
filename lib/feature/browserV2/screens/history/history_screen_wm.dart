import 'dart:async';
import 'dart:collection';

import 'package:app/app/router/app_route.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/browser_history_item.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser/bottom_sheets/browser_history_bottom_sheet.dart';
import 'package:app/feature/browserV2/screens/history/history_screen.dart';
import 'package:app/feature/browserV2/screens/history/history_screen_model.dart';
import 'package:app/feature/browserV2/screens/history/ui_models/history_ui_model.dart';
import 'package:app/utils/common_utils.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';

/// Factory method for creating [HistoryScreenWidgetModel]
HistoryScreenWidgetModel defaultHistoryScreenWidgetModelFactory(
  BuildContext context,
) {
  return HistoryScreenWidgetModel(
    HistoryScreenModel(
      createPrimaryErrorHandler(context),
      inject(),
      inject(),
    ),
  );
}

/// [WidgetModel] для [HistoryScreen]
class HistoryScreenWidgetModel
    extends CustomWidgetModel<HistoryScreen, HistoryScreenModel> {
  HistoryScreenWidgetModel(
    super.model,
  );

  late final searchController = createTextEditingController()
    ..addListener(_filter);

  late final scrollController = createScrollController()
    ..addListener(_handleScroll);

  late final _topDividerState = createNotifier<bool>(false);
  late final _editState = createNotifier<bool>(false);
  late final _filteredHistoryItemsState =
      createNotifier<List<BrowserHistoryItem>?>();
  late final _itemsUiState = createNotifier<List<HistoryUiModel>?>();

  final _dateFormatCache = HashMap<DateTime, String>();

  StreamSubscription<List<BrowserHistoryItem>>? _historySubs;

  ListenableState<bool> get topDividerState => _topDividerState;

  ListenableState<bool> get editState => _editState;

  ListenableState<List<HistoryUiModel>?> get itemsUiState => _itemsUiState;

  bool get isSearch => searchController.text.isNotEmpty;

  bool get isShowHeader => model.originalBrowserHistoryItems.isEmpty;

  bool get isShowEmptyUi => model.originalBrowserHistoryItems.isEmpty;

  bool get _isEmpty => _itemsUiState.value?.isEmpty ?? false;

  @override
  void initWidgetModel() {
    _filter();
    _historySubs = model.originalBrowserHistoryStream.listen((_) => _filter());
    _filteredHistoryItemsState.addListener(_mapToUiModels);
    super.initWidgetModel();
  }

  @override
  void dispose() {
    _dateFormatCache.clear();
    _historySubs?.cancel();
    super.dispose();
  }

  void onPressedItem(Uri uri) {
    // TODO handle tabs
    // context.read<BrowserTabsBloc>().add(
    //   BrowserTabsEvent.add(uri: uri),
    // );

    context.goNamed(AppRoute.browser.name);
  }

  void removeHistoryItem(String id) {
    model.removeHistoryItem(id);
  }

  void clearHistory() {
    model.clearHistory();
    context.goNamed(AppRoute.browser.name);
  }

  void onPressedEdit() {
    _editState.accept(true);
  }

  void onPressedDone() {
    _editState.accept(false);
  }

  void onPressedClear() {
    showBrowserHistorySheet(
      context: context,
      clearHistoryEnabled: !_isEmpty,
      onClearPressed: _onClearPressed,
    );
  }

  void _handleScroll() {
    _topDividerState.accept(scrollController.position.pixels > 0);
  }

  void _filter() {
    final text = searchController.text;

    final items = [...model.originalBrowserHistoryItems];

    if (text.isEmpty) {
      _filteredHistoryItemsState.accept(items);
      return;
    }

    final searchString = searchController.text.toLowerCase();

    _filteredHistoryItemsState.accept(
      [
        for (final item in items)
          if (item.title.toLowerCase().contains(searchString) ||
              item.url.toString().toLowerCase().contains(searchString))
            item,
      ],
    );
  }

  void _mapToUiModels() {
    final items = [...?_filteredHistoryItemsState.value];

    if (items.isEmpty) {
      _itemsUiState.accept([]);
      return;
    }

    final result = <HistoryUiModel>[];

    final sortedItems = items.sorted(
      (a, b) => a.visitTime.compareTo(b.visitTime),
    );

    BrowserHistoryItem? prevItem;

    final count = sortedItems.length;

    for (var i = count - 1; i >= 0; i--) {
      final item = items[i];
      final visitTime = item.visitTime;

      if (prevItem == null || !prevItem.visitTime.isSameDay(visitTime)) {
        final date = _dateFormatCache[visitTime] ??=
            DateFormat.yMMMMEEEEd(model.localeCode).format(visitTime);
        result.add(DateUiModel(date));
      }

      result.add(
        ItemUiModel(
          id: item.id,
          url: item.url,
          title: item.title,
        ),
      );

      prevItem = item;
    }

    _itemsUiState.accept(result);
  }

  void _onClearPressed({
    required bool clearCache,
    required bool clearCookies,
    required bool clearHistory,
  }) {
    _editState.accept(false);
    if (clearCache) _clearCache();
    if (clearCookies) CookieManager.instance().deleteAllCookies();
    if (clearHistory) _clearHistory();
  }

  void _clearCache() {
    // todo tabs
    // context.read<BrowserTabsBloc>().add(const BrowserTabsEvent.clearCache());
  }

  void _clearHistory() {
    model.clearHistory();
    context.goNamed(AppRoute.browser.name);
  }
}
