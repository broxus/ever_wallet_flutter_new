import 'package:app/data/models/token_contract/token_contract_asset.dart';
import 'package:app/data/models/ton_assets_manifest_version.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ton_assets_manifest.freezed.dart';
part 'ton_assets_manifest.g.dart';

@freezed
class TonAssetsManifest with _$TonAssetsManifest {
  const factory TonAssetsManifest({
    @JsonKey(name: r'$schema') required String schema,
    required String name,
    required TonAssetsManifestVersion version,
    required List<String> keywords,
    required String timestamp,
    required List<TokenContractAsset> tokens,
  }) = _TonAssetsManifest;

  factory TonAssetsManifest.fromJson(Map<String, dynamic> json) =>
      _$TonAssetsManifestFromJson(json);
}
