import 'package:app/app/router/router.dart';
import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  bool _showTopDivider = false;

  @override
  void initState() {
    super.initState();

    _searchController.addListener(
      () {
        context.read<BrowserHistoryBloc>().add(
              BrowserHistoryEvent.setSearchString(
                value: _searchController.text,
              ),
            );
      },
    );

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
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    final isEditing = context.watch<BrowserHistoryBloc>().state.isEditing;
    final items = context.watch<BrowserHistoryBloc>().getFilteredItems();
    final sectioned = items.fold<Map<DateTime, List<BrowserHistoryItem>>>(
      {},
      (previousSectioned, item) {
        final key = previousSectioned.keys
            .firstWhereOrNull((e) => item.visitTime.isSameDay(e));
        if (key == null) {
          return {
            item.visitTime: [item],
            ...previousSectioned,
          };
        }

        final value = previousSectioned[key] ?? [];

        return {
          ...previousSectioned,
          key: [...value, item],
        };
      },
    );

    var widgets = sectioned.entries
        .sorted((a, b) => a.key.compareTo(b.key))
        .fold<List<Widget>>(
      [],
      (previousWidgets, entry) {
        final date = entry.key;
        final items = entry.value.sorted(
          (a, b) => b.visitTime.compareTo(
            a.visitTime,
          ),
        );

        return [
          _headerBuilder(date),
          SliverList.builder(
            itemCount: items.length,
            itemBuilder: (_, index) => _itemBuilder(
              items[index],
              isEditing: isEditing,
            ),
          ),
          ...previousWidgets,
        ];
      },
    );

    widgets = widgets.isNotEmpty ? widgets : [_emptyBuilder()];

    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              floating: true,
              delegate: SearchBarHeaderDelegate(controller: _searchController),
            ),
            if (_showTopDivider)
              SliverPersistentHeader(
                pinned: true,
                delegate: CommonSliverDividerHeaderDelegate(
                  color: colors.strokePrimary,
                ),
              ),
            ...widgets,
            _bottomSpacerBuilder(),
          ],
          controller: _scrollController,
        ),
        _buttonsBuilder(),
      ],
    );
  }

  Widget _headerBuilder(DateTime dateTime) {
    final localeCode = inject<LocalizationService>().localeCode.name;

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: DimensSize.d16,
          vertical: DimensSize.d8,
        ),
        child: Text(
          DateFormat.yMMMMEEEEd(localeCode).format(dateTime),
          style: StyleRes.primaryBold,
        ),
      ),
    );
  }

  Widget _itemBuilder(BrowserHistoryItem item, {required bool isEditing}) {
    final colors = context.themeStyle.colors;

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
          if (isEditing)
            CommonIconButton.svg(
              svg: Assets.images.trash.path,
              buttonType: EverButtonType.secondary,
              color: colors.alert,
              onPressed: () => _removeHistoryItem(item),
            ),
        ],
      ),
    );
  }

  Widget _buttonsBuilder() {
    final colors = context.themeStyle.colors;

    final isEditing = context.watch<BrowserHistoryBloc>().state.isEditing;
    final isHistoryEmpty = context.watch<BrowserHistoryBloc>().isHistoryEmpty;

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
                    text: LocaleKeys.browserHistoryClear.tr(),
                    onPressed: () {
                      showBrowserHistorySheet(
                        context: context,
                        clearHistoryEnabled: !isHistoryEmpty,
                        onClearPressed: _onClearPressed,
                      );
                    },
                    fillWidth: true,
                  ),
                  CommonButton.primary(
                    text: LocaleKeys.browserHistoryDone.tr(),
                    onPressed: () => _setIsEditing(false),
                    fillWidth: true,
                  ),
                ]
              : [
                  CommonButton.primary(
                    text: LocaleKeys.browserHistoryEdit.tr(),
                    onPressed: () => _setIsEditing(true),
                    fillWidth: true,
                  ),
                ],
        ),
      ),
    );
  }

  Widget _bottomSpacerBuilder() {
    final isEditing = context.watch<BrowserHistoryBloc>().state.isEditing;

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

  void _onItemPressed(BrowserHistoryItem item) {
    final uri = item.url;

    context.read<BrowserTabsBloc>().add(
          BrowserTabsEvent.add(uri: uri),
        );

    context.goNamed(AppRoute.browser.name);
  }

  Widget _emptyBuilder() {
    final isHistoryEmpty = context.watch<BrowserHistoryBloc>().isHistoryEmpty;

    return SliverFillRemaining(
      child: Center(
        child: SeparatedColumn(
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonIconWidget.svg(
              svg: isHistoryEmpty
                  ? Assets.images.history.path
                  : Assets.images.searchEmpty.path,
              size: DimensSize.d56,
            ),
            Text(
              isHistoryEmpty
                  ? LocaleKeys.browserHistoryEmpty.tr()
                  : LocaleKeys.browserHistoryEmptySearch.tr(),
              style: StyleRes.primaryRegular.copyWith(
                color: context.themeStyle.colors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onClearPressed({
    required bool clearCache,
    required bool clearCookies,
    required bool clearHistory,
  }) {
    _setIsEditing(false);
    if (clearCache) _clearCache();
    if (clearCookies) _clearCookies();
    if (clearHistory) _clearHistory();
  }

  void _clearCache() {
    context.read<BrowserTabsBloc>().add(const BrowserTabsEvent.clearCache());
  }

  void _clearCookies() {
    CookieManager.instance().deleteAllCookies();
  }

  void _clearHistory() {
    context.read<BrowserHistoryBloc>().add(const BrowserHistoryEvent.clear());
    context.goNamed(AppRoute.browser.name);
  }

  void _setIsEditing(bool value) {
    context.read<BrowserHistoryBloc>().add(
          BrowserHistoryEvent.setIsEditing(
            value: value,
          ),
        );
  }

  void _removeHistoryItem(BrowserHistoryItem item) {
    context.read<BrowserHistoryBloc>().add(
          BrowserHistoryEvent.remove(
            id: item.id,
          ),
        );
  }
}
