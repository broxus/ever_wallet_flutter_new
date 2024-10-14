import 'dart:async';

import 'package:app/event_bus/events/app_links/app_links_event.dart';
import 'package:app/event_bus/events/navigation/bottom_navigation_events.dart';
import 'package:app/event_bus/primary_bus.dart';
import 'package:app/feature/root/view/root_tab.dart';
import 'package:broxus_app_links/broxus_app_links.dart';
import 'package:injectable/injectable.dart';

@singleton
class AppLinksService {
  AppLinksService() {
    _linkSubscription = _appLinks.uriStream.listen(_handleAppLink);
  }

  static const _linkKey = 'link';

  final _appLinks = BroxusAppLinks();
  StreamSubscription<Uri>? _linkSubscription;

  @disposeMethod
  void dispose() {
    _linkSubscription?.cancel();
  }

  void _handleAppLink(Uri uri) {
    final queryParameters = uri.queryParameters;

    final link = queryParameters[_linkKey];

    if (link != null) {
      _handleQueryLink(link);
    }
  }

  void _handleQueryLink(String link) {
    if (link.isEmpty) {
      return;
    }

    try {
      final uri = Uri.parse(link);

      behaviorBus
        ..fire(ChangeTabBottomNavigationEvent(RootTab.browser))
        ..fire(BrowserAppLinkUriEvent(uri));
    } catch (_) {}
  }
}
