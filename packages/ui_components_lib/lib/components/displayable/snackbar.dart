import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

enum SnackbarType {
  /// Just a regular Snackbar
  info,

  /// Snackbar that informs about error
  error,
}

// TODO(nesquikm): remove this global variable after the SnackBar learning
// to dismiss itself after the action is pressed.
Flushbar<void>? _snack;

Future<void> showSnackbar({
  required BuildContext context,
  required SnackbarType type,
  required String message,
  bool isDismissible = true,
  Duration? duration,
  VoidCallback? onDismiss,
  String? actionText,
  VoidCallback? onAction,
}) {
  final colors = context.themeStyle.colors;
  // TODO(nesquikm): use return values from switch after upgrading dart
  Color backgroundColor() {
    switch (type) {
      case SnackbarType.error:
        return colors.alert;
      case SnackbarType.info:
        return colors.backgroundPrimary;
    }
  }

  void onStatusChanged(FlushbarStatus? status) {
    switch (status) {
      case FlushbarStatus.IS_APPEARING:
        break;
      case FlushbarStatus.SHOWING:
        break;
      case FlushbarStatus.IS_HIDING:
        break;
      case FlushbarStatus.DISMISSED:
        onDismiss?.call();
      case null:
        break;
    }
  }

  final mainButton = (actionText != null)
      ? CommonButton.ghost(
          onPressed: onAction != null
              ? () {
                  // TODO(nesquikm): WTF? The snackbar SHOULD dismiss itself
                  // immediately after the action is pressed, but it doesn't.
                  // So we have to dismiss it manually.
                  _snack?.dismiss();
                  onAction();
                }
              : null,
          text: actionText,
        )
      : null;

  _snack = Flushbar<void>(
    messageText: Text(
      message,
      style: StyleRes.secondaryBold.copyWith(color: colors.textContrast),
    ),
    backgroundColor: backgroundColor(),
    isDismissible: isDismissible,
    duration: duration,
    onStatusChanged: onStatusChanged,
    mainButton: mainButton,
    onTap: (flushbar) {
      flushbar.dismiss();
    },
  );

  return _snack?.show(context) ?? Future<void>.value();
}
