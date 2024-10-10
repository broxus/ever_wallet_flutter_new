import 'package:app/app/service/identify/identy_icon_data.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/widgets/account_settings/widgets/change_color_bottom_sheet/change_color_bottom_sheet.dart';
import 'package:app/feature/wallet/widgets/account_settings/widgets/change_color_bottom_sheet/change_color_bottom_sheet_model.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/text_styles_v2.dart';

/// Factory method for creating [ChangeColorBottomSheetWidgetModel]
ChangeColorBottomSheetWidgetModel
    defaultChangeColorBottomSheetWidgetModelFactory(
  BuildContext context,
) {
  return ChangeColorBottomSheetWidgetModel(
    ChangeColorBottomSheetModel(
      createPrimaryErrorHandler(context),
      inject(),
    ),
  );
}

/// [WidgetModel] для [ChangeColorBottomSheet]
class ChangeColorBottomSheetWidgetModel extends CustomWidgetModel<
    ChangeColorBottomSheet, ChangeColorBottomSheetModel> {
  ChangeColorBottomSheetWidgetModel(
    super.model,
  );

  late final _selectedColorState = StateNotifier<IdentifyIconData?>();

  List<IdentifyIconData> get availableColors => model.availableColors;

  late final count = availableColors.length;
  late final lastIndex = count - 1;

  ListenableState<IdentifyIconData?> get selectedColorState =>
      _selectedColorState;

  TextStylesV2 get textStyle => _theme.textStyles;

  ThemeStyleV2 get _theme => context.themeStyleV2;

  IdentifyIconData? get _selectedColor => _selectedColorState.value;

  @override
  void initWidgetModel() {
    _init();
    super.initWidgetModel();
  }

  void onPressedBack() {
    _back();
  }

  void onPressedColor(IdentifyIconData color) {
    _selectedColorState.accept(color);
  }

  void onPressedSave() {
    final color = _selectedColor;

    if (color == null) {
      return;
    }

    model.setData(widget.address, color);
    _back();
  }

  Future<void> _init() async {
    _selectedColorState.accept(await model.getData(widget.address));
  }

  void _back() {
    Navigator.of(context).pop();
  }
}
