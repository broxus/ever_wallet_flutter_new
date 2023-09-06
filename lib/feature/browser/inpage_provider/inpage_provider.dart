import 'dart:async';

import 'package:app/app/service/service.dart' as s;
import 'package:app/data/models/models.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:collection/collection.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart' as nr;
import 'package:nekoton_webview/nekoton_webview.dart' hide Message;

class InpageProvider extends ProviderApi {
  InpageProvider(
    this.approvalsService,
    this.permissionsService,
    this.nekotonRepository,
  );

  final _logger = Logger('InpageProvider');

  InAppWebViewController? controller;
  final s.BrowserApprovalsService approvalsService;
  final s.PermissionsService permissionsService;
  final nr.NekotonRepository nekotonRepository;

  Uri? url;

  /// Check [permissions] if it contains [basic] (if true) and [account]
  /// (if true) and if accountInteraction.address == accountAddress if it's
  /// specified.
  /// This is just a helper function for actions to check permissions, required
  /// for this action.
  /// [basic] needs everywhere by default (except of getting info about
  /// provider)
  ///
  /// Method do not return anything. If some required permission not granted,
  /// exception will be thrown.
  void _checkPermissions({
    required Permissions? permissions,
    bool basic = true,
    bool account = false,
    nr.Address? accountAddress,
    nr.PublicKey? publicKey,
  }) {
    if (permissions == null) {
      throw s.ApprovalsHandleException(LocaleKeys.permissionsNotGranted.tr());
    }
    if (basic && permissions.basic != true) {
      throw s.ApprovalsHandleException(
        LocaleKeys.basicInteractionNotPermitted.tr(),
      );
    }
    if (account && permissions.accountInteraction == null) {
      throw s.ApprovalsHandleException(
        LocaleKeys.accountInteractionNotPermitted.tr(),
      );
    }
    if (account &&
        accountAddress != null &&
        permissions.accountInteraction?.address != accountAddress) {
      throw s.ApprovalsHandleException(
        LocaleKeys.specifiedAccountInteractionNotPermitted.tr(),
      );
    }
    if (account &&
        publicKey != null &&
        permissions.accountInteraction?.publicKey != publicKey) {
      throw s.ApprovalsHandleException(
        LocaleKeys.specifiedSignerIsNotPermitted.tr(),
      );
    }
  }

  @override
  Future<AddAssetOutput> addAsset(AddAssetInput input) async {
    final accountAddress = nr.Address(address: input.account);
    _checkPermissions(
      permissions: permissionsService.getPermissions(url),
      account: true,
      accountAddress: accountAddress,
    );

    final type = assetTypeMap[input.type];
    final contract = input.params?.rootContract;
    final account =
        nekotonRepository.seedList.findAccountByAddress(accountAddress);
    if (contract == null) {
      throw Exception(LocaleKeys.invalidRootTokenContract.tr());
    }
    if (account == null) throw Exception(LocaleKeys.accountNotFound.tr());
    if (type == null) throw Exception(LocaleKeys.typeIsWrong.tr());

    bool newAsset;

    switch (type) {
      case AssetType.tip3Token:
        final rootTokenContract = await nr.repackAddress(
          nr.Address(address: contract),
        );
        final transport = nekotonRepository.currentTransport;

        final hasTokenWallet = account
                .additionalAssets[transport.transport.group]?.tokenWallets
                .any((e) => e.rootTokenContract == rootTokenContract) ??
            false;

        if (hasTokenWallet) {
          newAsset = false;
          break;
        }

        final details = await inject<s.AssetsService>().getTokenContractAsset(
          rootTokenContract,
          transport,
        );
        if (details == null) {
          throw Exception(LocaleKeys.invalidRootTokenContract.tr());
        }

        await approvalsService.addTip3Token(
          origin: url!,
          accountAddress: accountAddress,
          details: details,
        );

        await account.addTokenWallet(rootTokenContract);

        newAsset = true;
    }

    return AddAssetOutput(newAsset);
  }

  @override
  Future<PermissionsPartial> changeAccount() async {
    final existingPermissions = permissionsService.getPermissions(url);
    _checkPermissions(permissions: existingPermissions, account: true);

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
  }

