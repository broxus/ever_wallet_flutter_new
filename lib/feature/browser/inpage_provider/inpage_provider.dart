import 'dart:async';

import 'package:app/app/service/service.dart' as s;
import 'package:app/data/models/models.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:collection/collection.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart' as nr;
import 'package:nekoton_webview/nekoton_webview.dart';

const providerVersion = '0.3.0';
const providerNumericVersion = 3000;

class InpageProvider extends ProviderApi {
  InpageProvider({
    required this.tabId,
    required this.approvalsService,
    required this.permissionsService,
    required this.nekotonRepository,
  });

  final _logger = Logger('InpageProvider');

  InAppWebViewController? controller;
  final String tabId;
  final s.BrowserApprovalsService approvalsService;
  final s.PermissionsService permissionsService;
  final nr.NekotonRepository nekotonRepository;

  Uri? url;
  Uri? get origin => url == null ? null : Uri.parse(url!.origin);

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
      permissions: permissionsService.getPermissions(origin),
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
          origin: origin!,
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
    final existingPermissions = permissionsService.getPermissions(origin);
    _checkPermissions(permissions: existingPermissions, account: true);

    final existingPermissionsList = [
      if (existingPermissions?.basic == null) Permission.basic,
      if (existingPermissions?.accountInteraction == null)
        Permission.accountInteraction,
    ];

    final permissions = await approvalsService.changeAccount(
      origin: origin!,
      permissions: existingPermissionsList,
    );

    final accountInteraction = permissions.accountInteraction;

    final partial = PermissionsPartial(
      permissions.basic,
      accountInteraction == null
          ? null
          : PermissionsAccountInteraction(
              accountInteraction.address.address,
              accountInteraction.publicKey.publicKey,
              accountInteraction.contractType.name,
            ),
    );

    await controller?.permissionsChanged(PermissionsChangedEvent(partial));

