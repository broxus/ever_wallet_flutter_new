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
import 'package:go_router/go_router.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      context.read<BrowserHistoryBloc>().add(
            BrowserHistoryEvent.setSearchString(
              value: _searchController.text,
            ),
          );
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = context.watch<BrowserHistoryBloc>().getFiltredItems();
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
            itemBuilder: (_, index) => _itemBuilder(items[index]),
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
            ...widgets,
            _bottomSpacerBuilder(),
          ],
        ),
        SafeArea(
          minimum: const EdgeInsets.only(bottom: DimensSize.d16),
          child: _buttonsBuilder(),
        ),
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

  Widget _itemBuilder(BrowserHistoryItem item) {
    final colors = context.themeStyle.colors;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: DimensSize.d4,
        horizontal: DimensSize.d16,
      ),
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
              // TODO(nesquikm): what we should show when no favicon is available?
              errorWidget: (_, __, ___) => const Icon(Icons.error),
            ),
            trailing: CommonButtonIconWidget.svg(
              svg: Assets.images.caretRight.path,
            ),
            onPressed: () => _onItemPressed(item),
          ),
        ],
      ),
    );
  }

  Widget _buttonsBuilder() {
    final isEditing = context.watch<BrowserHistoryBloc>().state.isEditing;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
      child: SeparatedColumn(
        mainAxisSize: MainAxisSize.min,
        children: isEditing
            ? [
                CommonButton.secondary(
                  text: LocaleKeys.browserHistoryClear.tr(),
                  onPressed: () => {},
                  fillWidth: true,
                ),
                CommonButton.primary(
                  text: LocaleKeys.browserHistoryDone.tr(),
                  onPressed: () => context.read<BrowserHistoryBloc>().add(
                        const BrowserHistoryEvent.setIsEditing(
                          value: false,
                        ),
                      ),
                  fillWidth: true,
                ),
              ]
            : [
                CommonButton.primary(
                  text: LocaleKeys.browserHistoryEdit.tr(),
                  onPressed: () => context.read<BrowserHistoryBloc>().add(
                        const BrowserHistoryEvent.setIsEditing(
                          value: true,
                        ),
                      ),
                  fillWidth: true,
                ),
              ],
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
    final uri = Uri.parse(item.url);

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
            )
          ],
        ),
      ),
    );
  }
}
