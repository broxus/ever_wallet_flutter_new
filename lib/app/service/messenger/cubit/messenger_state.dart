part of 'messenger_cubit.dart';

@freezed
class MessengerState with _$MessengerState {
  const factory MessengerState({
    required List<Message> messagesToShow,
    required Map<String, DateTime> messagesTime,
  }) = _MessengerState;
}
