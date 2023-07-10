part of 'localization_bloc.dart';

@freezed
class LocalizationEvent with _$LocalizationEvent {
  const factory LocalizationEvent.setLocaleCodeFromService({
    required SupportedLocaleCodes code,
  }) = _SetLocaleCodeFromService;

  const factory LocalizationEvent.changeLocaleCode({
    required SupportedLocaleCodes code,
  }) = _ChangeLocaleCode;
}
