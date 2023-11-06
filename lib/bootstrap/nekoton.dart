import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

const _minSubscriptionsAtTime = 10;

Future<void> configureNekoton() async {
  final log = Logger('bootstrap')
    ..finest('NekotonRepository initializating...');

  final nekotonRepository = inject<NekotonRepository>()
    ..tonSubscribeAtTimeAmount = _minSubscriptionsAtTime
    ..tokenSubscribeAtTimeAmount = _minSubscriptionsAtTime;

  await nekotonRepository.setupNekotonAndStorage(
    storage: inject<NekotonStorageService>(),
    tonWalletStorage: inject<TonWalletStorageService>(),
    tokenWalletStorage: inject<TokenWalletStorageService>(),
  );

  inject<NtpService>().offsetStream.listen(nekotonRepository.updateClockOffset);

  log.finest('NekotonRepository initialized with storage!');
}
