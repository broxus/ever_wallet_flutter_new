import 'package:app/feature/browser/approvals_listener/actions/request_permissions/account_list_item/account_list_item_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class AccountListItemWidget
    extends ElementaryWidget<AccountListItemWidgetModel> {
  const AccountListItemWidget({
    required this.account,
    required this.onTap,
    this.active = false,
    Key? key,
    WidgetModelFactory wmFactory = defaultAccountListItemWidgetModelFactory,
  }) : super(wmFactory, key: key);

  final KeyAccount account;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(AccountListItemWidgetModel wm) => DoubleSourceBuilder(
        firstSource: wm.balance,
        secondSource: wm.active,
        builder: (_, balance, active) => _AccountListItem(
          name: account.name,
          balance: balance,
          active: active ?? false,
          onTap: onTap,
        ),
      );
}

class _AccountListItem extends StatelessWidget {
  const _AccountListItem({
    required this.name,
    required this.balance,
    required this.onTap,
    required this.active,
  });

  final String name;
  final Money? balance;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return GestureDetector(
      onTap: onTap,
      child: ColoredBox(
        color: active ? theme.colors.background3 : theme.colors.background2,
        child: Padding(
          padding: const EdgeInsets.all(DimensSizeV2.d16),
          child: SeparatedRow(
            children: [
              Image.asset(
                Assets.images.userAvatar.userAvatar.path,
                width: DimensSizeV2.d40,
                height: DimensSizeV2.d40,
              ),
              Expanded(
                child: SeparatedColumn(
                  separatorSize: DimensSizeV2.d2,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: theme.textStyles.labelMedium,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      maxLines: 1,
                    ),
                    if (balance != null)
                      AmountWidget.fromMoney(
                        amount: balance!,
                        style: theme.textStyles.labelXSmall.copyWith(
                          color: theme.colors.content3,
                        ),
                      ),
                  ],
                ),
              ),
              if (active) const Icon(LucideIcons.check, size: DimensSizeV2.d20),
            ],
          ),
        ),
      ),
    );
  }
}
