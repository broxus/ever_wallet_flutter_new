import 'dart:async';

import 'package:app/data/models/models.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

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
  Future<Permissions> changeAccount({
    required Uri origin,
    required List<Permission> permissions,
  }) async {
    final completer = Completer<Permissions>();

    final request = ApprovalRequest.changeAccount(
      origin: origin,
      permissions: permissions,
      completer: completer,
    );

    _approvalsSubject.add(request);

    return completer.future;
  }

  /// Add token contract to account with address [accountAddress]
  /// Action requires user agreement
  Future<void> addTip3Token({
    required Uri origin,
    required Address accountAddress,
    required RootTokenContractDetails details,
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
  Future<String> signData({
    required Uri origin,
    required PublicKey publicKey,
    required String data,
  }) async {
    final completer = Completer<String>();

    final request = ApprovalRequest.signData(
      origin: origin,
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
  Future<String> encryptData({
    required Uri origin,
    required PublicKey publicKey,
    required String data,
  }) async {
    final completer = Completer<String>();

    final request = ApprovalRequest.encryptData(
      origin: origin,
      publicKey: publicKey,
      data: data,
      completer: completer,
    );

    _approvalsSubject.add(request);

    return completer.future;
  }

  /// Ask user for password to make [SeedList.decrypt] for specified
  /// [publicKey].
  /// Returns password for [publicKey] or throw error.
  Future<String> decryptData({
    required Uri origin,
    required PublicKey publicKey,
    required PublicKey sourcePublicKey,
  }) async {
    final completer = Completer<String>();

    final request = ApprovalRequest.decryptData(
      origin: origin,
      publicKey: publicKey,
      sourcePublicKey: sourcePublicKey,
      completer: completer,
    );

    _approvalsSubject.add(request);

    return completer.future;
  }

  /// Ask user for password to make contract action for specified [publicKey]
  /// and [recipient].
  /// Returns password for [publicKey].
  Future<String> callContractMethod({
    required Uri origin,
    required PublicKey publicKey,
    required Address recipient,
    required FunctionCall payload,
  }) async {
    final completer = Completer<String>();

    final request = ApprovalRequest.callContractMethod(
      origin: origin,
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
}
