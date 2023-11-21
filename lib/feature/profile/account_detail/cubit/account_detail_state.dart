part of 'account_detail_cubit.dart';

@freezed
class AccountDetailState with _$AccountDetailState {
  const factory AccountDetailState.initial() = _Initial;

  const factory AccountDetailState.empty() = _Empty;

  const factory AccountDetailState.data(
    KeyAccount account,
    Money balance,
    List<SeedKey> custodians,
  ) = _Data;
}
