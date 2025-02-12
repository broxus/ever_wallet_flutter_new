part of 'wallet_deploy_bloc.dart';

@freezed
class WalletDeployState with _$WalletDeployState {
  /// Page that displays standard wallet deploy
  const factory WalletDeployState.standard() = _Standard;

  /// Page that displays multisig wallet deploy.
  /// [custodians] and [requireConfirmations] is just a cache from bloc, and
  /// its data validated only in UI.
  const factory WalletDeployState.multisig(
    List<PublicKey> custodians,
    int requireConfirmations,
    int hours,
    WalletType walletType,
  ) = _Multisig;

  /// Error during calculating fee process
  const factory WalletDeployState.calculatingError({
    required String error,
    BigInt? fee,
    BigInt? balance,
    List<PublicKey>? custodians,
    int? requireConfirmations,
    String? tonIconPath,
    String? ticker,
    CustomCurrency? currency,
  }) = _CalculatingError;

  /// Fee calculated, allow user subscribe transaction
  const factory WalletDeployState.readyToDeploy({
    required BigInt fee,
    required BigInt balance,
    List<PublicKey>? custodians,
    int? requireConfirmations,
    String? tonIconPath,
    String? ticker,
    CustomCurrency? currency,
    KeyAccount? account,
    int? hours,
  }) = _ReadyToDeploy;

  const factory WalletDeployState.deploying({
    required bool canClose,
  }) = _Deploying;

  /// Transaction sent successfully
  const factory WalletDeployState.deployed({
    required BigInt fee,
    required BigInt balance,
    required Transaction transaction,
    List<PublicKey>? custodians,
    int? requireConfirmations,
    String? tonIconPath,
  }) = _Deployed;

  const factory WalletDeployState.subscribeError(Object error) =
      _SubscribeError;
}