  @override
  Future<CodeToTvcOutput> codeToTvc(CodeToTvcInput input) {
    // TODO: implement codeToTvc
    throw UnimplementedError();
  }

  @override
  Future<DecodeEventOutput?> decodeEvent(DecodeEventInput input) {
    // TODO: implement decodeEvent
    throw UnimplementedError();
  }

  @override
  Future<DecodeInputOutput?> decodeInput(DecodeInputInput input) {
    // TODO: implement decodeInput
    throw UnimplementedError();
  }

  @override
  Future<DecodeOutputOutput?> decodeOutput(DecodeOutputInput input) {
    // TODO: implement decodeOutput
    throw UnimplementedError();
  }

  @override
  Future<DecodeTransactionOutput?> decodeTransaction(
    DecodeTransactionInput input,
  ) {
    // TODO: implement decodeTransaction
    throw UnimplementedError();
  }

  @override
  Future<DecodeTransactionEventsOutput> decodeTransactionEvents(
    DecodeTransactionEventsInput input,
  ) {
    // TODO: implement decodeTransactionEvents
    throw UnimplementedError();
  }

  @override
  Future<DecryptDataOutput> decryptData(DecryptDataInput input) async {
    final publicKey = nr.PublicKey(
      publicKey: input.encryptedData.recipientPublicKey,
    );
    final sourceKey = nr.PublicKey(
      publicKey: input.encryptedData.sourcePublicKey,
    );
    _checkPermissions(
      permissions: permissionsService.getPermissions(url),
      account: true,
      publicKey: publicKey,
    );

    final password = await approvalsService.decryptData(
      origin: url!,
      recipientPublicKey: publicKey,
      sourcePublicKey: sourceKey,
    );
    final algorithm = nr.EncryptionAlgorithm.values.firstWhereOrNull(
      (alg) => alg.toString() == input.encryptedData.algorithm,
    );

    if (algorithm == null) {
      throw s.ApprovalsHandleException(LocaleKeys.unsupportedAlgorithm.tr());
    }

    final decryptedData = await nekotonRepository.seedList.decrypt(
      publicKey: publicKey,
      password: password,
      data: nr.EncryptedData(
        algorithm: algorithm,
        data: input.encryptedData.data,
        nonce: input.encryptedData.nonce,
        sourcePublicKey: sourceKey,
        recipientPublicKey: publicKey,
      ),
    );

    return DecryptDataOutput(decryptedData);
  }

  @override
  Future<void> disconnect() {
    // TODO: implement disconnect
    throw UnimplementedError();
  }

  @override
  Future<EncodeInternalInputOutput> encodeInternalInput(FunctionCall input) {
    // TODO: implement encodeInternalInput
    throw UnimplementedError();
  }

  @override
  Future<EncryptDataOutput> encryptData(EncryptDataInput input) async {
    final publicKey = nr.PublicKey(publicKey: input.publicKey);
    _checkPermissions(
      permissions: permissionsService.getPermissions(url),
      account: true,
      publicKey: publicKey,
    );

    final password = await approvalsService.encryptData(
      origin: url!,
      publicKey: publicKey,
      data: input.data,
    );
    final algorithm = nr.EncryptionAlgorithm.values
        .firstWhereOrNull((alg) => alg.toString() == input.algorithm);

    if (algorithm == null) {
      throw s.ApprovalsHandleException(LocaleKeys.unsupportedAlgorithm.tr());
    }

    final encryptedData = await nekotonRepository.seedList.encrypt(
      data: input.data,
      publicKey: publicKey,
      password: password,
      algorithm: algorithm,
      publicKeys: input.recipientPublicKeys
          .map((e) => nr.PublicKey(publicKey: e))
          .toList(),
    );

    return EncryptDataOutput(
      encryptedData
          .map(
            (e) => EncryptedData(
              e.algorithm.toString(),
              e.sourcePublicKey.publicKey,
              e.recipientPublicKey.publicKey,
              e.data,
              e.nonce,
            ),
          )
          .toList(),
    );
  }

