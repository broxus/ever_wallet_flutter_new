import 'dart:async';

import 'package:app/app/service/connection/data/connection_data/connection_data.dart';
import 'package:app/data/models/models.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:nekoton_webview/nekoton_webview.dart' show AddNetwork, Network;
import 'package:rxdart/rxdart.dart';

/// Exception that can be thrown during handling any callbacks.
class ApprovalsHandleException implements Exception {
  ApprovalsHandleException(this.message);

  final String message;
}

/// Service that is a middleware between browser callbacks and UI actions.
///
/// This methods must be called during handling browser events in
/// <InpageProvider> and could be waited as a normal function.
///
/// ```dart
/// Future<void> handler() async {
///   final permissions = await inject<BrowserApprovalsService>()
///       .requestPermissions(origin: url, permissions: [requested]);
/// }
/// ```
@singleton
class BrowserApprovalsService {
  final _approvalsSubject = PublishSubject<ApprovalRequest>();

  Stream<ApprovalRequest> get approvalsStream => _approvalsSubject;

  /// Request user for [permissions] for [origin].
  /// Action requires user agreement
  /// Typically, exception must be [ApprovalsHandleException] or [FrbException]
  Future<Permissions> requestPermissions({
    required Uri origin,
    required List<Permission> permissions,
  }) async {
    final completer = Completer<Permissions>();

    final request = ApprovalRequest.requestPermissions(
      origin: origin,
      permissions: permissions,
      completer: completer,
    );

    _approvalsSubject.add(request);

    return completer.future;
  }

  /// Ask user for permissions for any account in list of accounts active in
  /// scope of current selected PublicKey.
  /// Action requires user agreement
  /// Typically, exception must be [ApprovalsHandleException] or [FrbException]
  Future<Permissions> changeAccount({
    required Uri origin,
    required List<Permission> permissions,
    required Address? previousSelectedAccount,
  }) async {
    final completer = Completer<Permissions>();

    final request = ApprovalRequest.changeAccount(
      origin: origin,
      permissions: permissions,
      previousSelectedAccount: previousSelectedAccount,
      completer: completer,
    );

    _approvalsSubject.add(request);

    return completer.future;
  }

  /// Add token contract to account with address [accountAddress]
  /// Action requires user agreement
  /// Typically, exception must be [ApprovalsHandleException] or [FrbException]
  Future<void> addTip3Token({
    required Uri origin,
    required Address accountAddress,
    required TokenContractAsset details,
  }) async {
    final completer = Completer<void>();

    final request = ApprovalRequest.addTip3Token(
      origin: origin,
      account: accountAddress,
      details: details,
      completer: completer,
    );

    _approvalsSubject.add(request);

    return completer.future;
  }

  /// Ask user for password to make [SeedList.signData] for specified
  /// [publicKey].
  /// Returns password for [publicKey] or throw error.
  /// Typically, exception must be [ApprovalsHandleException] or [FrbException]
  Future<String> signData({
    required Uri origin,
    required Address account,
    required PublicKey publicKey,
    required String data,
  }) async {
    final completer = Completer<String>();

    final request = ApprovalRequest.signData(
      origin: origin,
      account: account,
      publicKey: publicKey,
      data: data,
      completer: completer,
    );

    _approvalsSubject.add(request);

    return completer.future;
  }

  /// Ask user for password to make [SeedList.encrypt] for specified
  /// [publicKey].
  /// Returns password for [publicKey] or throw error.
  /// Typically, exception must be [ApprovalsHandleException] or [FrbException]
  Future<String> encryptData({
    required Uri origin,
    required Address account,
    required PublicKey publicKey,
    required String data,
  }) async {
    final completer = Completer<String>();

    final request = ApprovalRequest.encryptData(
      origin: origin,
      account: account,
      publicKey: publicKey,
      data: data,
      completer: completer,
    );

    _approvalsSubject.add(request);

    return completer.future;
  }

  /// Ask user for password to make [SeedList.decrypt] for specified
  /// [recipientPublicKey].
  /// Returns password for [recipientPublicKey] or throw error.
  /// Typically, exception must be [ApprovalsHandleException] or [FrbException]
  Future<String> decryptData({
    required Uri origin,
    required Address account,
    required PublicKey recipientPublicKey,
    required PublicKey sourcePublicKey,
  }) async {
    final completer = Completer<String>();

    final request = ApprovalRequest.decryptData(
      origin: origin,
      account: account,
      recipientPublicKey: recipientPublicKey,
      sourcePublicKey: sourcePublicKey,
      completer: completer,
    );

    _approvalsSubject.add(request);

    return completer.future;
  }

  /// Ask user for password to make contract action for specified [publicKey]
  /// and [recipient].
  /// Returns password for [publicKey].
  /// Typically, exception must be [ApprovalsHandleException] or [FrbException]
  Future<String> callContractMethod({
    required Uri origin,
    required Address account,
    required PublicKey publicKey,
    required Address recipient,
    required FunctionCall payload,
  }) async {
    final completer = Completer<String>();

    final request = ApprovalRequest.callContractMethod(
      origin: origin,
      account: account,
      publicKey: publicKey,
      recipient: recipient,
      payload: payload,
      completer: completer,
    );

    _approvalsSubject.add(request);

    return completer.future;
  }

  /// Asks user to select publicKey and enter password to send funds from
  /// account [sender] to [recipient].
  /// Returns selected publicKey and password for it or throw error.
  /// Typically, exception must be [ApprovalsHandleException] or [FrbException]
  Future<(PublicKey, String)> sendMessage({
    required Uri origin,
    required Address sender,
    required Address recipient,
    required BigInt amount,
    required bool bounce,
    required FunctionCall? payload,
    required KnownPayload? knownPayload,
  }) async {
    final completer = Completer<(PublicKey, String)>();

    final request = ApprovalRequest.sendMessage(
      origin: origin,
      sender: sender,
      recipient: recipient,
      amount: amount,
      bounce: bounce,
      payload: payload,
      knownPayload: knownPayload,
      completer: completer,
    );

    _approvalsSubject.add(request);

    return completer.future;
  }

  /// Ask user's confirmation to change active network.
  /// Returns activated [TransportStrategy] or null.
  /// Typically, exception must be [ApprovalsHandleException] or [FrbException]
  Future<TransportStrategy?> changeNetwork({
    required Uri origin,
    required int networkId,
    required List<ConnectionData> connections,
  }) async {
    final completer = Completer<TransportStrategy?>();

    final request = ApprovalRequest.changeNetwork(
      origin: origin,
      networkId: networkId,
      connections: connections,
      completer: completer,
    );

    _approvalsSubject.add(request);

    return completer.future;
  }

  /// Ask user's confirmation to add network.
  /// Returns added [Network] or null.
  /// Typically, exception must be [ApprovalsHandleException] or [FrbException]
  Future<Network?> addNetwork({
    required Uri origin,
    required AddNetwork network,
    required bool switchNetwork,
  }) async {
    final completer = Completer<Network?>();

    final request = ApprovalRequest.addNetwork(
      origin: origin,
      network: network,
      switchNetwork: switchNetwork,
      completer: completer,
    );

    _approvalsSubject.add(request);

    return completer.future;
  }
}
