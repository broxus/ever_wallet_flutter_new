// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: invalid_use_of_visible_for_testing_member
import 'package:app/feature/wallet/widgets/account_asset_tab/select_tokens/empty_tokens_body.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/select_tokens/select_token_wm.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/select_tokens/tokens_modal_body.dart';
import 'package:app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/widgets.dart';

Future<void> showSelectTokesModal(
  BuildContext context,
  Address address,
  VoidCallback confirmImportCallback,
) {
  return showCommonBottomSheet(
    context: context,
    title: LocaleKeys.selectTokensLabel.tr(),
    centerTitle: true,
    titleTextStyle: context.themeStyleV2.textStyles.headingLarge,
    body: (_, scrollController) => SelectTokenWidget(
      address: address,
      confirmImportCallback: confirmImportCallback,
    ),
  );
}

class SelectTokenWidget extends ElementaryWidget<SelectTokenWidgetModel> {
  const SelectTokenWidget({
    required this.address,
    required this.confirmImportCallback,
    Key? key,
    WidgetModelFactory wmFactory = defaultSelectTokenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  final Address address;
  final VoidCallback confirmImportCallback;

  @override
  Widget build(SelectTokenWidgetModel wm) {
    return TripleSourceBuilder(
      firstSource: wm.tokenContract,
      secondSource: wm.isAllSelected,
      thirdSource: wm.loading,
      builder: (_, value, allSelected, loading) {
        final isEmpty = (value?.isEmpty ?? false) && loading == false;
        final isButtonEnabled =
            !(loading ?? false) && (value?.any((e) => e.isSelected) ?? false);

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isEmpty)
                      const EmptyTokensWidget()
                    else
                      TokensModalBody(
                        assets: value!,
                        onChecked: wm.checkTokenSelection,
                        onClickAll: wm.clickAll,
                        isAllSelected: allSelected ?? false,
                        isLoading: loading ?? false,
                        onClickImport: wm.clickImport,
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: DimensSizeV2.d12),
            if (value != null)
              AccentButton(
                buttonShape: ButtonShape.pill,
                title: LocaleKeys.importWalletButtonText.tr(),
                onPressed: isButtonEnabled
                    ? () {
                        confirmImportCallback();
                        wm.clickImport();
                      }
                    : null,
              ),
            const SizedBox(height: DimensSizeV2.d8),
            PrimaryButton(
              buttonShape: ButtonShape.pill,
              title: LocaleKeys.backWord.tr(),
              onPressed: () => Navigator.of(wm.context).pop(),
            ),
            const SizedBox(height: DimensSizeV2.d12),
          ],
        );
      },
    );
  }
}
