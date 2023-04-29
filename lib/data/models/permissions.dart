import 'package:app/data/models/account_interaction.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'permissions.freezed.dart';

part 'permissions.g.dart';

@freezed
class Permissions with _$Permissions {
  const factory Permissions({
    @JsonKey(includeIfNull: false) bool? basic,
    @JsonKey(includeIfNull: false) AccountInteraction? accountInteraction,
  }) = _Permissions;

  factory Permissions.fromJson(Map<String, dynamic> json) =>
      _$PermissionsFromJson(json);
}
