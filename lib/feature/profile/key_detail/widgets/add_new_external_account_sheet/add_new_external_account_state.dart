part of 'add_new_external_account_cubit.dart';

@freezed
class AddNewExternalAccountState with _$AddNewExternalAccountState {
  const factory AddNewExternalAccountState.initial() = _Initial;

  const factory AddNewExternalAccountState.completed() = _Completed;

  const factory AddNewExternalAccountState.loading() = _Loading;
}
