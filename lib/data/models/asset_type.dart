import 'package:freezed_annotation/freezed_annotation.dart';

const _tip3Token = 'tip3_token';

/// This map needed because all input-related data stores in auto-generated
/// webview models
const assetTypeMap = {
  _tip3Token: AssetType.tip3Token,
};

enum AssetType {
  @JsonValue(_tip3Token)
  tip3Token,
}
