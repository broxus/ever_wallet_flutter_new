import 'dart:io';

import 'package:injectable/injectable.dart';

/// Service that makes pure http requests.
/// It's used in nekoton's <Transport> or it may be used in app anywhere.
@singleton
class DnsResolveService {
  final Set<String> _hosts = {};

  Future<bool> isResolvable(Uri uri) async {
    final host = uri.host;

    if (_hosts.contains(host)) {
      return true;
    }

    try {
      final result = await InternetAddress.lookup(host);
      final isResolved =
          result.isNotEmpty && result.first.rawAddress.isNotEmpty;
      if (isResolved) {
        _hosts.add(host);
      }

      return isResolved;
    } catch (e) {
      return false;
    }
  }
}
