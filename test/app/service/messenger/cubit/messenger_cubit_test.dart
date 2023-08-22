// ignore_for_file: inference_failure_on_function_invocation

import 'package:app/app/service/messenger/cubit/messenger_cubit.dart';
import 'package:app/app/service/service.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:clock/clock.dart';
import 'package:test/test.dart';

void main() {
  final message0 = Message(
    message: 'message0',
    type: MessageType.info,
  );

  final message1 = Message(
    message: 'message1',
    type: MessageType.info,
  );

  final message2 = Message(
    message: 'message2',
    type: MessageType.info,
  );

  group('MessengerCubit', () {
    late MessengerCubit messengerCubit;
    setUp(() {
      messengerCubit = MessengerCubit();
    });

    test('initial state is correct', () {
      expect(
        messengerCubit.state,
        const MessengerState(
          messagesToShow: [],
          messagesTime: {},
        ),
      );
    });

    blocTest(
      'emits [] when nothing is added',
      build: MessengerCubit.new,
      expect: () => <MessengerState>[],
    );

    blocTest(
      'emits one message when one is added',
      build: MessengerCubit.new,
      act: (cubit) {
        withClock(Clock.fixed(DateTime(2000)), () {
          cubit.show(message0);
        });
      },
      expect: () => <MessengerState>[
        MessengerState(
          messagesToShow: [message0],
          messagesTime: {message0.hashString: DateTime(2000)},
        ),
      ],
    );

    blocTest(
      'emits two messages when two is added, time updated',
      build: MessengerCubit.new,
      act: (cubit) {
        withClock(Clock.fixed(DateTime(2000)), () {
          cubit.show(message0);
        });
        withClock(Clock.fixed(DateTime(2001)), () {
          cubit.show(message0);
        });
      },
      expect: () => <MessengerState>[
        MessengerState(
          messagesToShow: [message0],
          messagesTime: {message0.hashString: DateTime(2000)},
        ),
        MessengerState(
          messagesToShow: [message0, message0],
          messagesTime: {message0.hashString: DateTime(2001)},
        ),
      ],
    );

    blocTest(
      'emits two messages when two different is added',
      build: MessengerCubit.new,
      act: (cubit) {
        withClock(Clock.fixed(DateTime(2000)), () {
          cubit.show(message0);
        });
        withClock(Clock.fixed(DateTime(2001)), () {
          cubit.show(message1);
        });
      },
      expect: () => <MessengerState>[
        MessengerState(
          messagesToShow: [message0],
          messagesTime: {message0.hashString: DateTime(2000)},
        ),
        MessengerState(
          messagesToShow: [message1, message0],
          messagesTime: {
            message0.hashString: DateTime(2000),
            message1.hashString: DateTime(2001),
          },
        ),
      ],
    );

    blocTest(
      'emits one message when two is added, one is debounced',
      build: MessengerCubit.new,
      act: (cubit) {
        withClock(Clock.fixed(DateTime(2000)), () {
          cubit
            ..show(message0)
            ..show(message0);
        });
      },
      expect: () => <MessengerState>[
        MessengerState(
          messagesToShow: [message0],
          messagesTime: {message0.hashString: DateTime(2000)},
        ),
      ],
    );

    blocTest(
      'emits [] when one is added and queue is cleared',
      build: MessengerCubit.new,
      act: (cubit) {
        withClock(Clock.fixed(DateTime(2001)), () {
          cubit.show(message0);
        });
        cubit.clearQueue();
      },
      expect: () => <MessengerState>[
        MessengerState(
          messagesToShow: [message0],
          messagesTime: {message0.hashString: DateTime(2001)},
        ),
        MessengerState(
          messagesToShow: [],
          messagesTime: {message0.hashString: DateTime(2001)},
        ),
      ],
    );

    blocTest(
      'emits one messages when two is added and one is fetched',
      build: MessengerCubit.new,
      act: (cubit) {
        withClock(Clock.fixed(DateTime(2000)), () {
          cubit.show(message0);
        });
        withClock(Clock.fixed(DateTime(2001)), () {
          cubit.show(message0);
        });
        expect(cubit.nextMessage(), message0);
      },
      expect: () => <MessengerState>[
        MessengerState(
          messagesToShow: [message0],
          messagesTime: {message0.hashString: DateTime(2000)},
        ),
        MessengerState(
          messagesToShow: [message0, message0],
          messagesTime: {message0.hashString: DateTime(2001)},
        ),
        MessengerState(
          messagesToShow: [message0],
          messagesTime: {message0.hashString: DateTime(2001)},
        ),
      ],
    );

    blocTest(
      'correct message order',
      build: MessengerCubit.new,
      act: (cubit) {
        expect(cubit.nextMessage(), null);
        withClock(Clock.fixed(DateTime(2000)), () {
          cubit.show(message0);
        });
        withClock(Clock.fixed(DateTime(2001)), () {
          cubit.show(message1);
        });
        withClock(Clock.fixed(DateTime(2002)), () {
          cubit.show(message2);
        });
        expect(cubit.nextMessage(), message0);
        expect(cubit.nextMessage(), message1);
        expect(cubit.nextMessage(), message2);
        expect(cubit.nextMessage(), null);
      },
      expect: () => <MessengerState>[
        MessengerState(
          messagesToShow: [message0],
          messagesTime: {message0.hashString: DateTime(2000)},
        ),
        MessengerState(
          messagesToShow: [message1, message0],
          messagesTime: {
            message0.hashString: DateTime(2000),
            message1.hashString: DateTime(2001),
          },
        ),
        MessengerState(
          messagesToShow: [message2, message1, message0],
          messagesTime: {
            message0.hashString: DateTime(2000),
            message1.hashString: DateTime(2001),
            message2.hashString: DateTime(2002),
          },
        ),
        MessengerState(
          messagesToShow: [message2, message1],
          messagesTime: {
            message0.hashString: DateTime(2000),
            message1.hashString: DateTime(2001),
            message2.hashString: DateTime(2002),
          },
        ),
        MessengerState(
          messagesToShow: [message2],
          messagesTime: {
            message0.hashString: DateTime(2000),
            message1.hashString: DateTime(2001),
            message2.hashString: DateTime(2002),
          },
        ),
        MessengerState(
          messagesToShow: [],
          messagesTime: {
            message0.hashString: DateTime(2000),
            message1.hashString: DateTime(2001),
            message2.hashString: DateTime(2002),
          },
        ),
      ],
    );
  });
}
