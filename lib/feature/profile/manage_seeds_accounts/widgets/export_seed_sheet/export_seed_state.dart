part of 'export_seed_cubit.dart';

@freezed
class ExportSeedState with _$ExportSeedState {
  const factory ExportSeedState.initial() = _Initial;

  const factory ExportSeedState.loading() = _Loading;

  /// Error with [code] that should be get from localization.
  const factory ExportSeedState.error(String code) = _Error;

  const factory ExportSeedState.success(List<String> phrase) = _Success;
}
