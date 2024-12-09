import 'package:app/app/service/biometry_service.dart';
import 'package:app/app/service/current_seed_service.dart';
import 'package:app/app/service/messenger/message.dart';
import 'package:app/app/service/messenger/service/messenger_service.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:local_auth/local_auth.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';

class DeployWalletConfirmModel extends ElementaryModel {
  DeployWalletConfirmModel(
    ErrorHandler errorHandler,
    this.biometryService,
    this.nekotonRepository,
    this.currentSeedService,
    this.messengerService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository nekotonRepository;
  final BiometryService biometryService;
  final CurrentSeedService currentSeedService;
  final MessengerService messengerService;

  Seed? get currentSeed => currentSeedService.currentSeed;

  Seed? findSeed(PublicKey publicKey) =>
      nekotonRepository.seedList.findSeed(publicKey);

  Future<List<BiometricType>> getAvailableBiometry(PublicKey publicKey) async {
    final isBiometryEnabled = biometryService.isEnabled;
    final hasKeyPassword = await biometryService.hasKeyPassword(publicKey);

    if (isBiometryEnabled && hasKeyPassword) {
      return biometryService.getAvailableBiometry();
    }

    return [];
  }

  Future<String?> requestBiometry(PublicKey publicKey) async {
    try {
      final password = await biometryService.getKeyPassword(
        publicKey: publicKey,
        localizedReason: LocaleKeys.biometryAuthReason.tr(),
      );

      return password;
    } catch (_) {
      return null;
    }
  }

  void showValidateError(String message) {
    messengerService.show(
      Message.error(
        message: message,
        debounceTime: defaultInfoMessageDebounceDuration,
      ),
    );
  }
}
