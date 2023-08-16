part of 'wallet_prepare_transfer_cubit.dart';

@freezed
class WalletPrepareTransferState with _$WalletPrepareTransferState {
  const factory WalletPrepareTransferState.loading() = _Loading;

  const factory WalletPrepareTransferState.empty() = _Empty;

  /// <localCustodians> contains at least public key of current wallet.
  /// <selectedCustodian> - which key should be initiator of transaction (for
  /// not multisig this is main key)
  const factory WalletPrepareTransferState.data({
    required String walletName,
    required KeyAccount account,
    required PublicKey selectedCustodian,
    required List<PublicKey> localCustodians,
    required WalletPrepareTransferAsset selectedAsset,
    required List<WalletPrepareTransferAsset> assets,
  }) = _Data;

  /// <localCustodians> contains at least public key of current wallet.
  /// <selectedCustodian> - which key should be initiator of transaction (for
  /// not multisig this is main key)
  const factory WalletPrepareTransferState.goNext({
    required String walletName,
    required KeyAccount account,
    required PublicKey selectedCustodian,
    required List<PublicKey> localCustodians,
    required WalletPrepareTransferAsset selectedAsset,
    required List<WalletPrepareTransferAsset> assets,
    required Address receiveAddress,
    required Fixed amount,
    required String? comment,
  }) = _GoNext;
}
