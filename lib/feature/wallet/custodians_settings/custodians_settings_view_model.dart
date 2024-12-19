import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/custodians_settings/custodian_data.dart';
import 'package:app/feature/wallet/custodians_settings/custodians_settings_model.dart';
import 'package:app/feature/wallet/custodians_settings/custodians_settings_view.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

CustodianSettingsWidgetModel defaultCustodianSettingsWidgetModelFactory(
  BuildContext context,
  List<String> custodians,
) =>
    CustodianSettingsWidgetModel(
      CustodiansSettingsModel(
        createPrimaryErrorHandler(context),
        inject(),
        inject(),
        custodians,
      ),
    );

class CustodianSettingsWidgetModel
    extends CustomWidgetModel<CustodiansSettingsView, CustodiansSettingsModel> {
  CustodianSettingsWidgetModel(super.model);

  final StateNotifier<List<CustodianData>> _custodiansNotifier =
      StateNotifier();

  ThemeStyleV2 get theme => context.themeStyleV2;

  ListenableState<List<CustodianData>> get custodians => _custodiansNotifier;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _loadCustodians();
  }

  Future<void> _loadCustodians() async {
    final custodians = await model.initializeCustodians();
    _custodiansNotifier.accept(custodians);
  }

  Future<void> renameCustodian(PublicKey key, String newName) async {
    await model.rename(key, newName);
    final updatedCustodians = _custodiansNotifier.value?.map((custodian) {
      if (custodian.key.publicKey == key.publicKey) {
        return CustodianData(name: newName, key: key);
      }
      return custodian;
    }).toList();

    _custodiansNotifier.accept(updatedCustodians ?? []);

    model.showSuccessfulMessage();
  }
}
