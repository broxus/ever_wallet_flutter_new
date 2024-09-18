import 'dart:async';

import 'package:app/app/service/identify/accounts_colors_collection.dart';
import 'package:app/app/service/identify/i_identify_icons_service.dart';
import 'package:app/app/service/identify/identy_colors.dart';
import 'package:app/widgets/user_avatar/user_avatar.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// [ElementaryModel] for [UserAvatar]
class UserAvatarModel extends ElementaryModel {
  UserAvatarModel(
    ErrorHandler errorHandler,
    this._identifyIconsService,
    this.address,
  ) : super(errorHandler: errorHandler);

  final Address? address;

  late final _colorState = StateNotifier<IdentifyColor>(
    initValue: _identifyIconsService.initialColor,
  );

  final IIdentifyIconsService _identifyIconsService;

  StreamSubscription<AccountsColorsCollection>? _sc;

  ListenableState<IdentifyColor> get colorState => _colorState;

  String? get _address => address?.address;

  @override
  void init() {
    if (_address != null) {
      _sc = _identifyIconsService.accountsColorsStream.listen(_onUpdateColor);
    }
    super.init();
  }

  @override
  void dispose() {
    _sc?.cancel();
    super.dispose();
  }

  Future<void> _onUpdateColor(AccountsColorsCollection collection) async {
    if (_address != null) {
      _colorState.accept(await collection.getColor(_address!));
    }
  }
}
