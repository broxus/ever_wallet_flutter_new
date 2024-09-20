import 'package:app/app/service/service.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

class AddAccountConfirmModel extends ElementaryModel {
  AddAccountConfirmModel(
    ErrorHandler errorHandler,
    this._biometryService,
    this._messengerService,
    this._nekotonRepository,
  ) : super(errorHandler: errorHandler);

  final BiometryService _biometryService;
  final MessengerService _messengerService;
  final NekotonRepository _nekotonRepository;

  Future<List<BiometricType>> getAvailableBiometry(PublicKey publicKey) async {
    final seed = _nekotonRepository.seedList.findSeedByAnyPublicKey(publicKey);
    if (seed == null) return [];

    final isBiometryEnabled = _biometryService.enabled;
    final hasKeyPassword =
        await _biometryService.hasKeyPassword(seed.publicKey);

    if (isBiometryEnabled && hasKeyPassword) {
      return _biometryService.getAvailableBiometry();
    }

    return [];
  }

  Future<String?> requestBiometry(PublicKey publicKey) async {
    final seed = _nekotonRepository.seedList.findSeedByAnyPublicKey(publicKey);
    if (seed == null) return null;

    try {
      final password = await _biometryService.getKeyPassword(
        publicKey: seed.publicKey,
        localizedReason: LocaleKeys.biometryAuthReason.tr(),
      );

      return password;
    } catch (_) {
      return null;
    }
  }

  Future<bool> checkPassword({
    required String password,
    required PublicKey publicKey,
  }) async {
    if (password.isEmpty) return false;

    final list = _nekotonRepository.seedList;

    final correct = await list.checkKeyPassword(
      publicKey: publicKey,
      password: password,
      signatureId:
          await _nekotonRepository.currentTransport.transport.getSignatureId(),
    );

    if (_biometryService.enabled && correct) {
      await _biometryService.setKeyPassword(
        publicKey: publicKey,
        password: password,
      );
    }

    return correct;
  }

  void showWrongPassword(BuildContext context) {
    _messengerService.show(
      Message.error(context: context, message: LocaleKeys.passwordIsWrong.tr()),
    );
  }
}
