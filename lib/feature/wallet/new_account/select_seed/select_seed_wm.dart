import 'package:app/app/router/router.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/new_account/add_account_confirm/add_new_account_confirm_sheet.dart';
import 'package:app/feature/wallet/new_account/select_seed/select_seed_model.dart';
import 'package:app/feature/wallet/new_account/select_seed/select_seed_view.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/theme_style_v2.dart';

SelectSeedWidgetModel defaultSelectSeedWidgetModelFactory(
  BuildContext context,
) =>
    SelectSeedWidgetModel(
      SelectSeedModel(
        createPrimaryErrorHandler(context),
        inject(),
        inject(),
        inject(),
      ),
    );

class SelectSeedWidgetModel
    extends CustomWidgetModel<SelectSeedWidget, SelectSeedModel> {
  SelectSeedWidgetModel(super.model);

  late final _currentAccount = createNotifierFromStream(model.currentAccount);
  late final _list = createNotifierFromStream(model.seedWithAccounts);

  ListenableState<List<Seed>> get list => _list;

  ListenableState<Seed?> get currentAccount => _currentAccount;

  ThemeStyleV2 get theme => context.themeStyleV2;

  bool hasCurrentAccount(Seed seed) {
    return model.getCurrentKey() == seed.publicKey;
  }

  void selectSeed(Seed seed) {
    _currentAccount.accept(seed);
  }

  Future<void> onSelect() async {
    final seed = _currentAccount.value;

    if (contextSafe == null || seed == null) {
      return;
    }

    if (seed.masterKey.isLegacy) {
      contextSafe!.goFurther(
        AppRoute.walletNewAccount.pathWithData(
          queryParameters: {
            walletCreatePublicKeyQueryParam: seed.publicKey.publicKey,
          },
        ),
      );
      return;
    }

    final result = await showAddAccountConfirmSheet(
      context: contextSafe!,
      publicKey: seed.publicKey,
      seedName: seed.name,
    );

    if (contextSafe != null && result != null) {
      contextSafe!.goFurther(
        AppRoute.walletNewAccount.pathWithData(
          queryParameters: {
            walletCreatePublicKeyQueryParam: result.$1.publicKey,
            walletCreatePasswordQueryParam: result.$2,
          },
        ),
      );
    }
  }
}
