import 'package:app/event_bus/events/app_links/app_links_event.dart';
import 'package:app/event_bus/primary_bus.dart';
import 'package:broxus_app_links/broxus_app_links.dart';
import 'package:injectable/injectable.dart';

@singleton
class AppLinksService {
  final _appLinks = BroxusAppLinks();
  late final _linkSubscription = _appLinks.uriStream.listen(_handleLink);

  @disposeMethod
  void dispose() {
    _linkSubscription.cancel();
  }

  void _handleLink(Uri uri) {
    print('!!! DEBUG $uri');
    primaryBus.fire(AppLinksUriEvent(uri));
  }
}
