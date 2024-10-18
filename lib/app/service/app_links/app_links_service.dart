import 'dart:async';

import 'package:app/app/service/app_links/app_links_data.dart';
import 'package:broxus_app_links/broxus_app_links.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@singleton
class AppLinksService {
  AppLinksService() {
    _linkSubscription = _appLinks.uriStream.listen(_handleAppLink);
  }

  static const _linkKey = 'link';

  final _appLinks = BroxusAppLinks();

  final _linksSubj = BehaviorSubject<AppLinksData>.seeded(EmptyAppLinksData());

  late final Stream<AppLinksData> linksStream = _linksSubj.stream;

  Stream<BrowserAppLinksData> get browserLinksStream => linksStream
      .where((data) => data is BrowserAppLinksData)
      .cast<BrowserAppLinksData>();

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
      _linksSubj.add(
        BrowserAppLinksData(
          Uri.parse(link),
        ),
      );
    } catch (_) {}
  }
}
