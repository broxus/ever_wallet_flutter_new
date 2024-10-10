import 'package:app/utils/utils.dart';
import 'package:app/widgets/user_avatar/user_avatar.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class AccountListItem extends StatelessWidget {
  const AccountListItem({
    required this.account,
    required this.balance,
    required this.onTap,
    required this.active,
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
      onTap: onTap,
      child: ColoredBox(
        color: active ? theme.colors.background3 : theme.colors.background2,
        child: Padding(
          padding: const EdgeInsets.all(DimensSizeV2.d16),
          child: SeparatedRow(
            children: [
              UserAvatar(
                address: account.address.address,
              ),
              Expanded(
                child: SeparatedColumn(
                  separatorSize: DimensSizeV2.d2,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
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
      ),
    );
  }
}
