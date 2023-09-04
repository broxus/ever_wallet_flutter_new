import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_webview/nekoton_webview.dart' hide Message;

class InpageProvider extends ProviderApi {
  InpageProvider(this.approvalsService);

  final _logger = Logger('InpageProvider');

  InAppWebViewController? controller;
  final BrowserApprovalsService approvalsService;

  Uri? url;

  @override
  FutureOr<AddAssetOutput> addAsset(AddAssetInput input) {
    // TODO: implement addAsset
    throw UnimplementedError();
  }

  @override
  FutureOr<PermissionsPartial> changeAccount() async {
    try {
      final existingPermissions = inject<PermissionsService>().permissions[url];
      if (existingPermissions?.accountInteraction == null) {
        throw ApprovalsHandleException(
          LocaleKeys.accountInteractionNotPermitted.tr(),
        );
      }

      final existingPermissionsList = [
        if (existingPermissions?.basic == null) Permission.basic,
        if (existingPermissions?.accountInteraction == null)
          Permission.accountInteraction,
      ];

      final permissions = await approvalsService.changeAccount(
        origin: url!,
        permissions: existingPermissionsList,
      );

      final accountInteraction = permissions.accountInteraction;

      return PermissionsPartial(
        permissions.basic,
        accountInteraction == null
            ? null
            : PermissionsAccountInteraction(
                accountInteraction.address.address,
                accountInteraction.publicKey.publicKey,
                accountInteraction.contractType.name,
              ),
      );
    } on ApprovalsHandleException catch (e) {
      inject<MessengerService>().show(Message.error(message: e.message));
      rethrow;
    }
  }

  @override
  FutureOr<CodeToTvcOutput> codeToTvc(CodeToTvcInput input) {
    // TODO: implement codeToTvc
    throw UnimplementedError();
  }

  @override
  FutureOr<DecodeEventOutput?> decodeEvent(DecodeEventInput input) {
    // TODO: implement decodeEvent
    throw UnimplementedError();
  }

  @override
  FutureOr<DecodeInputOutput?> decodeInput(DecodeInputInput input) {
    // TODO: implement decodeInput
    throw UnimplementedError();
  }

  @override
  FutureOr<DecodeOutputOutput?> decodeOutput(DecodeOutputInput input) {
    // TODO: implement decodeOutput
    throw UnimplementedError();
  }

  @override
  FutureOr<DecodeTransactionOutput?> decodeTransaction(
    DecodeTransactionInput input,
  ) {
    // TODO: implement decodeTransaction
    throw UnimplementedError();
  }

  @override
  FutureOr<DecodeTransactionEventsOutput> decodeTransactionEvents(
    DecodeTransactionEventsInput input,
  ) {
    // TODO: implement decodeTransactionEvents
    throw UnimplementedError();
  }

  @override
  FutureOr<DecryptDataOutput> decryptData(DecryptDataInput input) {
    // TODO: implement decryptData
    throw UnimplementedError();
  }

  @override
  FutureOr<void> disconnect() {
    // TODO: implement disconnect
    throw UnimplementedError();
  }

  @override
  FutureOr<EncodeInternalInputOutput> encodeInternalInput(FunctionCall input) {
    // TODO: implement encodeInternalInput
    throw UnimplementedError();
  }

  @override
  FutureOr<EncryptDataOutput> encryptData(EncryptDataInput input) {
    // TODO: implement encryptData
    throw UnimplementedError();
  }

  @override
  FutureOr<EstimateFeesOutput> estimateFees(EstimateFeesInput input) {
    // TODO: implement estimateFees
    throw UnimplementedError();
  }

  @override
  FutureOr<ExecuteLocalOutput> executeLocal(ExecuteLocalInput input) {
    // TODO: implement executeLocal
    throw UnimplementedError();
  }

  @override
  FutureOr<ExtractPublicKeyOutput> extractPublicKey(
    ExtractPublicKeyInput input,
  ) {
    // TODO: implement extractPublicKey
    throw UnimplementedError();
  }

  @override
  FutureOr<FindTransactionOutput> findTransaction(FindTransactionInput input) {
    // TODO: implement findTransaction
    throw UnimplementedError();
  }

  @override
  FutureOr<GetAccountsByCodeHashOutput> getAccountsByCodeHash(
    GetAccountsByCodeHashInput input,
  ) {
    // TODO: implement getAccountsByCodeHash
    throw UnimplementedError();
  }

  @override
  FutureOr<GetBocHashOutput> getBocHash(GetBocHashInput input) {
    // TODO: implement getBocHash
    throw UnimplementedError();
  }

  @override
  FutureOr<GetCodeSaltOutput> getCodeSalt(GetCodeSaltInput input) {
    // TODO: implement getCodeSalt
    throw UnimplementedError();
  }

  @override
  FutureOr<GetContractFieldsOutput> getContractFields(
    GetContractFieldsInput input,
  ) {
    // TODO: implement getContractFields
    throw UnimplementedError();
  }

  @override
  FutureOr<GetExpectedAddressOutput> getExpectedAddress(
    GetExpectedAddressInput input,
  ) {
    // TODO: implement getExpectedAddress
    throw UnimplementedError();
  }

  @override
  FutureOr<GetFullContractStateOutput> getFullContractState(
    GetFullContractStateInput input,
  ) {
    // TODO: implement getFullContractState
    throw UnimplementedError();
  }

