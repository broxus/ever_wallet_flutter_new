import 'package:app/event_bus/events/base_event.dart';

sealed class AppLinksEvent extends BaseEvent {}

class BrowserAppLinkUriEvent extends AppLinksEvent {
  BrowserAppLinkUriEvent(this.uri);

  final Uri uri;
}
