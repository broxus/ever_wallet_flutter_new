import 'dart:async';

import 'package:app/app/service/connection/data/connection_data/connection_data.dart';
import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser/approvals_listener/approvals_listener.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:nekoton_webview/nekoton_webview.dart' show AddNetwork, Network;

/// UI-based listener, that listens for events from [BrowserApprovalsService]
/// and open dialogs/pages, specified for this actions, allowing user to
/// handle them.
/// This widget listen for events from all browser-tabs.
///
/// This listener handles requests and returns result to the completer, that
/// comes for request, sending this data to the caller function.
class ApprovalsListenerWidget extends StatefulWidget {
  const ApprovalsListenerWidget({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  State<ApprovalsListenerWidget> createState() =>
      _ApprovalsListenerWidgetState();
}

class _ApprovalsListenerWidgetState extends State<ApprovalsListenerWidget> {
  late final BrowserApprovalsService approvalsService = inject();
  StreamSubscription<dynamic>? _streamSubscription;

  @override
  // ignore: long-method
  void initState() {
    _streamSubscription = approvalsService.approvalsStream.listen(
      (request) => request.when(
        requestPermissions: (
          origin,
          permissions,
          completer,
        ) =>
            requestPermissions(
          context: context,
          origin: origin,
          permissions: permissions,
          completer: completer,
        ),
        changeAccount: (
          origin,
          permissions,
          previousSelectedAccount,
          completer,
        ) =>
            changeAccount(
          context: context,
          origin: origin,
          permissions: permissions,
          previousSelectedAccount: previousSelectedAccount,
          completer: completer,
        ),
        addTip3Token: (
          origin,
          account,
          details,
          completer,
        ) =>
            addTip3Token(
          context: context,
          origin: origin,
          account: account,
          details: details,
          completer: completer,
        ),
        signData: (
          origin,
          account,
          publicKey,
          data,
          completer,
        ) =>
            signData(
          context: context,
          origin: origin,
          account: account,
          publicKey: publicKey,
          data: data,
          completer: completer,
        ),
        encryptData: (
          origin,
          account,
          publicKey,
          data,
          completer,
        ) =>
            encryptData(
          context: context,
          origin: origin,
          account: account,
          publicKey: publicKey,
          data: data,
          completer: completer,
        ),
        decryptData: (
          origin,
          account,
          recipientPublicKey,
          sourcePublicKey,
          completer,
        ) =>
            decryptData(
          context: context,
          origin: origin,
          account: account,
          recipientPublicKey: recipientPublicKey,
          sourcePublicKey: sourcePublicKey,
          completer: completer,
        ),
        callContractMethod: (
          origin,
          account,
          publicKey,
          recipient,
          payload,
          completer,
        ) =>
            callContractMethod(
          context: context,
          origin: origin,
          account: account,
          publicKey: publicKey,
          recipient: recipient,
          payload: payload,
          completer: completer,
        ),
        sendMessage: (
          origin,
          sender,
          recipient,
          amount,
          bounce,
          payload,
          knownPayload,
          completer,
        ) =>
            sendMessage(
          context: context,
          origin: origin,
          sender: sender,
          recipient: recipient,
          amount: amount,
          bounce: bounce,
          payload: payload,
          knownPayload: knownPayload,
          completer: completer,
        ),
        changeNetwork: (
          origin,
          networkId,
          connections,
          completer,
        ) =>
            changeNetwork(
          context: context,
          origin: origin,
          networkId: networkId,
          connections: connections,
          completer: completer,
        ),
        addNetwork: (
          Uri origin,
          AddNetwork network,
          bool switchNetwork,
          Completer<Network?> completer,
        ) =>
            addNetwork(
          context: context,
          origin: origin,
          network: network,
          switchNetwork: switchNetwork,
          completer: completer,
        ),
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;

  /// Check existing current accounts and current key for some approval requests
  ///
  /// If there is no some data, ApprovalsHandleException will be thrown
  /// and dialog to add account will be shown if possible.
  void checkCurrentAccountsAndKey(BuildContext context) {
    final accounts = inject<CurrentAccountsService>().currentAccounts;

    if (accounts == null || accounts.allAccounts.isEmpty) {
      final currentKey = inject<CurrentKeyService>().currentKey;

      if (currentKey == null) {
        throw ApprovalsHandleException(LocaleKeys.noCurrentKey.tr());
      }

      if (context.mounted) {
        unawaited(
          showAddNewLocalAccountSheet(context: context, publicKey: currentKey),
        );
      }

      throw ApprovalsHandleException(LocaleKeys.noAccountsYet.tr());
    }
  }

  Future<void> requestPermissions({
    required BuildContext context,
    required Uri origin,
    required List<Permission> permissions,
    required Completer<Permissions> completer,
  }) async {
    try {
      checkCurrentAccountsAndKey(context);

      final result = await showRequestPermissionsSheet(
        context: context,
        origin: origin,
        permissions: permissions,
      );

      if (result != null) {
        completer.complete(result);
      } else {
        throw ApprovalsHandleException(LocaleKeys.notGranted.tr());
      }
    } catch (err, st) {
      completer.completeError(err, st);
    }
  }

  Future<void> changeAccount({
    required BuildContext context,
    required Uri origin,
    required List<Permission> permissions,
    required Address? previousSelectedAccount,
    required Completer<Permissions> completer,
  }) async {
    try {
      checkCurrentAccountsAndKey(context);

      final result = await showChangeAccountSheet(
        context: context,
        permissions: permissions,
        origin: origin,
        previousSelectedAccount: previousSelectedAccount,
      );

      if (result != null) {
        completer.complete(result);
      } else {
        throw ApprovalsHandleException(LocaleKeys.notGranted.tr());
      }
    } catch (err, st) {
      completer.completeError(err, st);
    }
  }

  Future<void> addTip3Token({
    required BuildContext context,
    required Uri origin,
    required Address account,
    required TokenContractAsset details,
    required Completer<void> completer,
  }) async {
    try {
      final result = await showAddTip3TokenSheet(
        context: context,
        origin: origin,
        account: account,
        details: details,
      );

      if (result) {
        completer.complete();
      } else {
        throw ApprovalsHandleException(LocaleKeys.notGranted.tr());
      }
    } catch (err, st) {
      completer.completeError(err, st);
    }
  }

  Future<void> signData({
    required BuildContext context,
    required Uri origin,
    required Address account,
    required PublicKey publicKey,
    required String data,
    required Completer<String> completer,
  }) async {
    try {
      final result = await showSignDataSheet(
        context: context,
        origin: origin,
        account: account,
        publicKey: publicKey,
        data: data,
      );

      if (result != null) {
        completer.complete(result);
      } else {
        throw ApprovalsHandleException(LocaleKeys.noPassword.tr());
      }
    } catch (err, st) {
      completer.completeError(err, st);
    }
  }

  Future<void> encryptData({
    required BuildContext context,
    required Uri origin,
    required Address account,
    required PublicKey publicKey,
    required String data,
    required Completer<String> completer,
  }) async {
    try {
      final result = await showEncryptDataSheet(
        context: context,
        origin: origin,
        account: account,
        publicKey: publicKey,
        data: data,
      );

      if (result != null) {
        completer.complete(result);
      } else {
        throw ApprovalsHandleException(LocaleKeys.noPassword.tr());
      }
    } catch (err, st) {
      completer.completeError(err, st);
    }
  }

  Future<void> decryptData({
    required BuildContext context,
    required Uri origin,
    required Address account,
    required PublicKey recipientPublicKey,
    required PublicKey sourcePublicKey,
    required Completer<String> completer,
  }) async {
    try {
      final result = await showDecryptDataSheet(
        context: context,
        origin: origin,
        account: account,
        recipientPublicKey: recipientPublicKey,
        sourcePublicKey: sourcePublicKey,
      );

      if (result != null) {
        completer.complete(result);
      } else {
        throw ApprovalsHandleException(LocaleKeys.noPassword.tr());
      }
    } catch (err, st) {
      completer.completeError(err, st);
    }
  }

  Future<void> callContractMethod({
    required BuildContext context,
    required Uri origin,
    required Address account,
    required PublicKey publicKey,
    required Address recipient,
    required FunctionCall payload,
    required Completer<String> completer,
  }) async {
    try {
      final result = await showCallContractMethodSheet(
        context: context,
        origin: origin,
        account: account,
        publicKey: publicKey,
        recipient: recipient,
        payload: payload,
      );

      if (result != null) {
        completer.complete(result);
      } else {
        throw ApprovalsHandleException(LocaleKeys.noPassword.tr());
      }
    } catch (err, st) {
      completer.completeError(err, st);
    }
  }

  Future<void> sendMessage({
    required BuildContext context,
    required Uri origin,
    required Address sender,
    required Address recipient,
    required BigInt amount,
    required bool bounce,
    required FunctionCall? payload,
    required KnownPayload? knownPayload,
    required Completer<(PublicKey, String)> completer,
  }) async {
    try {
      final result = await showSendMessageSheet(
        context: context,
        origin: origin,
        sender: sender,
        recipient: recipient,
        amount: amount,
        bounce: bounce,
        payload: payload,
        knownPayload: knownPayload,
      );

      if (result != null) {
        completer.complete(result);
      } else {
        throw ApprovalsHandleException(LocaleKeys.noPassword.tr());
      }
    } catch (err, st) {
      completer.completeError(err, st);
    }
  }

  Future<void> changeNetwork({
    required BuildContext context,
    required Uri origin,
    required int networkId,
    required List<ConnectionData> connections,
    required Completer<TransportStrategy?> completer,
  }) async {
    try {
      final result = await showChangeNetworkSheet(
        context: context,
        origin: origin,
        networkId: networkId,
        connections: connections,
      );

      completer.complete(result);
    } catch (err, st) {
      completer.completeError(err, st);
    }
  }

  Future<void> addNetwork({
    required BuildContext context,
    required Uri origin,
    required AddNetwork network,
    required bool switchNetwork,
    required Completer<Network?> completer,
  }) async {
    try {
      final result = await showAddNetworkSheet(
        context: context,
        origin: origin,
        network: network,
        switchNetwork: switchNetwork,
      );

      completer.complete(result);
    } catch (err, st) {
      completer.completeError(err, st);
    }
  }
}
