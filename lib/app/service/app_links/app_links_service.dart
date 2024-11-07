import 'dart:async';
import 'dart:convert';

import 'package:app/app/service/app_links/app_links_data.dart';
import 'package:app/app/service/ton/ton_service.dart';
import 'package:app_links/app_links.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@singleton
class AppLinksService {
  AppLinksService(
    this._tonService,
  ) {
    _linkSubscription = _appLinks.uriLinkStream.listen(_handleAppLink);
  }

  static const _linkKey = 'link';

  final TonService _tonService;

  final _appLinks = AppLinks();

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

    final scheme = uri.scheme;

    switch (scheme) {
      case 'http':
      case 'https':
        if (link != null) {
          _handleQueryLink(link);
          break;
        }
      case 'tc':
        _handleTonConnect(uri);
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

  void _handleTonConnect(Uri uri) {
    final rawManifest = uri.queryParameters['r'];
    if (rawManifest == null) {
      return;
    }

    final decodedManifest = Uri.decodeComponent(rawManifest);
    final manifestData = jsonDecode(decodedManifest) as Map<String, dynamic>;

    final manifestUrl = manifestData['manifestUrl'] as String?;

    if (manifestUrl == null) {
      return;
    }

    _tonService.createAndConnect(manifestUrl);
  }
}
