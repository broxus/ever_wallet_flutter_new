// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:app/app/router/router.dart';
import 'package:app/app/service/connection/connection_service.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/new_account/add_account.dart';
import 'package:app/feature/wallet/new_account/new_account_type/new_account_type_model.dart';
import 'package:collection/collection.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

NewAccountTypeWidgetModel defaultNewAccountTypeWidgetModelFactory(
  BuildContext context,
) =>
    NewAccountTypeWidgetModel(
      NewAccountTypeModel(
        createPrimaryErrorHandler(context),
        inject(),
        inject(),
      ),
    );

class NewAccountTypeWidgetModel
    extends CustomWidgetModel<NewAccountTypeWidget, NewAccountTypeModel> {
  NewAccountTypeWidgetModel(super.model);

  late final controller = createTextEditingController();
  late final availableTypes = List<WalletType>.from(
    model.transport.availableWalletTypes,
  );
  late final defaultType = model.transport.defaultWalletType;
  late final defaultMultisigType = availableTypes.firstWhereOrNull(
    (item) => item == const WalletType.multisig(MultisigType.multisig2_1),
  );
  late final deprecatedTypes = availableTypes.where(
    (item) => !_standartTypes.contains(item),
  );

  late final _loading = createNotifier(false);
  late final _selected = createNotifier(defaultType);
  late final _showDeprecated = createNotifier(false);

  // Hamster network workaround
  late final Set<WalletType> _standartTypes = isHmstr
      ? {
          const WalletType.walletV5R1(),
          defaultType,
          if (defaultMultisigType != null) defaultMultisigType!,
        }
      : {
          defaultType,
          if (defaultMultisigType != null) defaultMultisigType!,
        };

  ListenableState<bool> get loading => _loading;

  ListenableState<WalletType> get selected => _selected;

  ListenableState<bool> get showDeprecated => _showDeprecated;

  ThemeStyleV2 get theme => context.themeStyleV2;

  // TODO(knightforce): how to get rid of explicit check?
  bool get isEverscale => model.transport.networkType == 'ever';

  // Hamster network workaround
  bool get isHmstr => model.transport.networkGroup.startsWith('hmstr');

  Set<WalletType> get disabledWalletTypes => widget.password == null
      ? model.getCreatedAccountTypes(widget.publicKey).toSet()
      : {};

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

    if (disabledWalletTypes.contains(walletType)) return;

    try {
      _loading.accept(true);

      final accountAddress = await model.createAccount(
        walletType: walletType,
        publicKey: widget.publicKey,
        name: name.isEmpty ? null : name,
        password: widget.password,
      );

      if (contextSafe != null) {
        await showNewAccountResultSheet(
          context: contextSafe!,
          address: accountAddress,
        );
        contextSafe!.goNamed(AppRoute.wallet.name);
      }
    } on Exception catch (e) {
      model.showError(context, e.toString());
    } finally {
      _loading.accept(false);
    }
  }
}
