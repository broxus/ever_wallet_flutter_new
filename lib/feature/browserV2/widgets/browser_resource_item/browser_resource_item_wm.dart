import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browserV2/widgets/browser_resource_item/browser_resource_item.dart';
import 'package:app/feature/browserV2/widgets/browser_resource_item/browser_resource_item_model.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Factory method for creating [BrowserResourceItemWidgetModel]
BrowserResourceItemWidgetModel defaultBrowserResourceItemWidgetModelFactory(
  BuildContext context,
) {
  return BrowserResourceItemWidgetModel(
    BrowserResourceItemModel(
      createPrimaryErrorHandler(context),
      inject(),
    ),
  );
}

/// [WidgetModel] для [BrowserResourceItem]
class BrowserResourceItemWidgetModel
    extends CustomWidgetModel<BrowserResourceItem, BrowserResourceItemModel> {
  BrowserResourceItemWidgetModel(
    super.model,
  );

  late final _faviconUrlState = createNotifier<String?>();
  late final _subTitleState = createNotifier<String?>(widget.subTitle);

  ListenableState<String?> get faviconUrlState => _faviconUrlState;

  ListenableState<String?> get subTitleState => _subTitleState;

  ThemeStyleV2 get theme => context.themeStyleV2;

  @override
  void initWidgetModel() {
    model.allFaviconsState.addListener(_handleFavicons);
    _faviconUrlState.addListener(_handleFavicon);
    model.fetchFavicons(widget.faviconUri);
    super.initWidgetModel();
  }

  @override
  void dispose() {
    model.allFaviconsState.removeListener(_handleFavicons);
    super.dispose();
  }

  void _handleFavicons() {
    final data = model.allFaviconsState.value;
    final faviconUri = widget.faviconUri;

    if (faviconUri == null || data == null) {
      return;
    }
    _faviconUrlState.accept(model.allFaviconsState.value?.getSafe(faviconUri));
  }

  void _handleFavicon() {
    if (widget.subTitle == null) {
      _subTitleState.accept(_faviconUrlState.value);
    }
  }
}
