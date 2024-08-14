import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser/approvals_listener/actions/widgets/website_info/website_info_model.dart';
import 'package:app/feature/browser/approvals_listener/actions/widgets/website_info/website_info_widget.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

WebsiteInfoWidgetModel defaultWebsiteInfoWidgetModelFactory(
  BuildContext context,
) =>
    WebsiteInfoWidgetModel(
      WebsiteInfoModel(
        createPrimaryErrorHandler(context),
        inject(),
      ),
    );

class WebsiteInfoWidgetModel
    extends CustomWidgetModel<WebsiteInfoWidget, WebsiteInfoModel> {
  WebsiteInfoWidgetModel(super.model);

  late final Uri uri;

  late final _faviconUrl = createNotifier<String?>();

  ListenableState<String?> get faviconUrl => _faviconUrl;

  ThemeStyleV2 get theme => context.themeStyleV2;

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    uri = widget.uri;

    _getFaviconUrl(uri);
  }

  Future<void> _getFaviconUrl(Uri uri) async {
    final url = await model.getFaviconUrl(uri);

    if (url != null) {
      _faviconUrl.accept(url);
    }
  }
}
