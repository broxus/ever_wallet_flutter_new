import 'package:app/app/router/router.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:app/generated/generated.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
  @override
  Widget build(BuildContext context) {
    final items = context.watch<BrowserHistoryBloc>().state.items;
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          floating: true,
          delegate: SearchBarHeaderDelegate(),
        ),
        SliverList.builder(
          itemCount: items.length,
          itemBuilder: (_, index) => _itemBuilder(items[index]),
        ),
      ],
    );
  }

  Widget? _itemBuilder(BrowserHistoryItem item) {
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

  void _onItemPressed(BrowserHistoryItem item) {
    final uri = Uri.parse(item.url);

    context.read<BrowserTabsBloc>().add(
          BrowserTabsEvent.add(uri: uri),
        );

    context.goNamed(AppRoute.browser.name);
  }
}