  @override
  FutureOr<GetProviderStateOutput> getProviderState() {
    // TODO: implement getProviderState

    return GetProviderStateOutput.fromJson(
      {
        'version': '0.3.0',
        // ignore: no-magic-number
        'numericVersion': 3000,
        'networkId': 1,
        'selectedConnection': 'mainnet',
        'supportedPermissions': ['basic', 'accountInteraction'],
        'subscriptions': <String, Object>{},
        'permissions': <String, Object>{},
      },
    );
  }

  @override
  FutureOr<GetTransactionOutput> getTransaction(GetTransactionInput input) {
    // TODO: implement getTransaction
    throw UnimplementedError();
  }

  @override
  FutureOr<GetTransactionsOutput> getTransactions(GetTransactionsInput input) {
    // TODO: implement getTransactions
    throw UnimplementedError();
  }

  @override
  FutureOr<MergeTvcOutput> mergeTvc(MergeTvcInput input) {
    // TODO: implement mergeTvc
    throw UnimplementedError();
  }

  @override
  FutureOr<PackIntoCellOutput> packIntoCell(PackIntoCellInput input) {
    // TODO: implement packIntoCell
    throw UnimplementedError();
  }

  @override
  FutureOr<PermissionsPartial> requestPermissions(
    RequestPermissionsInput input,
  ) async {
    final requiredPermissions = input.permissions
        .map((e) => Permission.values.firstWhere((per) => per.name == e))
        .toList();
    final existingPermissions = inject<PermissionsService>().permissions[url];

    Permissions permissions;

    try {
      if (existingPermissions != null) {
        final newPermissions = [
          if (requiredPermissions.contains(Permission.basic) &&
              existingPermissions.basic == null)
            Permission.basic,
          if (requiredPermissions.contains(Permission.accountInteraction) &&
              existingPermissions.accountInteraction == null)
            Permission.accountInteraction,
        ];

        if (newPermissions.isNotEmpty) {
          permissions = await approvalsService.requestPermissions(
            origin: url!,
            permissions: requiredPermissions,
          );
        } else {
          permissions = existingPermissions;
        }
      } else {
        permissions = await approvalsService.requestPermissions(
          origin: url!,
          permissions: requiredPermissions,
        );
      }

      final accountInteraction = permissions.accountInteraction;

      return PermissionsPartial(
        permissions.basic,
        accountInteraction == null
            ? null
            : PermissionsAccountInteraction(
                accountInteraction.address.address,
                accountInteraction.publicKey.publicKey,
                accountInteraction.contractType.name,
              ),
      );
    } on ApprovalsHandleException catch (e) {
      inject<MessengerService>().show(Message.error(message: e.message));
      rethrow;
    }
  }

  @override
  FutureOr<RunLocalOutput> runLocal(RunLocalInput input) {
    // TODO: implement runLocal
    throw UnimplementedError();
  }

  @override
  FutureOr<SendExternalMessageOutput> sendExternalMessage(
    SendExternalMessageInput input,
  ) {
    // TODO: implement sendExternalMessage
    throw UnimplementedError();
  }

  @override
  FutureOr<SendExternalMessageDelayedOutput> sendExternalMessageDelayed(
    SendExternalMessageDelayedInput input,
  ) {
    // TODO: implement sendExternalMessageDelayed
    throw UnimplementedError();
  }

  @override
  FutureOr<SendMessageOutput> sendMessage(SendMessageInput input) {
    // TODO: implement sendMessage
    throw UnimplementedError();
  }

  @override
  FutureOr<SendMessageDelayedOutput> sendMessageDelayed(
    SendMessageDelayedInput input,
  ) {
    // TODO: implement sendMessageDelayed
    throw UnimplementedError();
  }

  @override
  FutureOr<SendUnsignedExternalMessageOutput> sendUnsignedExternalMessage(
    SendUnsignedExternalMessageInput input,
  ) {
    // TODO: implement sendUnsignedExternalMessage
    throw UnimplementedError();
  }

  @override
  FutureOr<SetCodeSaltOutput> setCodeSalt(SetCodeSaltInput input) {
    // TODO: implement setCodeSalt
    throw UnimplementedError();
  }

  @override
  FutureOr<SignDataOutput> signData(SignDataInput input) {
    // TODO: implement signData
    throw UnimplementedError();
  }

  @override
  FutureOr<SignDataRawOutput> signDataRaw(SignDataRawInput input) {
    // TODO: implement signDataRaw
    throw UnimplementedError();
  }

  @override
  FutureOr<SplitTvcOutput> splitTvc(SplitTvcInput input) {
    // TODO: implement splitTvc
    throw UnimplementedError();
  }

  @override
  FutureOr<ContractUpdatesSubscription> subscribe(SubscribeInput input) {
    // TODO: implement subscribe
    throw UnimplementedError();
  }

  @override
  FutureOr<UnpackFromCellOutput> unpackFromCell(UnpackFromCellInput input) {
    // TODO: implement unpackFromCell
    throw UnimplementedError();
  }

  @override
  FutureOr<UnpackInitDataOutput> unpackInitData(UnpackInitDataInput input) {
    // TODO: implement unpackInitData
    throw UnimplementedError();
  }

  @override
  FutureOr<void> unsubscribe(UnsubscribeInput input) {
    // TODO: implement unsubscribe
    throw UnimplementedError();
  }

  @override
  FutureOr<void> unsubscribeAll() {
    // TODO: implement unsubscribeAll
    throw UnimplementedError();
  }

  @override
  FutureOr<VerifySignatureOutput> verifySignature(VerifySignatureInput input) {
    // TODO: implement verifySignature
    throw UnimplementedError();
  }

  @override
  dynamic call(String method, dynamic params) {
    _logger.finest('method: $method, params: $params');
    return super.call(method, params);
  }
}
