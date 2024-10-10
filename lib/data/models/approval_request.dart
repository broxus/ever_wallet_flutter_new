import 'dart:async';

import 'package:app/data/models/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:nekoton_webview/nekoton_webview.dart' show AddNetwork, Network;

part 'approval_request.freezed.dart';

@freezed
class ApprovalRequest with _$ApprovalRequest {
  const factory ApprovalRequest.requestPermissions({
    required Uri origin,
    required List<Permission> permissions,
    required Completer<Permissions> completer,
  }) = _RequestPermissions;

  const factory ApprovalRequest.changeAccount({
    required Uri origin,
    required List<Permission> permissions,
    required Address? previousSelectedAccount,
    required Completer<Permissions> completer,
  }) = _ChangeAccount;

  const factory ApprovalRequest.addTip3Token({
    required Uri origin,
    required Address account,
    required TokenContractAsset details,
    required Completer<void> completer,
  }) = _AddTip3Token;

  const factory ApprovalRequest.signData({
    required Uri origin,
    required Address account,
    required PublicKey publicKey,
    required String data,
    required Completer<String> completer,
  }) = _SignData;

  const factory ApprovalRequest.encryptData({
    required Uri origin,
    required Address account,
    required PublicKey publicKey,
    required String data,
    required Completer<String> completer,
  }) = _EncryptData;

  const factory ApprovalRequest.decryptData({
    required Uri origin,
    required Address account,
    required PublicKey recipientPublicKey,
    required PublicKey sourcePublicKey,
    required Completer<String> completer,
  }) = _DecryptData;

  const factory ApprovalRequest.callContractMethod({
    required Uri origin,
    required Address account,
    required PublicKey publicKey,
    required Address recipient,
    required FunctionCall payload,
    required Completer<String> completer,
  }) = _CallContractMethod;

  const factory ApprovalRequest.sendMessage({
    required Uri origin,
    required Address sender,
    required Address recipient,
    @amountJsonConverter required BigInt amount,
    required bool bounce,
    required FunctionCall? payload,
    required KnownPayload? knownPayload,
    required Completer<(PublicKey, String)> completer,
  }) = _SendMessage;

  const factory ApprovalRequest.changeNetwork({
    required Uri origin,
    required int networkId,
    required List<ConnectionData> connections,
    required Completer<TransportStrategy?> completer,
  }) = _ChangeNetwork;

  const factory ApprovalRequest.addNetwork({
    required Uri origin,
    required AddNetwork network,
    required bool switchNetwork,
    required Completer<Network?> completer,
  }) = _AddNetwork;
}
