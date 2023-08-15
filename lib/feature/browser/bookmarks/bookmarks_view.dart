import 'package:app/app/router/router.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:app/generated/generated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

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
            _bottomSpacerBuilder(),
          ],
          controller: _scrollController,
        ),
        _buttonsBuilder(),
      ],
    );
  }

  Widget _itemBuilder(
    BrowserBookmarkItem item, {
    required int index,
    required bool isEditing,
  }) {
    final colors = context.themeStyle.colors;

    final trailing = isEditing
        ? ReorderableDragStartListener(
            index: index,
            child: CommonButtonIconWidget.svg(
              svg: Assets.images.burger.path,
            ),
          )
        : CommonButtonIconWidget.svg(
            svg: Assets.images.caretRight.path,
          );

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
                    placeholder: (_, __) => CircularProgressIndicator(
                      color: colors.textSecondary,
                      strokeWidth: DimensStroke.medium,
                    ),
                    // TODO(nesquikm): what we should show when
                    // no favicon is available?
                    errorWidget: (_, __, ___) => const Icon(Icons.error),
                  ),
                  trailing: trailing,
                  onPressed: () => _onItemPressed(item),
                ),
              ],
            ),
          ),
          if (isEditing)
            CommonIconButton.svg(
              svg: Assets.images.trash.path,
              buttonType: EverButtonType.secondary,
              color: colors.alert,
              onPressed: () => _removeBookmarkItem(item),
            ),
        ],
      ),
    );
  }

  Widget _buttonsBuilder() {
    final colors = context.themeStyle.colors;

    final isEditing = context.watch<BrowserBookmarksBloc>().state.isEditing;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: colors.gradient,
        ),
      ),
      child: SafeArea(
        minimum: const EdgeInsets.all(DimensSize.d16),
        child: SeparatedColumn(
          mainAxisSize: MainAxisSize.min,
          children: isEditing
              ? [
                  CommonButton.secondary(
                    text: LocaleKeys.browserBookmarksClear.tr(),
                    onPressed: _onClearPressed,
                    fillWidth: true,
                  ),
                  CommonButton.primary(
                    text: LocaleKeys.browserBookmarksDone.tr(),
                    onPressed: () => _setIsEditing(false),
                    fillWidth: true,
                  ),
                ]
              : [
                  CommonButton.primary(
                    text: LocaleKeys.browserBookmarksEdit.tr(),
                    onPressed: () => _setIsEditing(true),
                    fillWidth: true,
                  ),
                ],
        ),
      ),
    );
  }

  Widget _bottomSpacerBuilder() {
    final isEditing = context.watch<BrowserBookmarksBloc>().state.isEditing;

    return SliverSafeArea(
      sliver: SliverToBoxAdapter(
        child: SizedBox(
          height: isEditing
              ? DimensSize.d56 + DimensSize.d56 + DimensSize.d16
              : DimensSize.d56 + DimensSize.d16,
        ),
      ),
      minimum: const EdgeInsets.only(bottom: DimensSize.d16),
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
