part of 'staking_bloc.dart';

@freezed
class StakingBlocState with _$StakingBlocState {
  const factory StakingBlocState.preparing() = _Preparing;

  const factory StakingBlocState.initError() = _InitError;

  const factory StakingBlocState.subscribeError(Object error) = _SubscribeError;

  /// State that describes stake view
  const factory StakingBlocState.data({
    // Type of current selected action
    required StakingPageType type,
    required int withdrawTime,
    // Amount in EVER that will be attached to action
    required BigInt attachedAmount,
    required bool canSubmitAction,
    required TextEditingController inputController,
    // How many [receiveBalance] could be received for [currentBalance].
    // if we receive stever, then it should be displayed on right side, on left
    // otherwise
    required double exchangeRate,
    required Currency receiveCurrency,
    required PublicKey accountKey,
    // Price in real curreny of entered tokens
    required Money enteredPrice,
    required AmountInputAsset asset,
    // Balance of token user select after action (stake-stever, unstake-ever)
    Money? receiveBalance,
    // Pending withdraw requests
    List<StEverWithdrawRequest>? requests,
    // Average profit
    double? apy,
  }) = _StakingState;
}