  @override
  Future<EstimateFeesOutput> estimateFees(EstimateFeesInput input) {
    // TODO: implement estimateFees
    throw UnimplementedError();
  }

  @override
  Future<ExecuteLocalOutput> executeLocal(ExecuteLocalInput input) {
    // TODO: implement executeLocal
    throw UnimplementedError();
  }

  @override
  Future<ExtractPublicKeyOutput> extractPublicKey(
    ExtractPublicKeyInput input,
  ) {
    // TODO: implement extractPublicKey
    throw UnimplementedError();
  }

  @override
  Future<FindTransactionOutput> findTransaction(FindTransactionInput input) {
    // TODO: implement findTransaction
    throw UnimplementedError();
  }

  @override
  Future<GetAccountsByCodeHashOutput> getAccountsByCodeHash(
    GetAccountsByCodeHashInput input,
  ) {
    // TODO: implement getAccountsByCodeHash
    throw UnimplementedError();
  }

  @override
  Future<GetBocHashOutput> getBocHash(GetBocHashInput input) {
    // TODO: implement getBocHash
    throw UnimplementedError();
  }

  @override
  Future<GetCodeSaltOutput> getCodeSalt(GetCodeSaltInput input) {
    // TODO: implement getCodeSalt
    throw UnimplementedError();
  }

  @override
  Future<GetContractFieldsOutput> getContractFields(
    GetContractFieldsInput input,
  ) {
    // TODO: implement getContractFields
    throw UnimplementedError();
  }

  @override
  Future<GetExpectedAddressOutput> getExpectedAddress(
    GetExpectedAddressInput input,
  ) {
    // TODO: implement getExpectedAddress
    throw UnimplementedError();
  }

  @override
  Future<GetFullContractStateOutput> getFullContractState(
    GetFullContractStateInput input,
  ) {
    // TODO: implement getFullContractState
    throw UnimplementedError();
  }

