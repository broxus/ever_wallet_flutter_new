// ignore_for_file: inference_failure_on_function_return_type
import 'package:app/feature/wallet/widgets/select_account/select_account_wm.dart';
import 'package:app/feature/wallet/widgets/select_account/widgets/seed_item_widget.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class SelectAccountWidget extends ElementaryWidget<SelectAccountWidgetModel> {
  const SelectAccountWidget({
    required this.scrollController,
    Key? key,
    WidgetModelFactory wmFactory = defaultSelectAccountWidgetModelFactory,
  }) : super(wmFactory, key: key);

  final ScrollController scrollController;

  @override
  Widget build(SelectAccountWidgetModel wm) {
    return Column(
      children: [
        PrimaryTextField(
          textEditingController: wm.searchController,
          hintText: LocaleKeys.searchWord.tr(),
          onChanged: (_) => wm.onSearch(),
          onSubmit: (_) => wm.onSearch(),
        ),
        const SizedBox(height: DimensSizeV2.d24),
        Expanded(
          child: DoubleSourceBuilder(
            firstSource: wm.list,
            secondSource: wm.currentAccount,
            builder: (_, list, currentAccount) {
              return SingleChildScrollView(
                controller: scrollController,
                physics: const ClampingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    list?.length ?? 0,
                    (index) {
                      final data = list![index];
                      final isExpanded = data.hasCurrentAccount(currentAccount);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: DimensSizeV2.d8),
                        child: SeedItem(
                          data: data,
                          isExpanded: isExpanded,
                          key: ValueKey(data.name),
                          currentAccount: currentAccount,
                          onTapAccount: wm.onSelect,
                          getBalanceEntity: wm.getBalanceEntity,
                          scrollController: scrollController,
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: DimensSizeV2.d16),
        SeparatedColumn(
          children: [
            AccentButton(
              buttonShape: ButtonShape.pill,
              title: LocaleKeys.addAccount.tr(),
              postfixIcon: LucideIcons.plus,
              onPressed: wm.onAddAccount,
            ),
            PrimaryButton(
              buttonShape: ButtonShape.pill,
              title: LocaleKeys.manageSeedsAndAccounts.tr(),
              onPressed: wm.onManageSeedsAndAccounts,
            ),
          ],
        ),
      ],
    );
  }
}
