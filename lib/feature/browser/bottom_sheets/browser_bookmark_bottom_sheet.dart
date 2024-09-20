import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:app/feature/browser/widgets/browser_modal_item.dart';
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
    titleTextStyle: context.themeStyleV2.textStyles.headingLarge,
    context: context,
    body: (_, __) => BrowserBookmarkSheet(
      item: item,
    ),
    titleMargin: const EdgeInsets.only(
      top: DimensSizeV2.d32,
      bottom: DimensSizeV2.d12,
      left: DimensSizeV2.d16,
      right: DimensSizeV2.d16,
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
    final colors = context.themeStyleV2.colors;

    return BlocProvider<BrowserBookmarksBloc>(
      create: (context) => BrowserBookmarksBloc(
        inject<BrowserBookmarksStorageService>(),
      ),
      child: Builder(
        builder: (context) {
          return ShapedContainerColumn(
            color: colors.background2,
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            mainAxisSize: MainAxisSize.min,
            separator: const CommonDivider(),
            children: [
              BrowserModalItem(
                onPressed: () => _onSharePressed(context),
                titleText: LocaleKeys.browserBookmarkShare.tr(),
                trailing: CommonIconWidget.svg(
                  svg: Assets.images.export2.path,
                ),
              ),
              BrowserModalItem(
                onPressed: () => _onRenamePressed(context),
                titleText: LocaleKeys.browserBookmarkRename.tr(),
                trailing: CommonIconWidget.svg(
                  svg: Assets.images.edit.path,
                ),
              ),
              BrowserModalItem(
                onPressed: () => _onDeletePressed(context),
                titleText: LocaleKeys.browserBookmarkDelete.tr(),
                trailing: CommonIconWidget.svg(
                  svg: Assets.images.trash.path,
                ),
                contentColor: colors.contentNegative,
              ),
            ],
          );
        },
      ),
    );
  }

  void _onSharePressed(BuildContext context) {
    final shareText = widget.item.url.toString();
    Share.share(shareText);
    Navigator.of(context).pop();
  }

  void _onRenamePressed(BuildContext context) {
    Navigator.of(context)
      ..pop()
      ..push(
        showBrowserBookmarkRenameSheet(
          item: widget.item,
          titleTextStyle: context.themeStyleV2.textStyles.headingLarge,
        ),
      );
  }

  void _onDeletePressed(BuildContext context) {
    context.read<BrowserBookmarksBloc>().add(
          BrowserBookmarksEvent.remove(
            id: widget.item.id,
          ),
        );
    Navigator.of(context).pop();
  }
}
