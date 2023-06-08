import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

enum SnackbarType {
  /// Just a regular Snackbar
  info,

  /// Snackbar that informs about error
  error,

  /// Some successful action
  successful,
}

// TODO(nesquikm): remove this global variable after the SnackBar learning
// to dismiss itself after the action is pressed.
Flushbar<void>? _snack;

/// [bottomPadding] - allows user to change position of snak if needed.
/// [icon] - displays only if there is no action.
Future<void> showSnackbar({
  required BuildContext context,
  required SnackbarType type,
  required String message,
  Widget? icon,
  bool isDismissible = true,
  double bottomPadding = DimensSize.d16,
  Duration? duration,
  VoidCallback? onDismiss,
  String? actionText,
  VoidCallback? onAction,
}) {
  final colors = context.themeStyle.colors;
  final backgroundColor = switch (type) {
    SnackbarType.error => colors.alert,
    SnackbarType.info => colors.blue,
    SnackbarType.successful => colors.apply,
  };

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

  final mainButton = actionText != null
      ? SmallButton(
          buttonType: EverButtonType.secondary,
          contentColor: backgroundColor,
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
    icon: mainButton == null && icon != null
        ? EverButtonStyleProvider(
            contentColor: colors.textContrast,
            child: icon,
          )
        : null,
    borderRadius: BorderRadius.circular(DimensRadius.medium),
    backgroundColor: backgroundColor,
    isDismissible: isDismissible,
    duration: duration,
    onStatusChanged: onStatusChanged,
    mainButton: mainButton,
    margin: const EdgeInsets.symmetric(horizontal: DimensSize.d16) +
        EdgeInsets.only(bottom: bottomPadding),
    onTap: (flushbar) {
      flushbar.dismiss();
    },
  );

  return _snack?.show(context) ?? Future<void>.value();
}
