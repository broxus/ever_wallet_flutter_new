import 'package:app/widgets/user_avatar/user_avatar_wm.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class UserAvatar extends ElementaryWidget<UserAvatarWidgetModel> {
  UserAvatar({
    Key? key,
    WidgetModelFactory<UserAvatarWidgetModel>? wmFactory,
    this.address,
  }) : super(
          wmFactory ??
              (ctx) => defaultUserAvatarWidgetModelFactory(
                    ctx,
                    address: address,
                  ),
          key: key,
        );

  final String? address;

  @override
  Widget build(UserAvatarWidgetModel wm) {
    return SizedBox(
      width: DimensSizeV2.d40,
      height: DimensSizeV2.d40,
      child: StateNotifierBuilder<AvatarData?>(
        listenableState: wm.avatarState,
        builder: (_, data) {
          if (data == null) {
            return const SizedBox.shrink();
          }

          return switch (data.type) {
            AvatarType.asset => Image.asset(
                data.path,
                width: double.infinity,
                height: double.infinity,
                color: data.color,
                colorBlendMode: BlendMode.modulate,
              ),
            AvatarType.raw => ClipRRect(
                borderRadius: BorderRadius.circular(DimensRadiusV2.radius12),
                child: SvgPicture.string(
                  data.path,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
          };
        },
      ),
    );
  }
}
