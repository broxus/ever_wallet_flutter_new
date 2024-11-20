// ignore_for_file: use_build_context_synchronously

import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/profile/manage_seeds_accounts/widgets/seed_settings_sheet.dart';
import 'package:app/feature/profile/seed_detail/view/seed_detail_page_model.dart';
import 'package:app/feature/profile/seed_detail/view/seed_detail_page_widget.dart';
import 'package:app/feature/profile/seed_detail/widgets/derive_keys_sheet/derive_keys_sheet_password.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

SeedDetailPageWidgetModel defaultSeedDetailPageWidgetModelFactory(
  BuildContext context,
) =>
    SeedDetailPageWidgetModel(
      SeedDetailPageModel(
        createPrimaryErrorHandler(context),
        inject(),
        inject(),
        inject(),
      ),
    );

class SeedDetailPageWidgetModel
    extends CustomWidgetModel<SeedDetailPageWidget, SeedDetailPageModel> {
  SeedDetailPageWidgetModel(super.model);

  late final _currentKey = createNotifierFromStream(model.currentKey);
  late final _currentSeed = createNotifierFromStream(model.currentSeed);
  late final _findingExistingWallets = createNotifierFromStream(
    model.findingExistingWallets,
  );
  late final _seed = createNotifierFromStream(
    model.getSeedStream(widget.publicKey),
  );

  StateNotifier<PublicKey?> get currentKey => _currentKey;

  StateNotifier<Seed?> get currentSeed => _currentSeed;

  StateNotifier<Set<String>> get findingExistingWallets =>
      _findingExistingWallets;

  StateNotifier<Seed?> get seed => _seed;

  ThemeStyleV2 get theme => context.themeStyleV2;

  void onSeedSettings() => showSeedSettingsSheet(context, widget.publicKey);

  void onAddkeys() => showDeriveKeysSheetPassword(context, widget.publicKey);
}
