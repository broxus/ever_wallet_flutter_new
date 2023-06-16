import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:collection/collection.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

Future<void> configureNekoton() async {
  final log = Logger('bootstrap')
    ..finest('NekotonRepository initializating...');

  final nekotonRepository = inject<NekotonRepository>();

  await nekotonRepository.setupNekotonAndStorage(
    storage: inject<NekotonStorageService>(),
  );
  log
    ..finest('NekotonRepository initialized with storage!')
    ..finest('NekotonRepository migrate seed names...');

  final storage = inject<NekotonStorageService>();

  if (!await storage.isSeedNamesMigrated) {
    final keys = nekotonRepository.keyStore.keys;
    for (final entry in storage.seeds.entries) {
      final foundKey = keys.firstWhereOrNull((k) => k.publicKey == entry.key);
      if (foundKey == null) continue;

      await nekotonRepository.renameKey(
        publicKey: entry.key,
        masterKey: entry.key,
        name: entry.value,
        isLegacy: foundKey.isLegacy,
      );
    }
    await storage.saveIsSeedNamesMigrated();
  }

  log.finest('NekotonRepository seed names migration completed!');
}
