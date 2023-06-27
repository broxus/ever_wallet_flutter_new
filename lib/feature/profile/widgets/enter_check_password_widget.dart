import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/profile/widgets/widgets.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

/// Widget that allows enter password and check if it is correct for specified
/// public key.
class EnterCheckPasswordWidget extends StatelessWidget {
  const EnterCheckPasswordWidget({
    required this.publicKey,
    required this.onPasswordAccepted,
    super.key,
  });

  /// Key for which password should be checked
  final String publicKey;

  /// Callback that means, that password was checked and it is correct
  final ValueChanged<String> onPasswordAccepted;

  @override
  Widget build(BuildContext context) {
    return EnterPasswordWidget(
      onPasswordEntered: _checkPassword,
    );
  }

  Future<void> _checkPassword(String password) async {
    final correct = await inject<NekotonRepository>().seedList.checkKeyPassword(
          publicKey: publicKey,
          password: password,
          signatureId: await inject<TransportRepository>()
              .currentTransport
              .transport
              .getSignatureId(),
        );
    if (correct) {
      onPasswordAccepted(password);
    } else {
      inject<MessengerService>().show(
        Message.error(message: LocaleKeys.passwordIsWrong.tr()),
      );
    }
  }
}
