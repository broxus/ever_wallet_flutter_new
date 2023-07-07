part of 'localization_bloc.dart';

@freezed
class LocalizationEvent with _$LocalizationEvent {
  const factory LocalizationEvent.setLocaleCode({
    required SupportedLocaleCodes code,
  }) = _SetLocaleCode;
}
