part of 'contact_support_bloc.dart';

@freezed
class ContactSupportEvent with _$ContactSupportEvent {
  const factory ContactSupportEvent.sendEmail(ContactSupportMode mode) =
      _SendEmail;
}
