import 'package:app/app/service/messenger/message.dart';
import 'package:app/app/service/messenger/service/service.dart';
import 'package:app/di/di.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'messenger_state.dart';
part 'messenger_cubit.freezed.dart';

class MessengerCubit extends Cubit<MessengerState> {
  MessengerCubit()
      : super(
          const MessengerState(
            messagesToShow: [],
            messagesTime: {},
          ),
        );

  void init() {
    final messengerService = inject<MessengerService>();
    messengerService.messageStream.listen(show);
    messengerService.clearQueueStream.listen((_) => clearQueue());
  }

  /// Show message to the user
  void show(Message message) {
    final now = DateTime.now();
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

    final first = state.messagesToShow.first;
    emit(state.copyWith(messagesToShow: state.messagesToShow.skip(1).toList()));
    return first;
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
