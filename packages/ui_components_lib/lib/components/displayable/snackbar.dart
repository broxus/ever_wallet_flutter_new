import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

export 'package:another_flushbar/flushbar.dart';

const snackbarDisplayDuration = Duration(seconds: 2);

Flushbar<void>? _previousSnack;

/// Show default snackbar that must tell user about something
Future<void> showSnackbar({
  required BuildContext context,
  required String message,
  FlushbarPosition flushbarPosition = FlushbarPosition.BOTTOM,
  EdgeInsets margin = const EdgeInsets.symmetric(vertical: 8),
  Duration displayDuration = snackbarDisplayDuration,
}) async {
  final colors = context.themeStyle.colors;
  await _previousSnack?.dismiss();

  _previousSnack = Flushbar<void>(
    messageText: Text(
      message,
      style: StyleRes.regular16.copyWith(color: colors.textPrimary),
    ),
    flushbarPosition: flushbarPosition,
    backgroundColor: colors.fillingPrimary,
    margin: const EdgeInsets.symmetric(horizontal: 16) + margin,
    duration: displayDuration,
  );

  // ignore: use_build_context_synchronously
  if (!context.mounted) return;
  return _previousSnack!.show(context);
}

/// Show snackbar with error customization that means someething wrong happens
Future<void> showErrorSnackbar({
  required BuildContext context,
  required String message,
  FlushbarPosition flushbarPosition = FlushbarPosition.BOTTOM,
  EdgeInsets margin = const EdgeInsets.symmetric(vertical: 16),
  Duration displayDuration = snackbarDisplayDuration,
}) async {
  final colors = context.themeStyle.colors;
  await _previousSnack?.dismiss();

  _previousSnack = Flushbar(
    messageText: Text(
      message,
      style: StyleRes.regular16.copyWith(color: colors.textNegative),
    ),
    flushbarPosition: flushbarPosition,
    backgroundColor: colors.fillingPrimary,
    margin: const EdgeInsets.symmetric(horizontal: 16) + margin,
    duration: displayDuration,
  );

  // ignore: use_build_context_synchronously
  if (!context.mounted) return;
  return _previousSnack!.show(context);
}

/// Show snackbar with specified action that user can make
Future<void> showSnackbarWithAction({
  required BuildContext context,
  required String message,
  required String actionText,
  required VoidCallback action,
  bool isOneLine = true,
  FlushbarPosition flushbarPosition = FlushbarPosition.BOTTOM,
  EdgeInsets margin = const EdgeInsets.symmetric(vertical: 8),
  Duration displayDuration = snackbarDisplayDuration,
}) async {
  final colors = context.themeStyle.colors;
  await _previousSnack?.dismiss();

  _previousSnack = Flushbar(
    messageText: Text(
      isOneLine ? message.overflow : message,
      style: StyleRes.regular16.copyWith(color: colors.textPrimary),
      maxLines: isOneLine ? 1 : null,
    ),
    mainButton: CommonButton.ghost(
      onPressed: () {
        action();
        _previousSnack?.dismiss();
      },
      text: actionText,
    ),
    flushbarPosition: flushbarPosition,
    backgroundColor: colors.fillingPrimary,
    margin: const EdgeInsets.symmetric(horizontal: 16) + margin,
    duration: displayDuration,
  );

  // ignore: use_build_context_synchronously
  if (!context.mounted) return;
  return _previousSnack!.show(context);
}
