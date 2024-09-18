import 'package:app/app/service/identify/identy_colors.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:app/widgets/user_avatar/user_avatar.dart';
import 'package:app/widgets/user_avatar/user_avatar_model.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:jdenticon_dart/jdenticon_dart.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Factory method for creating [UserAvatarWidgetModel]
UserAvatarWidgetModel defaultUserAvatarWidgetModelFactory(
  BuildContext context, {
  Address? address,
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

  late final _iconState = createNotifier<AvatarData?>();

  ListenableState<AvatarData?> get iconState => _iconState;

  ListenableState<IdentifyColor> get colorState => model.colorState;

  @override
  void initWidgetModel() {
    _init();
    super.initWidgetModel();
  }

  Future<void> _init() async {
    final address = widget.address?.address;

    if (address == null) {
      _setAssetSvg();
      return;
    }

    try {
      _iconState.accept(
        AvatarData(
          type: AvatarType.raw,
          path: Jdenticon.toSvg(address),
        ),
      );
    } catch (_) {
      _setAssetSvg();
    }
  }

  void _setAssetSvg() {
    _iconState.accept(
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
  });

  final AvatarType type;
  final String path;
}

enum AvatarType {
  asset,
  raw,
}
