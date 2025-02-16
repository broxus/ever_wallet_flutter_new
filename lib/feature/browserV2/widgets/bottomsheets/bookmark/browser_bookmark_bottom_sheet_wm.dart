import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser/bottom_sheets/browser_bookmark_rename_bottom_sheet.dart';
import 'package:app/feature/browserV2/widgets/bottomsheets/bookmark/browser_bookmark_bottom_sheet.dart';
import 'package:app/feature/browserV2/widgets/bottomsheets/bookmark/browser_bookmark_bottom_sheet_model.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Factory method for creating [BrowserBookmarkBottomSheetWidgetModel]
BrowserBookmarkBottomSheetWidgetModel
    defaultBrowserBookmarkBottomSheetWidgetModelFactory(
  BuildContext context,
) {
  return BrowserBookmarkBottomSheetWidgetModel(
    BrowserBookmarkBottomSheetModel(
      createPrimaryErrorHandler(context),
      inject(),
    ),
  );
}

/// [WidgetModel] для [BrowserBookmarkBottomSheet]
class BrowserBookmarkBottomSheetWidgetModel extends CustomWidgetModel<
    BrowserBookmarkBottomSheet, BrowserBookmarkBottomSheetModel> {
  BrowserBookmarkBottomSheetWidgetModel(
    super.model,
  );

  ColorsPaletteV2 get colors => _theme.colors;

  ThemeStyleV2 get _theme => context.themeStyleV2;

  void onSharePressed() {
    final shareText = widget.item.url.toString();
    Share.share(shareText);
    Navigator.of(context).pop();
  }

  void onRenamePressed() {
    Navigator.of(context)
      ..pop()
      ..push(
        showBrowserBookmarkRenameSheet(
          item: widget.item,
          titleTextStyle: context.themeStyleV2.textStyles.headingLarge,
        ),
      );
  }

  void onDeletePressed() {
    model.removeBookmark(widget.item.id);
    Navigator.of(context).pop();
  }
}
