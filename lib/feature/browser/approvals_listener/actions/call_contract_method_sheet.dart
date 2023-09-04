import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Helper function that allows show sheet to ask user password to make
/// [GenericContract.send] action.
// ignore_for_file: avoid-unused-parameters
Future<String?> showCallContractMethodSheet({
  required BuildContext context,
  required Uri origin,
  required PublicKey publicKey,
  required Address recipient,
  required FunctionCall payload,
}) {
  return Future.value();
}
