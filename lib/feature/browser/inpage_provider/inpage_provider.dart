import 'dart:async';

import 'package:nekoton_webview/nekoton_webview.dart';

class InpageProvider extends ProviderApi {
  Uri? url;

  @override
  Future<AddAssetOutput> addAsset(AddAssetInput input) {
    // TODO: implement addAsset
    throw UnimplementedError();
  }

  @override
  Future<PermissionsPartial> changeAccount() {
    // TODO: implement changeAccount
    throw UnimplementedError();
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
  Future<DecryptDataOutput> decryptData(DecryptDataInput input) {
    // TODO: implement decryptData
    throw UnimplementedError();
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
  Future<EncryptDataOutput> encryptData(EncryptDataInput input) {
    // TODO: implement encryptData
    throw UnimplementedError();
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

  final _address =
      '0:727a540fb41fba5767e8fb5aaf0c9b9b0c9aa4ff8d534c45e5ba68742dacc134';
  final _publicKey =
      '9599d7a809bd0787b2dd995df6408bb0c25ea4c1cb9a26d83d68639797abb5e3';

  @override
  Future<PermissionsPartial> requestPermissions(
    RequestPermissionsInput input,
  ) async {
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
  Future<SignDataOutput> signData(SignDataInput input) {
    // TODO: implement signData
    throw UnimplementedError();
  }

  @override
  Future<SignDataRawOutput> signDataRaw(SignDataRawInput input) {
    // TODO: implement signDataRaw
    throw UnimplementedError();
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
}
