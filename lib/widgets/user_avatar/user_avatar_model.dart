import 'dart:async';

import 'package:app/app/service/identify/accounts_colors_collection.dart';
import 'package:app/app/service/identify/i_identify_icons_service.dart';
import 'package:app/app/service/identify/identy_icon_data.dart';
import 'package:app/widgets/user_avatar/user_avatar.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';

/// [ElementaryModel] for [UserAvatar]
class UserAvatarModel extends ElementaryModel {
  UserAvatarModel(
    ErrorHandler errorHandler,
    this._identifyIconsService,
    this.address,
  ) : super(errorHandler: errorHandler);

  final String? address;

  late final _identifyState = StateNotifier<IdentifyIconData>(
    initValue: _identifyIconsService.initialColor,
  );

  final IIdentifyIconsService _identifyIconsService;

  StreamSubscription<AccountsColorsCollection>? _sc;

  ListenableState<IdentifyIconData> get identifyState => _identifyState;

  @override
  void init() {
    if (address != null) {
      _sc = _identifyIconsService.accountsColorsStream.listen(_onUpdateColor);
    }
    super.init();
  }

  @override
  void dispose() {
    _sc?.cancel();
    _identifyState.dispose();
    super.dispose();
  }

  Future<void> _onUpdateColor(AccountsColorsCollection collection) async {
    if (address != null) {
      _identifyState.accept(await collection.getData(address!));
    }
  }
}
