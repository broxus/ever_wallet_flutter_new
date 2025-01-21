import 'package:app/app/service/messenger/service/messenger_service.dart';
import 'package:app/feature/wallet/new_account/screen/new_account_screen.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';

/// [ElementaryModel] for [NewAccountScreen]
class NewAccountScreenModel extends ElementaryModel {
  NewAccountScreenModel(
    ErrorHandler errorHandler,
    this._messageService,
  ) : super(errorHandler: errorHandler);

  final MessengerService _messageService;

  void showError(BuildContext context, String message) {
    _messageService.showError(context, message);
  }
}
