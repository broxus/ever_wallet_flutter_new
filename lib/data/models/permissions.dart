import 'package:app/data/models/account_interaction.dart';
import 'package:app/utils/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_webview/nekoton_webview.dart';

part 'permissions.freezed.dart';
part 'permissions.g.dart';

@freezed
class Permissions with _$Permissions {
  const factory Permissions({
    @JsonKey(includeIfNull: false) bool? basic,
    @JsonKey(includeIfNull: false) AccountInteraction? accountInteraction,
  }) = _Permissions;

  const Permissions._();

  factory Permissions.fromJson(Map<String, dynamic> json) =>
      _$PermissionsFromJson(json);

  PermissionsPartial toPartial() => PermissionsPartial(
        basic,
        accountInteraction?.let(
          (accountInteraction) => PermissionsAccountInteraction(
            accountInteraction.address.address,
            accountInteraction.publicKey.publicKey,
            accountInteraction.contractType.jsonName,
          ),
        ),
      );
}
