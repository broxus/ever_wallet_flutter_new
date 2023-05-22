import 'dart:convert';

import 'package:nekoton_repository/nekoton_repository.dart';

/// This is a fake signature string that can be used to check decrypt/encrypt
/// methods to verify that user entered correct password.
String fakeSignature() =>
    base64.encode(List.generate(signatureLength, (_) => 0));
