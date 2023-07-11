part of 'manage_seeds_accounts_cubit.dart';

@freezed
class ManageSeedsAccountsState with _$ManageSeedsAccountsState {
  const factory ManageSeedsAccountsState.data({
    required Seed? currentSeed,
    required List<Seed> seeds,
  }) = _Data;
}
