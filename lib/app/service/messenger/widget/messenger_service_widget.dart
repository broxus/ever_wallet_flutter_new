import 'dart:async';

import 'package:app/app/service/messenger/cubit/messenger_cubit.dart';
import 'package:app/app/service/service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_notification/in_app_notification.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/dimens_v2.dart';

class MessengerServiceWidget extends StatefulWidget {
  const MessengerServiceWidget({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  State<MessengerServiceWidget> createState() => _MessengerServiceWidgetState();
}

class _MessengerServiceWidgetState extends State<MessengerServiceWidget> {
  final MessengerCubit _cubit = MessengerCubit();
  bool _isSnackbarShown = false;

  @override
  void initState() {
    super.initState();

    _cubit.init();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  void _onDismiss() {
    _isSnackbarShown = false;
    _showNextMessage(context);
  }

  void _showNextMessage(BuildContext? context) {
    // Wait for the current snackbar to be dismissed
    if (_isSnackbarShown) {
      return;
    }

    // We can't use current context here because it's not contains Navigator
    final ctx = NavigationService.navigatorKey.currentState?.context;
    if (ctx == null) {
      return;
    }

    final message = _cubit.nextMessage();
    if (message == null) {
      return;
    }

    _isSnackbarShown = true;
    if (context != null) {
      Timer(message.duration, () {
        if (_isSnackbarShown) {
          _onDismiss();
        }
      });

      InAppNotification.show(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DimensSizeV2.d16,
            //vertical: DimensSizeV2.d56,
          ),
          child: message.toastByMessage(() {
            _onDismiss();
            InAppNotification.dismiss(context: context);
          }),
        ),
        context: context,
        onTap: _onDismiss,
        duration: message.duration,
      );
    } else {
      showSnackbar(
        context: ctx,
        toast: message.toastByMessage(_onDismiss),
        duration: message.duration,
        onDismiss: _onDismiss,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MessengerCubit, MessengerState>(
      bloc: _cubit,
      listener: (ctx, state) {
        if (state.messagesToShow.isNotEmpty) {
          final context = state.messagesToShow.last.context;
          _showNextMessage(context);
        } else {
          _showNextMessage(null);
        }
      },
      child: widget.child,
    );
  }
}
