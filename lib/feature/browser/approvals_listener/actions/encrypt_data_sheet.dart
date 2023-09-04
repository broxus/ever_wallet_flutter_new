import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Helper function that allows show sheet to ask user password to make
/// [SeedList.encrypt] action.
// ignore_for_file: avoid-unused-parameters
Future<String?> showEncryptDataSheet({
  required BuildContext context,
  required Uri origin,
  required PublicKey publicKey,
  required String data,
}) {
  return Future.value();
}
