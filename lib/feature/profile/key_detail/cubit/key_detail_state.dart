part of 'key_detail_cubit.dart';

@freezed
class KeyDetailState with _$KeyDetailState {
  const factory KeyDetailState.initial() = _Initial;

  const factory KeyDetailState.empty() = _Empty;

  const factory KeyDetailState.data(
    SeedKey key,
    String ownerSeedName,
    KeyDetailAccountsTab accountsTab,
  ) = _Data;
}
