import 'package:freezed_annotation/freezed_annotation.dart';

part 'ton_assets_manifest_version.freezed.dart';
part 'ton_assets_manifest_version.g.dart';

@freezed
class TonAssetsManifestVersion with _$TonAssetsManifestVersion {
  const factory TonAssetsManifestVersion({
    required int major,
    required int minor,
    required int patch,
  }) = _TonAssetsManifestVersion;

  factory TonAssetsManifestVersion.fromJson(Map<String, dynamic> json) =>
      _$TonAssetsManifestVersionFromJson(json);
}
