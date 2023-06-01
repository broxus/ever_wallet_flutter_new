import 'package:app/app/service/messenger/cubit/messenger_cubit.dart';
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

  @override
  void initState() {
    super.initState();

    _cubit.init();
  }

  void showNextMessage() {
    final message = _cubit.nextMessage;
    if (message == null) {
      return;
    }

    showSnackbar(
      context: context,
      type: message.type.snackbarType,
      message: message.message,
      duration: message.duration,
      actionText: message.actionText,
      onAction: message.onAction,
      onDismiss: showNextMessage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MessengerCubit, MessengerState>(
      bloc: _cubit,
      listener: (context, state) => showNextMessage(),
      child: widget.child,
    );
  }
}
