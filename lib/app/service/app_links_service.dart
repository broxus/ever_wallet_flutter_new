import 'package:app/event_bus/events/app_links/app_links_event.dart';
import 'package:app/event_bus/primary_bus.dart';
import 'package:app_links/app_links.dart';
import 'package:injectable/injectable.dart';

@singleton
class AppLinksService {
  final appLinks = AppLinks();
  late final _linkSubscription = appLinks.uriLinkStream.listen((uri) {
    primaryBus.fire(AppLinksUriEvent(uri));
  });

  @disposeMethod
  void dispose() {
    _linkSubscription.cancel();
  }
}
