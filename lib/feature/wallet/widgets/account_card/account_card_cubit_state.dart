part of 'account_card_cubit.dart';

@freezed
class AccountCardState with _$AccountCardState {
  const factory AccountCardState.initial() = _Initial;

  const factory AccountCardState.data({
    required KeyAccount account,
    required TonWallet? wallet,
  }) = _Data;
}
