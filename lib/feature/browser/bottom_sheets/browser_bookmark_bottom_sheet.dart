import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper function to show [BrowserBookmarkSheet].
Future<void> showBrowserBookmarkSheet({
  required BuildContext context,
  required BrowserBookmarkItem item,
}) {
  return showCommonBottomSheet(
    title: LocaleKeys.browserBookmarkSettings.tr(),
    context: context,
    body: (_, __) => BrowserBookmarkSheet(
      item: item,
    ),
  );
}

class BrowserBookmarkSheet extends StatefulWidget {
  const BrowserBookmarkSheet({
    required this.item,
    super.key,
  });

  final BrowserBookmarkItem item;

  @override
  State<BrowserBookmarkSheet> createState() => _BrowserBookmarkSheetState();
}

class _BrowserBookmarkSheetState extends State<BrowserBookmarkSheet> {
  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    return BlocProvider<BrowserBookmarksBloc>(
      create: (context) => BrowserBookmarksBloc(
        inject<BrowserBookmarksStorageService>(),
      ),
      child: Builder(
        builder: (context) {
          return ShapedContainerColumn(
            margin: EdgeInsets.zero,
            mainAxisSize: MainAxisSize.min,
            separator: const CommonDivider(),
            children: [
              CommonListTile(
                onPressed: () => _onSharePressed(context),
                titleText: LocaleKeys.browserBookmarkShare.tr(),
                trailing: CommonIconWidget.svg(
                  svg: Assets.images.share.path,
                  color: colors.textPrimary,
                ),
              ),
              CommonListTile(
                onPressed: () => _onRenamePressed(context),
                titleText: LocaleKeys.browserBookmarkRename.tr(),
                trailing: CommonIconWidget.svg(
                  svg: Assets.images.edit.path,
                  color: colors.textPrimary,
                ),
              ),
              CommonListTile(
                onPressed: () => _onDeletePressed(context),
                titleText: LocaleKeys.browserBookmarkDelete.tr(),
                trailing: CommonIconWidget.svg(
                  svg: Assets.images.trash.path,
                ),
                contentColor: colors.alert,
              ),
            ],
          );
        },
      ),
    );
  }

  void _onSharePressed(BuildContext context) {
    Navigator.of(context).pop();
    final shareText = widget.item.url.toString();
    Share.share(shareText);
  }

  void _onRenamePressed(BuildContext context) {
    Navigator.of(context).pop();
    showBrowserBookmarkRenameSheet(context: context, item: widget.item);
  }

  void _onDeletePressed(BuildContext context) {
    Navigator.of(context).pop();
    context.read<BrowserBookmarksBloc>().add(
          BrowserBookmarksEvent.remove(
            id: widget.item.id,
          ),
        );
  }
}
