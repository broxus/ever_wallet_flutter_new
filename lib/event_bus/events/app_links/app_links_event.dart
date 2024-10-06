import 'package:app/event_bus/events/base_event.dart';

sealed class AppLinksEvent extends BaseEvent {}

class AppLinksUriEvent extends AppLinksEvent {
  AppLinksUriEvent(
    this.uri, {
    this.strategy = Strategy.push,
  });

  final Uri uri;
  final Strategy strategy;
}

enum Strategy {
  replace,
  push,
}
