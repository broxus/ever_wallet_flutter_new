import 'dart:async';

import 'package:app/app/service/identify/accounts_colors_collection.dart';
import 'package:app/app/service/identify/i_identify_icons_service.dart';
import 'package:app/app/service/identify/identy_colors.dart';
import 'package:app/feature/wallet/widgets/account_settings/widgets/change_color_button/account_settings_change_color_button.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';

/// [ElementaryModel] for [AccountSettingsChangeColorButton]
class AccountSettingsChangeColorButtonModel extends ElementaryModel {
  AccountSettingsChangeColorButtonModel(
    ErrorHandler errorHandler,
    this._identifyIconsService,
    this.address,
  ) : super(errorHandler: errorHandler);

  final String address;

  late final _colorState = StateNotifier<IdentifyColor>(
    initValue: _identifyIconsService.initialColor,
  );

  final IIdentifyIconsService _identifyIconsService;

  StreamSubscription<AccountsColorsCollection>? _sc;

  ListenableState<IdentifyColor> get colorState => _colorState;

  @override
  void init() {
    _sc = _identifyIconsService.accountsColorsStream.listen(_onUpdateColor);
    super.init();
  }

  @override
  void dispose() {
    _sc?.cancel();
    super.dispose();
  }

  Future<void> _onUpdateColor(AccountsColorsCollection collection) async {
    _colorState.accept(await collection.getColor(address));
  }
}
