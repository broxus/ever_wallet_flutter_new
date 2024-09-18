import 'package:app/app/service/identify/identy_colors.dart';
import 'package:app/widgets/user_avatar/user_avatar_wm.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
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

  final Address? address;

  @override
  Widget build(UserAvatarWidgetModel wm) {
    return ClipOval(
      child: SizedBox(
        width: DimensSizeV2.d40,
        height: DimensSizeV2.d40,
        child: DoubleSourceBuilder<AvatarData?, IdentifyColor>(
          firstSource: wm.iconState,
          secondSource: wm.colorState,
          builder: (_, svgData, identifyColor) {
            if (svgData == null) {
              return const SizedBox.shrink();
            }

            return switch (svgData.type) {
              AvatarType.asset => Image.asset(
                  svgData.path,
                  width: double.infinity,
                  height: double.infinity,
                  color: identifyColor?.color,
                  colorBlendMode: BlendMode.modulate,
                ),
              AvatarType.raw => SvgPicture.string(
                  svgData.path,
                  width: double.infinity,
                  height: double.infinity,
                  colorFilter: identifyColor?.color.colorFilter,
                ),
            };
          },
        ),
      ),
    );
  }
}
