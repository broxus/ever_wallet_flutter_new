import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:app/widgets/user_avatar/user_avatar.dart';
import 'package:app/widgets/user_avatar/user_avatar_model.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jdenticon_dart/jdenticon_dart.dart';

/// Factory method for creating [UserAvatarWidgetModel]
UserAvatarWidgetModel defaultUserAvatarWidgetModelFactory(
  BuildContext context, {
  String? address,
}) {
  return UserAvatarWidgetModel(
    UserAvatarModel(
      createPrimaryErrorHandler(context),
      inject(),
      address,
    ),
  );
}

/// [WidgetModel] для [UserAvatar]
class UserAvatarWidgetModel
    extends CustomWidgetModel<UserAvatar, UserAvatarModel> {
  UserAvatarWidgetModel(
    super.model,
  );

  late final _avatarState = createNotifier<AvatarData?>();

  ListenableState<AvatarData?> get avatarState => _avatarState;

  @override
  void initWidgetModel() {
    _init();
    super.initWidgetModel();
  }

  Future<void> _init() async {
    model.identifyState.addListener(_onUpdateIdentify);
  }

  void _onUpdateIdentify() {
    final address = widget.address;

    if (address == null) {
      _setAssetSvg();
      return;
    }

    final identify = model.identifyState.value;
    try {
      final result = identify == null
          ? Jdenticon.toSvg(address)
          : Jdenticon.toSvg(
              address,
              colorLightnessMinValue: identify.lightness.colorMin,
              colorLightnessMaxValue: identify.lightness.colorMax,
              grayscaleLightnessMinValue: identify.lightness.grayscale.min,
              grayscaleLightnessMaxValue: identify.lightness.grayscale.max,
              colorSaturation: identify.saturation.color,
              grayscaleSaturation: identify.saturation.grayscale,
              backColor: identify.bacColor,
              hues: identify.hues,
            );

      _avatarState.accept(
        AvatarData(
          type: AvatarType.raw,
          path: result,
          color: identify?.color,
        ),
      );
    } catch (_) {
      _setAssetSvg();
    }
  }

  void _setAssetSvg() {
    _avatarState.accept(
      AvatarData(
        type: AvatarType.asset,
        path: Assets.images.userAvatar.userAvatar.path,
      ),
    );
  }
}

class AvatarData {
  AvatarData({
    required this.type,
    required this.path,
    this.color,
  });

  final AvatarType type;
  final String path;
  final Color? color;
}

enum AvatarType {
  asset,
  raw,
}
