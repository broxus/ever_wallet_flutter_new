import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Helper function that allows show sheet to ask user password and initiator
/// publicKey to make [TonWallet.send] action.
// ignore_for_file: avoid-unused-parameters
Future<(PublicKey, String)?> showSendMessageSheet({
  required BuildContext context,
  required Uri origin,
  required Address sender,
  required Address recipient,
  required BigInt amount,
  required bool bounce,
  required FunctionCall? payload,
  required KnownPayload? knownPayload,
}) {
  // TODO(alex-a4): make modal version of WalletPrepareTransferPage
  return Future.value();
}
