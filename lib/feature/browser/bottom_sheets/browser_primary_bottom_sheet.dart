import 'package:app/app/router/router.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/dimens_v2.dart';

/// Helper function to show [BrowserPrimarySheet].
Future<void> showBrowserPrimarySheet({
  required BuildContext context,
  required bool refreshEnabled,
  required bool addToBookmarksEnabled,
  required VoidCallback? onRefreshPressed,
  required VoidCallback? onAddToBookmarkPressed,
}) {
  return showCommonBottomSheet(
    context: context,
    body: (_, __) => BrowserPrimarySheet(
      refreshEnabled: refreshEnabled,
      addToBookmarksEnabled: addToBookmarksEnabled,
      onRefreshPressed: onRefreshPressed,
      onAddToBookmarkPressed: onAddToBookmarkPressed,
    ),
  );
}

class BrowserPrimarySheet extends StatelessWidget {
  const BrowserPrimarySheet({
    required this.refreshEnabled,
    required this.addToBookmarksEnabled,
    required this.onRefreshPressed,
    required this.onAddToBookmarkPressed,
    super.key,
  });

  final bool refreshEnabled;
  final bool addToBookmarksEnabled;
  final VoidCallback? onRefreshPressed;
  final VoidCallback? onAddToBookmarkPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyleV2.colors;

    return ShapedContainerColumn(
      color: colors.background2,
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      mainAxisSize: MainAxisSize.min,
      separator: const CommonDivider(),
      children: [
        _Tile(
          titleText: LocaleKeys.browserHistory.tr(),
          onPressed: () {
            Navigator.of(context).pop();
            context.goNamed(AppRoute.browserHistory.name);
          },
          trailing: CommonButtonIconWidget.svg(
            svg: Assets.images.historyFill.path,
          ),
        ),
        if (refreshEnabled)
          _Tile(
            titleText: LocaleKeys.browserRefresh.tr(),
            onPressed: () {
              Navigator.of(context).pop();
              onRefreshPressed?.call();
            },
            trailing: CommonButtonIconWidget.svg(
              svg: Assets.images.refresh.path,
            ),
          ),
        if (addToBookmarksEnabled)
          _Tile(
            titleText: LocaleKeys.browserAddToBookmarks.tr(),
            onPressed: () {
              Navigator.of(context).pop();
              onAddToBookmarkPressed?.call();
            },
            trailing: CommonButtonIconWidget.svg(
              svg: Assets.images.star.path,
            ),
          ),
      ],
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.titleText,
    required this.onPressed,
    required this.trailing,
  });

  final String titleText;
  final VoidCallback onPressed;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return CommonListTile(
      titleChild: Text(
        titleText,
        style: theme.textStyles.labelMedium,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: DimensSizeV2.d18,
        horizontal: DimensSizeV2.d24,
      ),
      onPressed: onPressed,
      backgroundColor: theme.colors.background2,
      trailing: trailing,
    );
  }
}
