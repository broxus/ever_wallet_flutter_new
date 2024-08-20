import 'dart:async';

import 'package:app/app/service/messenger/message.dart';
import 'package:app/generated/generated.dart';
import 'package:injectable/injectable.dart';

/// Service that shows messages to the user. Keep it simple and stupid, use only
/// as stream sources for blocs and cubits that actual provide messages to the
/// user.
@singleton
class MessengerService {
  final StreamController<Message> _messageStreamController =
      StreamController<Message>.broadcast();

  final StreamController<void> _clearQueueStreamController =
      StreamController<void>.broadcast();

  void show(Message message) {
    _messageStreamController.add(message);
  }

  void showConnectionError() {
    show(
      Message.error(
        message: LocaleKeys.connectingNetworkFailed.tr(),
      ),
    );
  }

  void clearQueue() {
    _clearQueueStreamController.add(null);
  }

  Stream<Message> get messageStream => _messageStreamController.stream;

  Stream<void> get clearQueueStream => _clearQueueStreamController.stream;
}
