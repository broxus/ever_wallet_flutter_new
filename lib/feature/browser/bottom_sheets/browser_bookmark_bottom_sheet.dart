import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper function to show [BrowserBookmarkSheet].
Future<void> showBrowserBookmarkSheet({
  required BuildContext context,
  required VoidCallback onSharePressed,
  required VoidCallback onRenamePressed,
  required VoidCallback onDeletePressed,
}) {
  return showCommonBottomSheet(
    title: LocaleKeys.browserBookmarkSettings.tr(),
    context: context,
    body: (_, __) => BrowserBookmarkSheet(
      onSharePressed: onSharePressed,
      onRenamePressed: onRenamePressed,
      onDeletePressed: onDeletePressed,
    ),
  );
}

class BrowserBookmarkSheet extends StatefulWidget {
  const BrowserBookmarkSheet({
    required this.onSharePressed,
    required this.onRenamePressed,
    required this.onDeletePressed,
    super.key,
  });

  final VoidCallback onSharePressed;
  final VoidCallback onRenamePressed;
  final VoidCallback onDeletePressed;

  @override
  State<BrowserBookmarkSheet> createState() => _BrowserBookmarkSheetState();
}

class _BrowserBookmarkSheetState extends State<BrowserBookmarkSheet> {
  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    return ShapedContainerColumn(
      margin: EdgeInsets.zero,
      mainAxisSize: MainAxisSize.min,
      separator: const CommonDivider(),
      children: [
        CommonListTile(
          onPressed: _onSharePressed,
          titleText: LocaleKeys.browserBookmarkShare.tr(),
          trailing: CommonIconWidget.svg(
            svg: Assets.images.share.path,
            color: colors.textPrimary,
          ),
        ),
        CommonListTile(
          onPressed: _onRenamePressed,
          titleText: LocaleKeys.browserBookmarkRename.tr(),
          trailing: CommonIconWidget.svg(
            svg: Assets.images.edit.path,
            color: colors.textPrimary,
          ),
        ),
        CommonListTile(
          onPressed: _onDeletePressed,
          titleText: LocaleKeys.browserBookmarkDelete.tr(),
          trailing: CommonIconWidget.svg(
            svg: Assets.images.trash.path,
          ),
          contentColor: colors.alert,
        ),
      ],
    );
  }

  void _onSharePressed() {
    Navigator.of(context).pop();
    widget.onSharePressed.call();
  }

  void _onRenamePressed() {
    Navigator.of(context).pop();
    widget.onRenamePressed.call();
  }

  void _onDeletePressed() {
    Navigator.of(context).pop();
    widget.onDeletePressed.call();
  }
}
