import 'dart:io';

import 'package:app/app/service/nekoton_related/connection_service/connection_service.dart';
import 'package:app/di/di.dart';
import 'package:flutter/widgets.dart';
import 'package:http_proxy/http_proxy.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

Future<void> configureConnectionService() async {
  final log = Logger('bootstrap')
    ..finest('ConnectionService initializating...');

  // TODO(nesquikm): Theoretically, this should be called every time after app
  // returns from background.
  await _configureProxy();

  final service = inject<ConnectionService>();
  await service.setUp();

  log.finest('NekotonRepository start SeedList listening');
  // start listening only after transport initialized
  inject<NekotonRepository>().setupSeedListUpdating();
  log.finest('ConnectionService initialized');
}

/// Configure proxy for http requests
Future<void> _configureProxy() async {
  WidgetsFlutterBinding.ensureInitialized();
  final httpProxy = await HttpProxy.createHttpProxy();
  HttpOverrides.global = httpProxy;
}
