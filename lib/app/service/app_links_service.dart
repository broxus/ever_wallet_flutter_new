import 'package:app/event_bus/events/app_links/app_links_event.dart';
import 'package:app/event_bus/primary_bus.dart';
import 'package:app_links/app_links.dart';
import 'package:injectable/injectable.dart';

@singleton
class AppLinksService {
  final _appLinks = AppLinks();
  late final _linkSubscription = _appLinks.uriLinkStream.listen(_handleLink);

  Future<void> init() async {
    final initialUri = await _appLinks.getInitialLink();
    if (initialUri != null) {
      _handleLink(initialUri);
    }
  }

  @disposeMethod
  void dispose() {
    _linkSubscription.cancel();
  }

  void _handleLink(Uri uri) {
    primaryBus.fire(AppLinksUriEvent(uri));
  }
}
