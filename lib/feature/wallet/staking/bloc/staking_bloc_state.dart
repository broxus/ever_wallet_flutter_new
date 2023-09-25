part of 'staking_bloc.dart';

@freezed
class StakingBlocState with _$StakingBlocState {
  const factory StakingBlocState.preparing() = _Preparing;

  const factory StakingBlocState.initError() = _InitError;

  /// State that describes stake view
  const factory StakingBlocState.data({
    // Type of current selected action
    required StakingPageType type,
    required int withdrawTime,
    // Amount in EVER that will be attached to action
    required BigInt attachedAmount,
    required bool canSubmitAction,
    required TextEditingController inputController,
    required String imagePath,
    // How many [receiveBalance] could be received for [currentBalance].
    // if we receive stever, then it should be displayed on right side, on left
    // otherwise
    required double exchangeRate,
    required Currency receiveCurrency,
    required PublicKey accountKey,
    // Balance of current selected token (stake-ever, unstake-stever)
    required Money currentBalance,
    // Price in real curreny of entered tokens
    required Money enteredPrice,
    // Balance of token user select after action (stake-stever, unstake-ever)
    Money? receiveBalance,
    // Pending withdraw requests
    List<StEverWithdrawRequest>? requests,
    // Average profit
    double? apy,
  }) = _StakingState;
}
