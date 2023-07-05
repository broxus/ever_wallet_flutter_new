part of 'contact_support_bloc.dart';

@freezed
class ContactSupportState with _$ContactSupportState {
  const factory ContactSupportState.initial() = _Initial;
  const factory ContactSupportState.busy() = _Busy;
}
