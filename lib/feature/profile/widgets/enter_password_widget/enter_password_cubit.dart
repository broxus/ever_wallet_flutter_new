// ignore_for_file: use_build_context_synchronously

import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:local_auth/local_auth.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

part 'enter_password_cubit.freezed.dart';
part 'enter_password_state.dart';

/// Cubit for widget that allows enter password.
/// This cubit adds biometry logic to widget.
///
/// Password must be entered to [publicKey].
///
/// This cubit pushes only valid password above.
class EnterPasswordCubit extends Cubit<EnterPasswordState> {
  EnterPasswordCubit(
    this.biometryService,
    this.nekotonRepository,
    this.publicKey,
  ) : super(const EnterPasswordState.initial());

  final PublicKey publicKey;
  final BiometryService biometryService;
  final NekotonRepository nekotonRepository;

  Future<void> init() async {
    final isBiometryEnabled = biometryService.enabled;

    if (isBiometryEnabled) {
      final isFace = await _isFaceBiometry();
      emit(EnterPasswordState.biometry(isFace: isFace));

      await _requestBiometry(isFace);
    } else {
      emit(const EnterPasswordState.password());
    }
  }

  /// User entered password, validate it and emit do next action.
  /// If biometry is enabled, save password to storage.
  Future<void> enterPassword(BuildContext context, String password) async {
    if (password.isEmpty) {
      _showWrongPassword(context);

      return;
    }

    final list = nekotonRepository.seedList;

    final correct = await list.checkKeyPassword(
      publicKey: publicKey,
      password: password,
      signatureId:
          await nekotonRepository.currentTransport.transport.getSignatureId(),
    );

    if (!correct) {
      _showWrongPassword(context);

      return;
    }

    if (biometryService.enabled) {
      await biometryService.setKeyPassword(
        publicKey: publicKey,
        password: password,
      );
    }

    emit(
      EnterPasswordState.entered(
        password: password,
        fromBiometry: false,
        isFaceBiometry: false,
      ),
    );
  }

  void _showWrongPassword(BuildContext context) {
    inject<MessengerService>().show(
      Message.error(
        context: context,
        message: LocaleKeys.passwordIsWrong.tr(),
      ),
    );
  }

  /// Returns true if face biometry is available, else fingerprint.
  Future<bool> _isFaceBiometry() async {
    final available = await biometryService.getAvailableBiometry();

    return available.contains(BiometricType.face);
  }

  Future<void> _requestBiometry(bool isFace) async {
    try {
      // If we get password from biometry, we suppose it is always valid.
      final password = await biometryService.getKeyPassword(
        publicKey: publicKey,
        localizedReason: LocaleKeys.biometryAuthReason.tr(),
      );
      emit(
        EnterPasswordState.entered(
          password: password,
          fromBiometry: true,
          isFaceBiometry: isFace,
        ),
      );
    } catch (_) {
      emit(const EnterPasswordState.password());
    }
  }
}
