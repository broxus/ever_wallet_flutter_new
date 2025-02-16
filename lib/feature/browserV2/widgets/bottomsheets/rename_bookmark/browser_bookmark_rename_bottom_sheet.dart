import 'package:app/data/models/browser_bookmark_item.dart';
import 'package:app/feature/browserV2/widgets/bottomsheets/rename_bookmark/browser_bookmark_rename_bottom_sheet_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/widgets.dart';

/// Helper function to show [BrowserBookmarkRenameBottomSheet].
ModalRoute<void> showBrowserBookmarkRenameSheet({
  required BrowserBookmarkItem item,
  TextStyle? titleTextStyle,
}) {
  return commonBottomSheetRoute(
    title: LocaleKeys.browserBookmarkRenameEnterName.tr(),
    titleTextStyle: titleTextStyle,
    titleMargin: const EdgeInsets.only(
      top: DimensSizeV2.d32,
      bottom: DimensSizeV2.d24,
      left: DimensSizeV2.d16,
      right: DimensSizeV2.d16,
    ),
    body: (_, __) => BrowserBookmarkRenameBottomSheet(
      item: item,
    ),
  );
}

class BrowserBookmarkRenameBottomSheet
    extends ElementaryWidget<BrowserBookmarkRenameBottomSheetWidgetModel> {
  const BrowserBookmarkRenameBottomSheet({
    required this.item,
    super.key,
    WidgetModelFactory<BrowserBookmarkRenameBottomSheetWidgetModel> wmFactory =
        defaultBrowserBookmarkRenameBottomSheetWidgetModelFactory,
  }) : super(wmFactory);

  final BrowserBookmarkItem item;

  @override
  Widget build(BrowserBookmarkRenameBottomSheetWidgetModel wm) {
    return SeparatedColumn(
      mainAxisSize: MainAxisSize.min,
      separatorSize: DimensSizeV2.d24,
      children: [
        PrimaryTextField(
          textEditingController: wm.nameController,
          hintText: LocaleKeys.browserBookmarkRenameName.tr(),
          onSubmit: (_) => wm.onRename(),
        ),
        StateNotifierBuilder<bool>(
          listenableState: wm.isCanEditedState,
          builder: (_, bool? isCanEdited) {
            return PrimaryButton(
              buttonShape: ButtonShape.pill,
              title: LocaleKeys.browserBookmarkRenameWord.tr(),
              onPressed: (isCanEdited ?? false) ? wm.onRename : null,
            );
          },
        ),
      ],
    );
  }
}