  @override
  Future<GetProviderStateOutput> getProviderState() async {
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
  Future<GetTransactionOutput> getTransaction(GetTransactionInput input) {
    // TODO: implement getTransaction
    throw UnimplementedError();
  }

  @override
  Future<GetTransactionsOutput> getTransactions(GetTransactionsInput input) {
    // TODO: implement getTransactions
    throw UnimplementedError();
  }

  @override
  Future<MergeTvcOutput> mergeTvc(MergeTvcInput input) {
    // TODO: implement mergeTvc
    throw UnimplementedError();
  }

  @override
  Future<PackIntoCellOutput> packIntoCell(PackIntoCellInput input) {
    // TODO: implement packIntoCell
    throw UnimplementedError();
  }

  @override
  Future<PermissionsPartial> requestPermissions(
    RequestPermissionsInput input,
  ) async {
    final requiredPermissions =
        input.permissions.map((e) => Permission.values.byName(e)).toList();
    final existingPermissions = permissionsService.getPermissions(url);

    Permissions permissions;

    if (existingPermissions != null) {
      final newPermissions = [
        if (requiredPermissions.contains(Permission.basic) &&
            existingPermissions.basic == null)
          Permission.basic,
        if (requiredPermissions.contains(Permission.accountInteraction) &&
            existingPermissions.accountInteraction == null)
          Permission.accountInteraction,
      ];

      permissions = newPermissions.isNotEmpty
          ? await approvalsService.requestPermissions(
              origin: url!,
              permissions: requiredPermissions,
            )
          : existingPermissions;
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
  }

  @override
  Future<RunLocalOutput> runLocal(RunLocalInput input) {
    // TODO: implement runLocal
    throw UnimplementedError();
  }

  @override
  Future<SendExternalMessageOutput> sendExternalMessage(
    SendExternalMessageInput input,
  ) {
    // TODO: implement sendExternalMessage
    throw UnimplementedError();
  }

  @override
  Future<SendExternalMessageDelayedOutput> sendExternalMessageDelayed(
    SendExternalMessageDelayedInput input,
  ) {
    // TODO: implement sendExternalMessageDelayed
    throw UnimplementedError();
  }

  @override
  Future<SendMessageOutput> sendMessage(SendMessageInput input) {
    // TODO: implement sendMessage
    throw UnimplementedError();
  }

  @override
  Future<SendMessageDelayedOutput> sendMessageDelayed(
    SendMessageDelayedInput input,
  ) {
    // TODO: implement sendMessageDelayed
    throw UnimplementedError();
  }

  @override
  Future<SendUnsignedExternalMessageOutput> sendUnsignedExternalMessage(
    SendUnsignedExternalMessageInput input,
  ) {
    // TODO: implement sendUnsignedExternalMessage
    throw UnimplementedError();
  }

  @override
  Future<SetCodeSaltOutput> setCodeSalt(SetCodeSaltInput input) {
    // TODO: implement setCodeSalt
    throw UnimplementedError();
  }

  @override
  Future<SignDataOutput> signData(SignDataInput input) async {
    final publicKey = nr.PublicKey(publicKey: input.publicKey);
    _checkPermissions(
      permissions: permissionsService.getPermissions(url),
      account: true,
      publicKey: publicKey,
    );

    final password = await approvalsService.signData(
      origin: url!,
      publicKey: publicKey,
      data: input.data,
    );
    final signatureId =
        await nekotonRepository.currentTransport.transport.getSignatureId();

    final signedData = await nekotonRepository.seedList.signData(
      data: input.data,
      publicKey: publicKey,
      password: password,
      signatureId: signatureId,
    );

    return SignDataOutput(
      signedData.dataHash,
      signedData.signature,
      signedData.signatureHex,
      SignDataOutputSignatureParts(
        signedData.signatureParts.high,
        signedData.signatureParts.low,
      ),
    );
  }

  @override
  Future<SignDataRawOutput> signDataRaw(SignDataRawInput input) async {
    final publicKey = nr.PublicKey(publicKey: input.publicKey);
    _checkPermissions(
      permissions: permissionsService.getPermissions(url),
      account: true,
      publicKey: publicKey,
    );

    final password = await approvalsService.signData(
      origin: url!,
      publicKey: publicKey,
      data: input.data,
    );
    final signatureId =
        await nekotonRepository.currentTransport.transport.getSignatureId();

    final signedData = await nekotonRepository.seedList.signRawData(
      data: input.data,
      publicKey: publicKey,
      password: password,
      signatureId: signatureId,
    );

    return SignDataRawOutput(
      signedData.signature,
      signedData.signatureHex,
      SignDataRawOutputSignatureParts(
        signedData.signatureParts.high,
        signedData.signatureParts.low,
      ),
    );
  }

  @override
  Future<SplitTvcOutput> splitTvc(SplitTvcInput input) {
    // TODO: implement splitTvc
    throw UnimplementedError();
  }

  @override
  Future<ContractUpdatesSubscription> subscribe(SubscribeInput input) {
    // TODO: implement subscribe
    throw UnimplementedError();
  }

  @override
  Future<UnpackFromCellOutput> unpackFromCell(UnpackFromCellInput input) {
    // TODO: implement unpackFromCell
    throw UnimplementedError();
  }

  @override
  Future<UnpackInitDataOutput> unpackInitData(UnpackInitDataInput input) {
    // TODO: implement unpackInitData
    throw UnimplementedError();
  }

  @override
  Future<void> unsubscribe(UnsubscribeInput input) {
    // TODO: implement unsubscribe
    throw UnimplementedError();
  }

  @override
  Future<void> unsubscribeAll() {
    // TODO: implement unsubscribeAll
    throw UnimplementedError();
  }

  @override
  Future<VerifySignatureOutput> verifySignature(VerifySignatureInput input) {
    // TODO: implement verifySignature
    throw UnimplementedError();
  }

  @override
  dynamic call(String method, dynamic params) async {
    _logger.finest('method: $method, params: $params');
    try {
      return await super.call(method, params);
    } on s.ApprovalsHandleException catch (e) {
      inject<s.MessengerService>().show(s.Message.error(message: e.message));
      rethrow;
    } catch (e, t) {
      _logger.severe(method, e, t);
      inject<s.MessengerService>().show(
        s.Message.error(message: LocaleKeys.browserErrorTitle.tr()),
      );
      rethrow;
    }
  }
}
