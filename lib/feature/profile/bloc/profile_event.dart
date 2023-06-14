part of 'profile_bloc.dart';

@freezed
class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.init() = _Initialize;

  const factory ProfileEvent.logOut() = _LogOut;

  const factory ProfileEvent.changeBiometry({required bool value}) =
      _ChangeBiometry;

  const factory ProfileEvent.exportSeed() = _ExportSeed;
}
