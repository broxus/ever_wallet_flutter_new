import 'package:app/app/router/router.dart';
import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:app/feature/browser/widgets/browser_resource_Item.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

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

    _searchController.clear();
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
    final isEditing = context.watch<BrowserHistoryBloc>().state.isEditing;
    final items = context.watch<BrowserHistoryBloc>().getFilteredItems();
    final isHistoryEmpty = context.watch<BrowserHistoryBloc>().isHistoryEmpty;
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
            if (!isHistoryEmpty)
              SliverPersistentHeader(
                floating: true,
                delegate: SearchBarHeaderDelegate(
                  controller: _searchController,
                ),
              ),
            ...widgets,
            _bottomSpacerBuilder(isEditing),
          ],
          controller: _scrollController,
        ),
        _buttonsBuilder(isEditing),
      ],
    );
  }

  Widget _headerBuilder(DateTime dateTime) {
    final localeCode = inject<LocalizationService>().localeCode.name;

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: DimensSizeV2.d12,
          left: DimensSize.d16,
          right: DimensSize.d16,
        ),
        child: Text(
          // TODO(knightforce): performance
          DateFormat.yMMMMEEEEd(localeCode).format(dateTime),
          style: context.themeStyleV2.textStyles.headingSmall,
        ),
      ),
    );
  }

  Widget _itemBuilder(BrowserHistoryItem item, {required bool isEditing}) {
    final colors = context.themeStyle.colors;
    final faviconUrl =
        context.watch<BrowserFaviconsBloc>().getFaviconUrl(item.url) ?? '';

    return Padding(
      key: ValueKey(item.id),
      padding: const EdgeInsets.only(
        bottom: DimensSizeV2.d8,
        left: DimensSize.d16,
        right: DimensSize.d16,
      ),
      child: Row(
        children: [
          Expanded(
            child: BrowserResourceItem(
              key: ValueKey(item.id),
              faviconUrl: faviconUrl,
              title: item.title,
              subTitle: item.url.toString(),
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
              onPressed: () => _onItemPressed(item),
            ),
          ),
          if (isEditing)
            Padding(
              padding: const EdgeInsets.only(left: DimensSizeV2.d4),
              child: GhostButton(
                buttonShape: ButtonShape.circle,
                icon: LucideIcons.trash2,
                onPressed: () => _removeHistoryItem(item),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buttonsBuilder(bool isEditing) {
    final isHistoryEmpty = context.watch<BrowserHistoryBloc>().isHistoryEmpty;

    return Container(
      decoration: BoxDecoration(
        color: context.themeStyleV2.colors.background0,
      ),
      padding: const EdgeInsets.only(
        top: DimensSizeV2.d12,
        bottom: DimensSizeV2.d50,
        left: DimensSizeV2.d16,
        right: DimensSizeV2.d16,
      ),
      child: isEditing
          ? Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DestructiveButton(
                  buttonShape: ButtonShape.pill,
                  title: LocaleKeys.browserHistoryClear.tr(),
                  onPressed: () {
                    showBrowserHistorySheet(
                      context: context,
                      clearHistoryEnabled: !isHistoryEmpty,
                      onClearPressed: _onClearPressed,
                    );
                  },
                ),
                const SizedBox(height: DimensSizeV2.d8),
                PrimaryButton(
                  buttonShape: ButtonShape.pill,
                  title: LocaleKeys.browserHistoryDone.tr(),
                  onPressed: () => _setIsEditing(false),
                ),
              ],
            )
          : PrimaryButton(
              buttonShape: ButtonShape.pill,
              title: LocaleKeys.browserHistoryEdit.tr(),
              onPressed: () => _setIsEditing(true),
            ),
    );
  }

  Widget _bottomSpacerBuilder(bool isEditing) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: isEditing ? DimensSizeV2.d190 : DimensSizeV2.d128,
      ),
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
