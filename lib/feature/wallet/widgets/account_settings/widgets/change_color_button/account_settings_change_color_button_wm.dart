import 'package:app/app/service/identify/identy_colors.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/widgets/account_settings/widgets/change_color_bottom_sheet/change_color_bottom_sheet.dart';
import 'package:app/feature/wallet/widgets/account_settings/widgets/change_color_button/account_settings_change_color_button.dart';
import 'package:app/feature/wallet/widgets/account_settings/widgets/change_color_button/account_settings_change_color_button_model.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Factory method for creating [AccountSettingsChangeColorButtonWidgetModel]
AccountSettingsChangeColorButtonWidgetModel
    defaultAccountSettingsChangeColorButtonWidgetModelFactory(
  BuildContext context, {
  required String address,
}) {
  return AccountSettingsChangeColorButtonWidgetModel(
    AccountSettingsChangeColorButtonModel(
      createPrimaryErrorHandler(context),
      inject(),
      address,
    ),
    address,
  );
}

/// [WidgetModel] для [AccountSettingsChangeColorButton]
class AccountSettingsChangeColorButtonWidgetModel extends CustomWidgetModel<
    AccountSettingsChangeColorButton, AccountSettingsChangeColorButtonModel> {
  AccountSettingsChangeColorButtonWidgetModel(
    super.model,
    this._address,
  );

  ListenableState<IdentifyColor> get colorState => model.colorState;

  final String _address;

  void onPressed() {
    showChangeColorBottomSheet(
      context: context,
      address: _address,
    );
  }
}
