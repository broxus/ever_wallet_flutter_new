import 'dart:async';

import 'package:app/app/service/messenger/message.dart';
import 'package:injectable/injectable.dart';

@singleton
class MessengerService {
  final StreamController<Message> _messageStreamController =
      StreamController<Message>.broadcast();

  final StreamController<void> _clearQueueStreamController =
      StreamController<void>.broadcast();

  void show(Message message) {
    _messageStreamController.add(message);
  }

  void clearQueue() {
    _clearQueueStreamController.add(null);
  }

  Stream<Message> get messageStream => _messageStreamController.stream;
  Stream<void> get clearQueueStream => _clearQueueStreamController.stream;
}
