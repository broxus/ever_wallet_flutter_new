import 'dart:async';

import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/models.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/select_tokens/import_selected_tokens_modal.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/select_tokens/select_token_model.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/select_tokens/select_tokens_modal.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/select_tokens/token_data_element.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

SelectTokenWidgetModel defaultSelectTokenWidgetModelFactory(
  BuildContext context,
  Address address,
) {
  return SelectTokenWidgetModel(
    SelectTokenModel(
      createPrimaryErrorHandler(context),
      inject(),
      inject(),
      address,
      inject(),
    ),
  );
}

//logic in this class was moved from check_seed_phrase_cubit.dart
class SelectTokenWidgetModel
    extends CustomWidgetModel<SelectTokenWidget, SelectTokenModel> {
  SelectTokenWidgetModel(
    super.model,
  ) {
    _init();
  }

  ThemeStyleV2 get themeStyle => context.themeStyleV2;
  late StreamSubscription<dynamic> _subscription;
  late final _data = createNotifier<List<TokenDataElement>>();
  late final _isAllSelected = createNotifier<bool>();
  late final _isButtonEnabled = createNotifier<bool>();

  ListenableState<List<TokenDataElement>> get tokenContract => _data;

  ListenableState<bool> get isAllSelected => _isAllSelected;

  ListenableState<bool> get isButtonEnabled => _isButtonEnabled;

  void checkTokenSelection(TokenDataElement token) {
    final updatedTokens = _data.value?.map((entry) {
      if (entry.asset == token.asset) {
        return TokenDataElement(
          asset: entry.asset,
          isSelected: token.isSelected,
          value: entry.value,
        );
      }
      return entry;
    }).toList();
    _data.accept(updatedTokens);
    _checkIfAllSelected();
    _checkIfAnySelected();
  }

  void clickAll() {
    final allSelected = _isAllSelected.value ?? false;
    final updatedTokens = _data.value?.map((entry) {
      return TokenDataElement(
        asset: entry.asset,
        isSelected: !allSelected,
        value: entry.value,
      );
    }).toList();

    _isAllSelected.accept(!allSelected);
    _isButtonEnabled.accept(!allSelected);
    _data.accept(updatedTokens);
  }

  Future<void> clickImport() async {
    if (_data.value != null) {
      Navigator.of(context).pop();
      await showImportSelectedTokensModal(context, () async {
        await model.cachedAccount?.addTokenWallets(
          _data.value!
              .where((entry) => entry.isSelected)
              .map((entry) => entry.asset.address)
              .toList(),
        );
      });
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    model.dispose();
    super.dispose();
  }

  Future<void> _init() async {
    _subscription = model.contractsForAccount().listen((value) {
      value.$1.removeWhere((e) {
        final tokenBalance = model.balanceStorage.balances[model.address]
            ?.tokenBalance(e.address)
            ?.tokenBalance;
        return tokenBalance == null || tokenBalance.amount == Fixed.zero;
      });
      _data.accept(
        value.$1.map((e) {
          final tokenBalance = model.balanceStorage.balances[model.address]
              ?.tokenBalance(e.address)
              ?.tokenBalance;

          return TokenDataElement(
            asset: e,
            isSelected: false,
            value: tokenBalance,
          );
        }).toList(),
      );
    });
    _isAllSelected.accept(false);
    _isButtonEnabled.accept(false);
  }

  void _checkIfAllSelected() {
    final allChecked = _data.value?.every((entry) => entry.isSelected) ?? false;
    if (allChecked != _isAllSelected.value) {
      _isAllSelected.accept(allChecked);
    }
  }

  void _checkIfAnySelected() {
    final anySelected = _data.value?.any((entry) => entry.isSelected) ?? false;
    _isButtonEnabled.accept(anySelected);
  }
}
