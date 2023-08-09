part of 'wallet_account_actions_cubit.dart';

@freezed
class WalletAccountActionsState with _$WalletAccountActionsState {
  const factory WalletAccountActionsState.loading() = _Loading;

  const factory WalletAccountActionsState.data({
    required WalletAccountActionBehavior action,
    required bool hasStake,
  }) = _Data;
}