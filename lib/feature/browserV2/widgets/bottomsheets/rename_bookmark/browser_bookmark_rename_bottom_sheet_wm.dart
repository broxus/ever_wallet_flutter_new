import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browserV2/widgets/bottomsheets/rename_bookmark/browser_bookmark_rename_bottom_sheet.dart';
import 'package:app/feature/browserV2/widgets/bottomsheets/rename_bookmark/browser_bookmark_rename_bottom_sheet_model.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/widgets.dart';

/// Factory method for creating [BrowserBookmarkRenameBottomSheetWidgetModel]
BrowserBookmarkRenameBottomSheetWidgetModel
    defaultBrowserBookmarkRenameBottomSheetWidgetModelFactory(
  BuildContext context,
) {
  return BrowserBookmarkRenameBottomSheetWidgetModel(
    BrowserBookmarkRenameBottomSheetModel(
      createPrimaryErrorHandler(context),
      inject(),
    ),
  );
}

/// [WidgetModel] для [BrowserBookmarkRenameBottomSheet]
class BrowserBookmarkRenameBottomSheetWidgetModel extends CustomWidgetModel<
    BrowserBookmarkRenameBottomSheet, BrowserBookmarkRenameBottomSheetModel> {
  BrowserBookmarkRenameBottomSheetWidgetModel(
    super.model,
  );

  late final nameController = createTextEditingController(widget.item.title);
  late final _isCanEditedState = createNotifier<bool>(false);

  ListenableState<bool> get isCanEditedState => _isCanEditedState;

  String get _name => nameController.text.trim();

  bool get _isNewName => _name != widget.item.title;

  bool get _isCanRename => _name.isNotEmpty && _isNewName;

  @override
  void initWidgetModel() {
    nameController.addListener(() => _isCanEditedState.accept(_isCanRename));
    super.initWidgetModel();
  }

  void onRename() {
    if (!_isCanRename) {
      return;
    }
    model.renameBookmark(widget.item.id, _name);
    Navigator.of(context).pop();
  }
}
