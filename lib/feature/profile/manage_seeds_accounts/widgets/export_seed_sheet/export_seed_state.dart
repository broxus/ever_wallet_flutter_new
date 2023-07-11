part of 'export_seed_cubit.dart';

@freezed
class ExportSeedState with _$ExportSeedState {
  const factory ExportSeedState.initial() = _Initial;

  /// [error] that should be get from localization.
  const factory ExportSeedState.error(String error) = _Error;

  const factory ExportSeedState.success(List<String> phrase) = _Success;
}
