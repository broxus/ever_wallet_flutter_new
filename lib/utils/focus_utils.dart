import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

void requestFocus(
  BuildContext context,
  FocusNode node,
) {
  FocusScope.of(context).requestFocus(node);
  SystemChannels.textInput.invokeMethod('TextInput.show');
}

void resetFocus([BuildContext? context]) {
  try {
    final primaryFocus = FocusManager.instance.primaryFocus;

    if (primaryFocus != null) {
      primaryFocus.unfocus();
      return;
    }

    if (context == null) {
      return;
    }

    final focusScope = FocusScope.of(context);

    if (focusScope.focusedChild == null) {
      requestFocus(
        context,
        FocusNode(),
      );
    } else {
      focusScope.focusedChild?.unfocus();
    }
  } on Object catch (e, s) {
    Logger('Focus').severe('', e, s);
  }
}
