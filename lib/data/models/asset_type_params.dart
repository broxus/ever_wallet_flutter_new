import 'package:freezed_annotation/freezed_annotation.dart';

part 'asset_type_params.freezed.dart';
part 'asset_type_params.g.dart';

@freezed
class AssetTypeParams with _$AssetTypeParams {
  const factory AssetTypeParams({
    required String rootContract,
  }) = _AssetTypeParams;

  factory AssetTypeParams.fromJson(Map<String, dynamic> json) =>
      _$AssetTypeParamsFromJson(json);
}
