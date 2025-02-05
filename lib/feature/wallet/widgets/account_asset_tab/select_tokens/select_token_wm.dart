import 'dart:async';

import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/select_tokens/import_selected_tokens_modal.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/select_tokens/select_token_model.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/select_tokens/select_tokens_modal.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/select_tokens/token_data_element.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

SelectTokenWidgetModel defaultSelectTokenWidgetModelFactory(
  BuildContext context,
) {
  return SelectTokenWidgetModel(
    SelectTokenModel(
      createPrimaryErrorHandler(context),
      inject(),
      inject(),
    ),
  );
}

//logic in this class was moved from check_seed_phrase_cubit.dart
class SelectTokenWidgetModel
    extends CustomWidgetModel<SelectTokenWidget, SelectTokenModel> {
  SelectTokenWidgetModel(
    super.model,
  );

  late final _data = createNotifier<List<TokenDataElement>>([]);
  late final _loading = createNotifier(true);
  late final _isAllSelected = createNotifier(false);

  ListenableState<List<TokenDataElement>> get tokenContract => _data;

  ListenableState<bool> get isAllSelected => _isAllSelected;

  ListenableState<bool> get loading => _loading;

  ThemeStyleV2 get themeStyle => context.themeStyleV2;

  @override
  void initWidgetModel() {
    model.getAssets(widget.address).listen(
      (value) {
        final data = [
          ...?_data.value,
          for (final item in value)
            if (!item.$1.isCustom)
              TokenDataElement(
                asset: item.$1,
                isSelected: false,
                value: item.$2,
              ),
        ];

        _data.accept(data);
      },
      onDone: () => _loading.accept(false),
      onError: (_) => _loading.accept(false),
    );

    super.initWidgetModel();
  }

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
    _data.accept(updatedTokens);
  }

  Future<void> clickImport() async {
    final account = model.getAccount(widget.address);

    if (_data.value != null && account != null) {
      await showImportSelectedTokensModal(context, () async {
        Navigator.of(context).pop();
        await account.addTokenWallets(
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

  void _checkIfAllSelected() {
    final allChecked = _data.value?.every((entry) => entry.isSelected) ?? false;
    if (allChecked != _isAllSelected.value) {
      _isAllSelected.accept(allChecked);
    }
  }
}
