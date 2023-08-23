import 'dart:async';

import 'package:nekoton_webview/nekoton_webview.dart';

class InpageProvider extends ProviderApi {
  @override
  FutureOr<AddAssetOutput> addAsset(AddAssetInput input) {
    // TODO: implement addAsset
    throw UnimplementedError();
  }

  @override
  FutureOr<PermissionsPartial> changeAccount() {
    // TODO: implement changeAccount
    throw UnimplementedError();
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
      DecodeTransactionInput input) {
    // TODO: implement decodeTransaction
    throw UnimplementedError();
  }

  @override
  FutureOr<DecodeTransactionEventsOutput> decodeTransactionEvents(
      DecodeTransactionEventsInput input) {
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
      ExtractPublicKeyInput input) {
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
      GetAccountsByCodeHashInput input) {
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
      GetContractFieldsInput input) {
    // TODO: implement getContractFields
    throw UnimplementedError();
  }

  @override
  FutureOr<GetExpectedAddressOutput> getExpectedAddress(
      GetExpectedAddressInput input) {
    // TODO: implement getExpectedAddress
    throw UnimplementedError();
  }

  @override
  FutureOr<GetFullContractStateOutput> getFullContractState(
      GetFullContractStateInput input) {
    // TODO: implement getFullContractState
    throw UnimplementedError();
  }

  @override
  FutureOr<GetProviderStateOutput> getProviderState() {
    // TODO: implement getProviderState

    return GetProviderStateOutput.fromJson(
      {
        'version': '0.3.0',
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

  final _address =
      '0:727a540fb41fba5767e8fb5aaf0c9b9b0c9aa4ff8d534c45e5ba68742dacc134';
  final _publicKey =
      '9599d7a809bd0787b2dd995df6408bb0c25ea4c1cb9a26d83d68639797abb5e3';

  @override
  FutureOr<PermissionsPartial> requestPermissions(
    RequestPermissionsInput input,
  ) {
    // TODO: implement requestPermissions

    return PermissionsPartial.fromJson({
      'basic': true,
      'accountInteraction': {
        'address': _address,
        'publicKey': _publicKey,
        'contractType': 'EverWallet',
      },
    });
  }

  @override
  FutureOr<RunLocalOutput> runLocal(RunLocalInput input) {
    // TODO: implement runLocal
    throw UnimplementedError();
  }

  @override
  FutureOr<SendExternalMessageOutput> sendExternalMessage(
      SendExternalMessageInput input) {
    // TODO: implement sendExternalMessage
    throw UnimplementedError();
  }

  @override
  FutureOr<SendExternalMessageDelayedOutput> sendExternalMessageDelayed(
      SendExternalMessageDelayedInput input) {
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
      SendMessageDelayedInput input) {
    // TODO: implement sendMessageDelayed
    throw UnimplementedError();
  }

  @override
  FutureOr<SendUnsignedExternalMessageOutput> sendUnsignedExternalMessage(
      SendUnsignedExternalMessageInput input) {
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
}
