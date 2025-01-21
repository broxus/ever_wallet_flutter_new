import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/new_account/screen/new_account_screen.dart';
import 'package:app/feature/wallet/new_account/screen/new_account_screen_model.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';

/// Factory method for creating [NewAccountScreenWidgetModel]
NewAccountScreenWidgetModel defaultNewAccountScreenWidgetModelFactory(
  BuildContext context,
) {
  return NewAccountScreenWidgetModel(
    NewAccountScreenModel(
      createPrimaryErrorHandler(context),
      inject(),
    ),
  );
}

/// [WidgetModel] для [NewAccountScreen]
class NewAccountScreenWidgetModel
    extends CustomWidgetModel<NewAccountScreen, NewAccountScreenModel> {
  NewAccountScreenWidgetModel(
    super.model,
  );

  bool get isError => widget.publicKey == null || widget.password == null;

  @override
  void initWidgetModel() {
    _init();
    super.initWidgetModel();
  }

  void _init() {
    if (!isError) {
      return;
    }

    final publicKeyText =
        widget.publicKey == null ? LocaleKeys.publicKeyNull.tr() : '';

    final passwordText =
        widget.password == null ? ' ${LocaleKeys.passwordNull.tr()}' : '';

    model.showError(
      context,
      '$publicKeyText$passwordText'.trim(),
    );
  }
}
