part of 'wallet_cubit.dart';

@freezed
class WalletState with _$WalletState {
  const factory WalletState.initial() = _Initial;

  const factory WalletState.empty() = _Empty;

  /// [list] is list of accounts for current selected key
  /// [currentAccount] displays current selected account for current key.
  ///   if [currentAccount] is null, then user selected `add account` card.
  const factory WalletState.accounts({
    required List<KeyAccount> list,
    required PublicKey currentKey,
    required KeyAccount? currentAccount,
    required PageController controller,
  }) = _Accounts;
}
