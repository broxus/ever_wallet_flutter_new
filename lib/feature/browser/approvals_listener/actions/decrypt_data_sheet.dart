import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Helper function that allows show sheet to ask user password for
/// [recipientPublicKey] to make [SeedList.decrypt] action.
// ignore_for_file: avoid-unused-parameters
Future<String?> showDecryptDataSheet({
  required BuildContext context,
  required Uri origin,
  required PublicKey recipientPublicKey,
  required PublicKey sourcePublicKey,
}) {
  return Future.value();
}
