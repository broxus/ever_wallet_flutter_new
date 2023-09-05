import 'package:freezed_annotation/freezed_annotation.dart';

/// This map needed because all input-related data stores in auto-generated
/// webview models
const assetTypeMap = {
  'tip3_token': AssetType.tip3Token,
};

enum AssetType {
  @JsonValue('tip3_token')
  tip3Token,
}
