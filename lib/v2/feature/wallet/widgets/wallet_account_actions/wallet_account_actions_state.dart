part of 'wallet_account_actions_cubit.dart';

@freezed
class WalletAccountActionsState with _$WalletAccountActionsState {
  const factory WalletAccountActionsState.loading({required bool hasStake}) =
      _Loading;

  const factory WalletAccountActionsState.data({
    required WalletAccountActionBehavior action,
    required bool hasStake,
    required bool hasStakeActions,
  }) = _Data;
}