    return partial;
  }

  @override
  Future<CodeToTvcOutput> codeToTvc(CodeToTvcInput input) async {
    _checkPermissions(permissions: permissionsService.getPermissions(origin));
    final (tvc, hash) = await nr.codeToTvc(input.code);

    return CodeToTvcOutput(tvc, hash);
  }

  @override
  Future<DecodeEventOutput?> decodeEvent(DecodeEventInput input) async {
    _checkPermissions(permissions: permissionsService.getPermissions(origin));

    final event = await nr.decodeEvent(
      messageBody: input.body,
      contractAbi: input.abi,
      event: input.event,
    );

    return event == null ? null : DecodeEventOutput(event.event, event.data);
  }

  @override
  Future<DecodeInputOutput?> decodeInput(DecodeInputInput input) async {
    _checkPermissions(permissions: permissionsService.getPermissions(origin));
    final output = await nr.decodeInput(
      messageBody: input.body,
      contractAbi: input.abi,
      method: input.method,
      internal: input.internal,
    );

    return output == null
        ? null
        : DecodeInputOutput(output.method, output.input);
  }

  @override
  Future<DecodeOutputOutput?> decodeOutput(DecodeOutputInput input) async {
    _checkPermissions(permissions: permissionsService.getPermissions(origin));
    final output = await nr.decodeOutput(
      messageBody: input.body,
      contractAbi: input.abi,
      method: input.method,
    );

    return output == null
        ? null
        : DecodeOutputOutput(output.method, output.output);
  }

  @override
  Future<DecodeTransactionOutput?> decodeTransaction(
    DecodeTransactionInput input,
  ) async {
    _checkPermissions(permissions: permissionsService.getPermissions(origin));
    final output = await nr.decodeTransaction(
      transaction: nr.Transaction.fromJson(input.transaction.toJson()),
      contractAbi: input.abi,
      method: input.method,
    );

    return output == null
        ? null
        : DecodeTransactionOutput(output.method, output.input, output.output);
  }

  @override
  Future<DecodeTransactionEventsOutput> decodeTransactionEvents(
    DecodeTransactionEventsInput input,
  ) async {
    _checkPermissions(permissions: permissionsService.getPermissions(origin));
    final events = await nr.decodeTransactionEvents(
      transaction: nr.Transaction.fromJson(input.transaction.toJson()),
      contractAbi: input.abi,
    );

    return DecodeTransactionEventsOutput(
      events
          .map((e) => DecodeTransactionEventsOutputEvents(e.event, e.data))
          .toList(),
    );
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
      permissions: permissionsService.getPermissions(origin),
      account: true,
      publicKey: publicKey,
    );

    final password = await approvalsService.decryptData(
      origin: origin!,
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
  Future<void> disconnect() async {
    await permissionsService.deletePermissionsForOrigin(origin!);
    nekotonRepository.unsubscribeContractsTab(tabId);

    await controller?.permissionsChanged(
      const PermissionsChangedEvent(PermissionsPartial(null, null)),
    );
  }

  @override
  Future<EncodeInternalInputOutput> encodeInternalInput(
    FunctionCall input,
  ) async {
    _checkPermissions(permissions: permissionsService.getPermissions(origin));
    final boc = await nr.encodeInternalInput(
      contractAbi: input.abi,
      method: input.method,
      input: input.params,
    );

    return EncodeInternalInputOutput(boc);
  }

  @override
  Future<EncryptDataOutput> encryptData(EncryptDataInput input) async {
    final publicKey = nr.PublicKey(publicKey: input.publicKey);
    _checkPermissions(
      permissions: permissionsService.getPermissions(origin),
      account: true,
      publicKey: publicKey,
    );

    final password = await approvalsService.encryptData(
      origin: origin!,
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
  Future<ExecuteLocalOutput> executeLocal(ExecuteLocalInput input) async {
    // TODO: implement executeLocal
    throw UnimplementedError();
    // _checkPermissions(permissions: permissionsService.getPermissions(origin));
    // final output = await nr.executeLocal();

    // return ExecuteLocalOutput();
  }

  @override
  Future<ExtractPublicKeyOutput> extractPublicKey(
    ExtractPublicKeyInput input,
  ) async {
    _checkPermissions(permissions: permissionsService.getPermissions(origin));
    final output = await nr.extractPublicKey(input.boc);

    return ExtractPublicKeyOutput(output.publicKey);
  }

  @override
  Future<FindTransactionOutput> findTransaction(
    FindTransactionInput input,
  ) async {
    _checkPermissions(permissions: permissionsService.getPermissions(origin));
    final hash = input.inMessageHash;
    if (hash == null) {
      throw s.ApprovalsHandleException(LocaleKeys.transactionNotFound.tr());
    }
    final output = await nekotonRepository.currentTransport.transport
        .getDstTransaction(hash);
    final trans = output?.data == null
        ? null
        : Transaction.fromJson(output!.data.toJson());

    return FindTransactionOutput(trans);
  }

  @override
  Future<GetAccountsByCodeHashOutput> getAccountsByCodeHash(
    GetAccountsByCodeHashInput input,
  ) async {
    _checkPermissions(permissions: permissionsService.getPermissions(origin));
    final accountsList = await nekotonRepository.currentTransport.transport
        .getAccountsByCodeHash(
      codeHash: input.codeHash,
      limit: input.limit?.toInt() ?? 50,
      continuation: input.continuation,
    );

    return GetAccountsByCodeHashOutput(
      accountsList.accounts,
      accountsList.continuation,
    );
  }

  @override
  Future<GetBocHashOutput> getBocHash(GetBocHashInput input) async {
    _checkPermissions(permissions: permissionsService.getPermissions(origin));
    final hash = await nr.getBocHash(input.boc);

    return GetBocHashOutput(hash);
  }

  @override
  Future<GetCodeSaltOutput> getCodeSalt(GetCodeSaltInput input) async {
    _checkPermissions(permissions: permissionsService.getPermissions(origin));
    final code = await nr.getCodeSalt(input.code);

    return GetCodeSaltOutput(code);
  }

  @override
  Future<GetContractFieldsOutput> getContractFields(
    GetContractFieldsInput input,
  ) async {
    _checkPermissions(permissions: permissionsService.getPermissions(origin));
    final (output, state) =
        await nekotonRepository.currentTransport.transport.getContractFields(
      address: nr.Address(address: input.address),
      contractAbi: input.abi,
      cachedState: input.cachedState == null
          ? null
          : nr.FullContractState.fromJson(input.cachedState!.toJson()),
    );

    return GetContractFieldsOutput(
      output,
      state == null ? null : FullContractState.fromJson(state.toJson()),
    );
  }

  @override
  Future<GetExpectedAddressOutput> getExpectedAddress(
    GetExpectedAddressInput input,
  ) async {
    _checkPermissions(permissions: permissionsService.getPermissions(origin));
    final (address, state, hash) = await nr.getExpectedAddress(
      tvc: input.tvc,
      contractAbi: input.abi,
      workchainId: input.workchain?.toInt() ?? nr.defaultWorkchainId,
      publicKey: input.publicKey == null
          ? null
          : nr.PublicKey(publicKey: input.publicKey!),
      initData: input.initParams,
    );

    return GetExpectedAddressOutput(
      address.address,
      state,
      hash,
    );
  }

  @override
  Future<GetFullContractStateOutput> getFullContractState(
    GetFullContractStateInput input,
  ) async {
    _checkPermissions(permissions: permissionsService.getPermissions(origin));
    final state = await nekotonRepository.currentTransport.transport
        .getFullContractState(nr.Address(address: input.address));

    return GetFullContractStateOutput(
      state == null ? null : FullContractState.fromJson(state.toJson()),
    );
  }

  @override
  Future<GetProviderStateOutput> getProviderState() async {
    final transport = nekotonRepository.currentTransport.transport;
    final selectedConnection = transport.group;
    const supportedPermissions = Permission.values;
    final permissions =
        permissionsService.getPermissions(origin) ?? const Permissions();
    final subscriptions = nekotonRepository.tabSubscriptions(tabId);
    final networkId = await transport.getNetworkId();

    return GetProviderStateOutput(
      providerVersion,
      providerNumericVersion,
      selectedConnection,
      networkId,
      supportedPermissions.map((e) => e.name).toList(),
      PermissionsPartial(
        permissions.basic,
        permissions.accountInteraction == null
            ? null
            : PermissionsAccountInteraction(
                permissions.accountInteraction!.address.address,
                permissions.accountInteraction!.publicKey.publicKey,
                permissions.accountInteraction!.contractType.name,
              ),
      ),
      subscriptions?.map(
            (key, value) => MapEntry(
              key.address,
              ContractUpdatesSubscription(
                value.contractState ?? false,
                value.transactions ?? false,
              ),
            ),
          ) ??
          {},
    );
  }

  @override
  Future<GetTransactionOutput> getTransaction(GetTransactionInput input) async {
    _checkPermissions(permissions: permissionsService.getPermissions(origin));
    final transaction = await nekotonRepository.currentTransport.transport
        .getTransaction(input.hash);

    return GetTransactionOutput(
      transaction == null ? null : Transaction.fromJson(transaction.toJson()),
    );
  }

  @override
  Future<GetTransactionsOutput> getTransactions(
    GetTransactionsInput input,
  ) async {
    _checkPermissions(permissions: permissionsService.getPermissions(origin));
    final transactions =
        await nekotonRepository.currentTransport.transport.getTransactions(
      address: nr.Address(address: input.address),
      count: input.limit?.toInt() ?? 50,
      fromLt: input.continuation?.lt,
    );

    return GetTransactionsOutput(
      transactions.transactions
          .map((e) => Transaction.fromJson(e.toJson()))
          .toList(),
      transactions.continuation == null
          ? null
          : TransactionId.fromJson(transactions.continuation!.toJson()),
      transactions.info == null
          ? null
          : TransactionsBatchInfo.fromJson(transactions.info!.toJson()),
    );
  }

  @override
  Future<MergeTvcOutput> mergeTvc(MergeTvcInput input) async {
    _checkPermissions(permissions: permissionsService.getPermissions(origin));
    final (tvc, hash) = await nr.mergeTvc(code: input.code, data: input.data);

    return MergeTvcOutput(tvc, hash);
  }

  @override
  Future<PackIntoCellOutput> packIntoCell(PackIntoCellInput input) async {
    _checkPermissions(permissions: permissionsService.getPermissions(origin));
    final (boc, hash) = await nr.packIntoCell(
      params:
          input.structure.map((e) => nr.AbiParam.fromJson(e.toJson())).toList(),
      tokens: input.data,
    );

    return PackIntoCellOutput(boc, hash);
  }

  @override
  Future<PermissionsPartial> requestPermissions(
    RequestPermissionsInput input,
  ) async {
    final requiredPermissions =
        input.permissions.map((e) => Permission.values.byName(e)).toList();
    final existingPermissions = permissionsService.getPermissions(origin);

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
              origin: origin!,
              permissions: requiredPermissions,
            )
          : existingPermissions;
    } else {
      permissions = await approvalsService.requestPermissions(
        origin: origin!,
        permissions: requiredPermissions,
      );
    }

    final accountInteraction = permissions.accountInteraction;

    final partial = PermissionsPartial(
      permissions.basic,
      accountInteraction == null
          ? null
          : PermissionsAccountInteraction(
              accountInteraction.address.address,
              accountInteraction.publicKey.publicKey,
              accountInteraction.contractType.name,
            ),
    );
    await controller?.permissionsChanged(PermissionsChangedEvent(partial));

    return partial;
  }

  @override
  Future<RunLocalOutput> runLocal(RunLocalInput input) async {
    _checkPermissions(permissions: permissionsService.getPermissions(origin));
    final cachedState = input.cachedState == null
        ? null
        : nr.FullContractState.fromJson(input.cachedState!.toJson());
    final contractState = cachedState ??
        await nekotonRepository.currentTransport.transport
            .getFullContractState(nr.Address(address: input.address));
    if (contractState == null) {
      throw s.ApprovalsHandleException(LocaleKeys.accountNotFound.tr());
    }

    if (!contractState.isDeployed || contractState.lastTransactionId == null) {
      throw s.ApprovalsHandleException(LocaleKeys.accountNotDeployed.tr());
    }

    final executionOutput = await nr.runLocal(
      accountStuffBoc: contractState.boc,
      contractAbi: input.functionCall.abi,
      method: input.functionCall.method,
      input: input.functionCall.params,
      responsible: input.responsible ?? false,
    );

    return RunLocalOutput(executionOutput.output, executionOutput.code);
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
  Future<SetCodeSaltOutput> setCodeSalt(SetCodeSaltInput input) async {
    _checkPermissions(permissions: permissionsService.getPermissions(origin));
    final (code, hash) =
        await nr.setCodeSalt(code: input.code, salt: input.salt);

    return SetCodeSaltOutput(code, hash);
  }

  @override
  Future<SignDataOutput> signData(SignDataInput input) async {
    final publicKey = nr.PublicKey(publicKey: input.publicKey);
    final withSignatureId = input.withSignatureId;
    _checkPermissions(
      permissions: permissionsService.getPermissions(origin),
      account: true,
      publicKey: publicKey,
    );

    final password = await approvalsService.signData(
      origin: origin!,
      publicKey: publicKey,
      data: input.data,
    );
    final signatureId = withSignatureId == true
        ? await nekotonRepository.currentTransport.transport.getSignatureId()
        : withSignatureId == false
            ? null
            : withSignatureId != null && withSignatureId is num
                ? withSignatureId.toInt()
                : null;

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
      permissions: permissionsService.getPermissions(origin),
      account: true,
      publicKey: publicKey,
    );

    final password = await approvalsService.signData(
      origin: origin!,
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
  Future<SplitTvcOutput> splitTvc(SplitTvcInput input) async {
    _checkPermissions(permissions: permissionsService.getPermissions(origin));
    final (data, code) = await nr.splitTvc(input.tvc);

    return SplitTvcOutput(data, code);
  }

  @override
  Future<ContractUpdatesSubscription> subscribe(SubscribeInput input) async {
    final accountAddress = nr.Address(address: input.address);
    _checkPermissions(permissions: permissionsService.getPermissions(origin));

    final subs = nr.ContractUpdatesSubscription(
      contractState: input.subscriptions.state ?? true,
      transactions: input.subscriptions.transactions ?? true,
    );

    await nekotonRepository.subscribeContract(
      tabId: tabId,
      address: accountAddress,
      origin: origin!,
      contractUpdatesSubscription: subs,
    );

    return ContractUpdatesSubscription(subs.contractState!, subs.transactions!);
  }

  @override
  Future<UnpackFromCellOutput> unpackFromCell(UnpackFromCellInput input) async {
    _checkPermissions(permissions: permissionsService.getPermissions(origin));
    final data = await nr.unpackFromCell(
      params:
          input.structure.map((e) => nr.AbiParam.fromJson(e.toJson())).toList(),
      boc: input.boc,
      allowPartial: input.allowPartial,
    );

    return UnpackFromCellOutput(data);
  }

  @override
  Future<UnpackInitDataOutput> unpackInitData(UnpackInitDataInput input) async {
    _checkPermissions(permissions: permissionsService.getPermissions(origin));
    final (key, tokens) = await nr.unpackInitData(
      contractAbi: input.abi,
      data: input.data,
    );

    return UnpackInitDataOutput(key?.publicKey, tokens);
  }

  @override
  Future<void> unsubscribe(UnsubscribeInput input) async {
    final accountAddress = nr.Address(address: input.address);

    nekotonRepository.unsubscribeContract(
      tabId: tabId,
      address: accountAddress,
      origin: origin!,
    );
  }

  @override
  Future<void> unsubscribeAll() async =>
      nekotonRepository.unsubscribeContractsTab(tabId);

  @override
  Future<VerifySignatureOutput> verifySignature(
    VerifySignatureInput input,
  ) async {
    _checkPermissions(permissions: permissionsService.getPermissions(origin));
    final isValid = await nr.verifySignature(
      publicKey: nr.PublicKey(publicKey: input.publicKey),
      dataHash: input.dataHash,
      signature: input.signature,
    );

    return VerifySignatureOutput(isValid);
  }

  @override
  dynamic call(String method, dynamic params) async {
    _logger.finest('method: $method, params: $params');
    try {
      return await super.call(method, params);
    } on s.ApprovalsHandleException catch (e, t) {
      _logger.severe(method, e.message, t);
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
