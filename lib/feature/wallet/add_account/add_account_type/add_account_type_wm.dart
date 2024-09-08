import 'dart:async';

import 'package:app/app/router/router.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/add_account/add_account.dart';
import 'package:app/feature/wallet/add_account/add_account_type/add_account_type_model.dart';
import 'package:collection/collection.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

AddAccountTypeWidgetModel defaultAddAccountTypeWidgetModelFactory(
  BuildContext context,
) =>
    AddAccountTypeWidgetModel(
      AddAccountTypeModel(
        createPrimaryErrorHandler(context),
        inject(),
        inject(),
      ),
    );

class AddAccountTypeWidgetModel
    extends CustomWidgetModel<AddAccountTypeWidget, AddAccountTypeModel> {
  AddAccountTypeWidgetModel(super.model);

  late final controller = createTextEditingController();
  late final availableTypes = List<WalletType>.from(
    model.transport.availableWalletTypes,
  );
  late final defaultType = model.transport.defaultWalletType;
  late final defaultMultisigType = availableTypes.firstWhereOrNull(
    (item) => item == const WalletType.multisig(MultisigType.multisig2_1),
  );
  late final deprecatedTypes = availableTypes.where(
    (item) => item != defaultType && item != defaultMultisigType,
  );

  late final _loading = createValueNotifier(false);
  late final _selected = createNotifier(defaultType);
  late final _showDeprecated = createNotifier(false);

  ValueListenable<bool> get loading => _loading;

  ListenableState<WalletType> get selected => _selected;

  ListenableState<bool> get showDeprecated => _showDeprecated;

  ThemeStyleV2 get theme => context.themeStyleV2;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
  }

  String getWalletName(WalletType walletType) =>
      model.transport.defaultAccountName(walletType);

  void onSelect(WalletType walletType) => _selected.accept(walletType);

  // ignore: avoid_positional_boolean_parameters
  void onShowDeprecatedChanged(bool value) => _showDeprecated.accept(value);

  Future<void> onSubmit() async {
    final walletType = selected.value!;
    final name = controller.text;

    try {
      _loading.value = true;

      final accountAddress = await model.createAccount(
        walletType: walletType,
        publicKey: widget.publicKey,
        name: name.isEmpty ? null : name,
        password: widget.password,
      );

      if (contextSafe != null) {
        await showAddAccountResultSheet(
          context: contextSafe!,
          address: accountAddress,
        );
        contextSafe!.goNamed(AppRoute.wallet.name);
      }
    } on FfiException catch (e) {
      model.showError(e.message);
    } on Exception catch (e) {
      model.showError(e.toString());
    } finally {
      _loading.value = false;
    }
  }
}