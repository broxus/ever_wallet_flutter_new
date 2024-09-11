import 'package:app/feature/wallet/widgets/select_account/select_account_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
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
            builder: (_, list, currentAccount) => ListView.builder(
              itemCount: list?.length ?? 0,
              itemBuilder: (_, index) => list?.let(
                (list) {
                  final account = list[index];
                  return _AccountItem(
                    key: ValueKey(account),
                    account: account,
                    balance: wm.getBalanceEntity(account),
                    active: account == currentAccount,
                    onTap: () => wm.onSelect(account),
                  );
                },
              ),
            ),
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

class _AccountItem extends StatelessWidget {
  const _AccountItem({
    required this.account,
    required this.balance,
    required this.active,
    required this.onTap,
    super.key,
  });

  final KeyAccount account;
  final ListenableState<Money> balance;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    final address = account.address.toEllipseString();
    final pk = account.publicKey.toEllipseString();
    final textStyle = theme.textStyles.labelXSmall.copyWith(
      color: theme.colors.content3,
    );

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: DimensSizeV2.d12),
        child: SeparatedRow(
          children: [
            Image.asset(
              Assets.images.userAvatar.userAvatar.path,
              width: DimensSizeV2.d40,
              height: DimensSizeV2.d40,
            ),
            Expanded(
              child: SeparatedColumn(
                separatorSize: DimensSizeV2.d4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    account.name,
                    style: theme.textStyles.labelMedium,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    maxLines: 1,
                  ),
                  Row(
                    children: [
                      Text('$address • $pk • ', style: textStyle),
                      StateNotifierBuilder(
                        listenableState: balance,
                        builder: (_, balance) =>
                            balance?.let(
                              (value) => Expanded(
                                child: AmountWidget.fromMoney(
                                  amount: balance,
                                  style: textStyle,
                                ),
                              ),
                            ) ??
                            ProgressIndicatorWidget(
                              size: DimensSizeV2.d16,
                              color: theme.colors.content3,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (active) const Icon(LucideIcons.check, size: DimensSizeV2.d20),
          ],
        ),
      ),
    );
  }
}
