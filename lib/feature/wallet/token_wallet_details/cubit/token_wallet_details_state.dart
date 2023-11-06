part of 'token_wallet_details_cubit.dart';

@freezed
class TokenWalletDetailsState with _$TokenWalletDetailsState {
  const factory TokenWalletDetailsState.initial() = _Initial;

  const factory TokenWalletDetailsState.empty() = _Empty;

  const factory TokenWalletDetailsState.subscribeError({
    required String contractName,
    required Object error,
    required bool isLoading,
  }) = _SubscribeError;

  const factory TokenWalletDetailsState.data({
    required String contractName,
    required Money tokenBalance,
    required Money fiatBalance,
    required bool canSend,
  }) = _Data;
}
