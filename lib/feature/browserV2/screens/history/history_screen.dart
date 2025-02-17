import 'package:app/feature/browser/widgets/buttons_edit_section.dart';
import 'package:app/feature/browserV2/screens/history/history_screen_wm.dart';
import 'package:app/feature/browserV2/screens/history/ui_models/history_ui_model.dart';
import 'package:app/feature/browserV2/screens/history/widgets/date_item.dart';
import 'package:app/feature/browserV2/screens/history/widgets/empty_content.dart';
import 'package:app/feature/browserV2/screens/history/widgets/history_item.dart';
import 'package:app/feature/browserV2/screens/history/widgets/search_bar_header_delegate.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/focus_utils.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

// Сверить с historyView

class HistoryScreen extends ElementaryWidget<HistoryScreenWidgetModel> {
  const HistoryScreen({
    Key? key,
    WidgetModelFactory<HistoryScreenWidgetModel> wmFactory =
        defaultHistoryScreenWidgetModelFactory,
  }) : super(
          wmFactory,
          key: key,
        );

  @override
  Widget build(HistoryScreenWidgetModel wm) {
    return Scaffold(
      appBar: DefaultAppBar(
        titleText: LocaleKeys.browserHistory.tr(),
      ),
      body: GestureDetector(
        onTap: resetFocus,
        child: DoubleSourceBuilder<bool, List<HistoryUiModel>?>(
          firstSource: wm.editState,
          secondSource: wm.itemsUiState,
          builder: (_, bool? isEditing, List<HistoryUiModel>? items) {
            final isEmptyResult = items?.isEmpty ?? false;
            isEditing = isEditing ?? false;
            return Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                CustomScrollView(
                  controller: wm.scrollController,
                  slivers: [
                    if (!wm.isShowHeader)
                      SliverPersistentHeader(
                        floating: true,
                        delegate: SearchBarHeaderDelegate(
                          controller: wm.searchController,
                        ),
                      ),
                    if (!isEmptyResult)
                      SliverList.builder(
                        itemCount: items!.length,
                        itemBuilder: (_, int index) {
                          return switch (items[index]) {
                            DateUiModel(:final dateText) => DateItem(
                                key: ValueKey(dateText),
                                dateText: dateText,
                              ),
                            ItemUiModel(
                              :final String id,
                              :final Uri url,
                              :final String title,
                              :final String subTitleText,
                            ) =>
                              HistoryItem(
                                key: ValueKey(id),
                                id: id,
                                url: url,
                                title: title,
                                subTitleText: subTitleText,
                                isEditing: isEditing ?? false,
                                onPressed: () => wm.onPressedItem(url),
                                onPressedPostfix: () =>
                                    wm.removeHistoryItem(id),
                              ),
                          };
                        },
                      ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height:
                            isEditing ? DimensSizeV2.d190 : DimensSizeV2.d128,
                      ),
                    ),
                  ],
                ),
                if (wm.isShowEmptyUi)
                  Positioned.fill(
                    child: wm.isSearch
                        ? const EmptyContent.search()
                        : const EmptyContent.history(),
                  ),
                ButtonsEditSection(
                  isEditing: isEditing,
                  editText: LocaleKeys.browserHistoryEdit.tr(),
                  clearText: LocaleKeys.browserHistoryClear.tr(),
                  doneText: LocaleKeys.browserHistoryDone.tr(),
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
}
