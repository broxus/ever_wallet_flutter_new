import 'package:app/app/service/messenger/message.dart';
import 'package:app/app/service/messenger/service/messenger_service.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Customize if need
class PrimaryErrorHandler extends DefaultDebugErrorHandler {
  PrimaryErrorHandler(
    this._context,
    this._messengerService,
  );

  final BuildContext _context;
  final MessengerService _messengerService;

  @override
  void handleError(Object error, {StackTrace? stackTrace}) {
    showError(error.toString());
    super.handleError(error, stackTrace: stackTrace);
  }

  void showError(
    String message, {
    Duration debounceTime = defaultInfoMessageDebounceDuration,
  }) {
    _messengerService.show(
      Message.error(
        context: _context,
        message: message,
        debounceTime: debounceTime,
      ),
    );
  }
}
