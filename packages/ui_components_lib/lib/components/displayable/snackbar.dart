import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

enum SnackbarType {
  /// Just a regular Snackbar
  info,

  /// Snackbar that informs about error
  error,

  /// Some successful action
  successful,
}

Future<void> showSnackbar({
  required BuildContext context,
  required Toast toast,
  bool isDismissible = true,
  Duration? duration,
  VoidCallback? onDismiss,
}) async {
  final scaffoldMessenger = ScaffoldMessenger.of(context);

  final toastWithTap = Toast(
    type: toast.type,
    icon: toast.icon,
    description: toast.description,
    heading: toast.heading,
    onTapClosed: isDismissible
        ? toast.onTapClosed ?? scaffoldMessenger.removeCurrentSnackBar
        : null,
    actions: toast.actions,
  );

  scaffoldMessenger.showSnackBar(
    SnackBar(
      padding: EdgeInsets.zero,
      content: toastWithTap,
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
      duration: defaultErrorMessageDebounceDuration,
      onVisible: () => onDismiss?.call(),
    ),
  );
}
