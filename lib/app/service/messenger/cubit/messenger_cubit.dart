import 'dart:async';

import 'package:app/app/service/messenger/message.dart';
import 'package:app/app/service/messenger/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/utils/utils.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'messenger_state.dart';

part 'messenger_cubit.freezed.dart';

/// Cubit that process messages and shows them to the user. It is not a bloc
/// because nextMessage() should immediately return next message to show and
/// remove it from the FIFO and blocs are not designed to do that.
class MessengerCubit extends Cubit<MessengerState> {
  MessengerCubit()
      : super(
          const MessengerState(
            messagesToShow: [],
            messagesTime: {},
          ),
        );

  StreamSubscription<Message>? _messageSubscription;
  StreamSubscription<void>? _clearQueueSubscription;

  void init() {
    final messengerService = inject<MessengerService>();
    _messageSubscription = messengerService.messageStream.listen(
      show,
    );
    _clearQueueSubscription = messengerService.clearQueueStream.listen(
      (_) => clearQueue(),
    );
  }

  @override
  Future<void> close() {
    _messageSubscription?.cancel();
    _messageSubscription = null;
    _clearQueueSubscription?.cancel();
    _clearQueueSubscription = null;

    return super.close();
  }

  /// Show message to the user
  void show(Message message) {
    final now = NtpTime.clockNow();
    final previousMessageTime = state.messagesTime[message.hashString];

    // Just drop message if it was shown recently
    if (previousMessageTime != null &&
        now.difference(previousMessageTime) < message.debounceTime) {
      return;
    }

    // Put message to the start of the queue
    emit(
      state.copyWith(
        messagesToShow: [
          message,
          ...state.messagesToShow,
        ],
        messagesTime: {
          ...state.messagesTime,
          message.hashString: now,
        },
      ),
    );
  }

  /// Get next message from the queue
  Message? nextMessage() {
    if (state.messagesToShow.isEmpty) {
      return null;
    }

    final [...remain, last] = state.messagesToShow;
    emit(state.copyWith(messagesToShow: remain));

    return last;
  }

  /// Clear messages queue
  void clearQueue() {
    emit(
      state.copyWith(
        messagesToShow: [],
      ),
    );
  }
}
