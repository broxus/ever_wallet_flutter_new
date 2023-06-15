import 'package:app/app/service/messenger/cubit/messenger_cubit.dart';
import 'package:app/app/service/service.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

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
    _showNextMessage();
  }

  void _showNextMessage() {
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

    showSnackbar(
      context: ctx,
      type: message.type.snackbarType,
      message: message.message,
      duration: message.duration,
      actionText: message.actionText,
      onAction: message.onAction,
      onDismiss: _onDismiss,
      icon: CommonIconWidget.svg(
        svg: switch (message.type.snackbarType) {
          SnackbarType.error => Assets.images.alertRounded.path,
          SnackbarType.info => Assets.images.alarmRounded.path,
          SnackbarType.successful => Assets.images.checkRounded.path,
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MessengerCubit, MessengerState>(
      bloc: _cubit,
      listener: (_, __) => _showNextMessage(),
      child: widget.child,
    );
  }
}
