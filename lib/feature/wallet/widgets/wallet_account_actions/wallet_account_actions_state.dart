part of 'wallet_account_actions_cubit.dart';

@freezed
class WalletAccountActionsState with _$WalletAccountActionsState {
  const factory WalletAccountActionsState.loading({
    required bool hasStake,
    required String? nativeTokenTicker,
  }) = _Loading;

  const factory WalletAccountActionsState.data({
    required WalletAccountActionBehavior action,
    required bool hasStake,
    required bool hasStakeActions,
    required BigInt? balance,
    required BigInt? minBalance,
    required List<PublicKey>? custodians,
    required String? nativeTokenTicker,
    required int? numberUnconfirmedTransactions,
  }) = _Data;
}
