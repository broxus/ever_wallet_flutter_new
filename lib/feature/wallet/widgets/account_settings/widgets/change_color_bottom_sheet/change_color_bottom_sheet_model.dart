import 'dart:async';

import 'package:app/app/service/identify/i_identify_icons_service.dart';
import 'package:app/app/service/identify/identy_icon_data.dart';
import 'package:app/feature/wallet/widgets/account_settings/widgets/change_color_bottom_sheet/change_color_bottom_sheet.dart';
import 'package:elementary/elementary.dart';

/// [ElementaryModel] for [ChangeColorBottomSheet]
class ChangeColorBottomSheetModel extends ElementaryModel {
  ChangeColorBottomSheetModel(
    ErrorHandler errorHandler,
    this._identifyIconsService,
  ) : super(errorHandler: errorHandler);

  final IIdentifyIconsService _identifyIconsService;

  List<IdentifyIconData> get availableColors =>
      _identifyIconsService.availableColors;

  Future<IdentifyIconData> getData(String key) =>
      _identifyIconsService.getData(key);

  void setData(String address, IdentifyIconData color) {
    _identifyIconsService.setData(address, color);
  }
}
