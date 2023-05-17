import 'dart:convert';

import 'package:nekoton_repository/nekoton_repository.dart';

String fakeSignature() =>
    base64.encode(List.generate(signatureLength, (_) => 0));

extension KeyStoreEntryX on KeyStoreEntry {
  SignInput signInput(String password) => isLegacy
      ? EncryptedKeyPassword(
          publicKey: publicKey,
          password: Password.explicit(
            PasswordExplicit(
              password: password,
              cacheBehavior: const PasswordCacheBehavior.nop(),
            ),
          ),
        )
      : DerivedKeySignParams.byAccountId(
          DerivedKeySignParamsByAccountId(
            masterKey: masterKey,
            accountId: accountId,
            password: Password.explicit(
              PasswordExplicit(
                password: password,
                cacheBehavior: const PasswordCacheBehavior.nop(),
              ),
            ),
          ),
        );
}
