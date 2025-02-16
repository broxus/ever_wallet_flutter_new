import 'package:app/data/models/browser_bookmark_item.dart';
import 'package:app/feature/browser/widgets/browser_modal_item.dart';
import 'package:app/feature/browserV2/widgets/bottomsheets/bookmark/browser_bookmark_bottom_sheet_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper function to show [BrowserBookmarkBottomSheet].
Future<void> showBrowserBookmarkSheet({
  required BuildContext context,
  required BrowserBookmarkItem item,
}) {
  return showCommonBottomSheet(
    title: LocaleKeys.browserBookmarkSettings.tr(),
    titleTextStyle: context.themeStyleV2.textStyles.headingLarge,
    context: context,
    body: (_, __) => BrowserBookmarkBottomSheet(
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

class BrowserBookmarkBottomSheet
    extends ElementaryWidget<BrowserBookmarkBottomSheetWidgetModel> {
  const BrowserBookmarkBottomSheet({
    required this.item,
    super.key,
    WidgetModelFactory<BrowserBookmarkBottomSheetWidgetModel> wmFactory =
        defaultBrowserBookmarkBottomSheetWidgetModelFactory,
  }) : super(wmFactory);

  final BrowserBookmarkItem item;

  @override
  Widget build(BrowserBookmarkBottomSheetWidgetModel wm) {
    return ShapedContainerColumn(
      color: wm.colors.background2,
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      mainAxisSize: MainAxisSize.min,
      separator: const CommonDivider(),
      children: [
        BrowserModalItem(
          onPressed: wm.onSharePressed,
          titleText: LocaleKeys.browserBookmarkShare.tr(),
          trailing: CommonIconWidget.svg(
            svg: Assets.images.export2.path,
          ),
        ),
        BrowserModalItem(
          onPressed: wm.onRenamePressed,
          titleText: LocaleKeys.browserBookmarkRename.tr(),
          trailing: CommonIconWidget.svg(
            svg: Assets.images.edit.path,
          ),
        ),
        BrowserModalItem(
          onPressed: wm.onDeletePressed,
          titleText: LocaleKeys.browserBookmarkDelete.tr(),
          trailing: CommonIconWidget.svg(
            svg: Assets.images.trash.path,
          ),
          contentColor: wm.colors.contentNegative,
        ),
      ],
    );
  }
}
