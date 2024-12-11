part of 'wallet_deploy_bloc.dart';

@freezed
class WalletDeployEvent with _$WalletDeployEvent {
  /// Navigate from sending transaction step to entering data step
  const factory WalletDeployEvent.goPrevStep() = _PrevStep;

  /// Event that allows change active type for deploying wallet
  const factory WalletDeployEvent.changeType(WalletDeployType type) =
      _ChangeType;

  /// Method that calls before changing type from multisig, this allows just
  /// cache previous data.
  /// If user clicked deploy without changing type, then
  /// `WalletDeployEvent.deployMultisig` event will update data.
  const factory WalletDeployEvent.updateMultisigData(
    List<PublicKey> custodians,
    int requireConfirmations,
    int? hours,
  ) = _UpdateMultisigData;

  /// Deploy standard wallet
  const factory WalletDeployEvent.deployStandard() = _DeployStandard;

  /// Deploy multisig wallet
  const factory WalletDeployEvent.deployMultisig(
    List<PublicKey> custodians,
    int requireConfirmations,
    int? hours,
  ) = _DeployMultisig;

  /// Run deploying process by subscribing transaction
  const factory WalletDeployEvent.confirmDeploy(
    String password,
  ) = _ConfirmDeploy;

  /// Allow user to close deploy page
  const factory WalletDeployEvent.allowCloseDeploy() = _AllowCloseDeploy;

  /// Complete deploying transaction with result
  const factory WalletDeployEvent.completeDeploy(
    Transaction transaction,
  ) = _CompleteDeploy;
}
