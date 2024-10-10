import 'package:app/feature/network/network.dart';
import 'package:app/feature/wallet/widgets/wallet_app_bar/wallet_app_bar_wm.dart';
import 'package:app/utils/utils.dart';
import 'package:app/widgets/user_avatar/user_avatar.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class WalletAppBarWidget extends ElementaryWidget<WalletAppBarWidgetModel>
    implements PreferredSizeWidget {
  const WalletAppBarWidget({
    Key? key,
    WidgetModelFactory wmFactory = defaultWalletAppBarWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Size get preferredSize => const Size.fromHeight(DimensSizeV2.d68);

  @override
  Widget build(WalletAppBarWidgetModel wm) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: DimensSizeV2.d12,
          horizontal: DimensSizeV2.d16,
        ),
        child: SeparatedRow(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: DoubleSourceBuilder(
                firstSource: wm.currentAccount,
                secondSource: wm.walletState,
                builder: (_, account, walletState) =>
                    account?.let(
                      (value) => _AccountInfo(
                        account: value,
                        walletState: walletState,
                        walletTypeName: wm.getWalletTypeName(
                          account.account.tonWallet.contract,
                        ),
                        onTap: wm.onSettings,
                      ),
                    ) ??
                    const SizedBox.shrink(),
              ),
            ),
            FloatButton(
              buttonShape: ButtonShape.circle,
              buttonSize: ButtonSize.small,
              onPressed: wm.onNetwork,
              child: StateNotifierBuilder(
                listenableState: wm.connection,
                builder: (_, connection) =>
                    connection?.let(
                      (value) => NetworkIcon(type: value.networkType),
                    ) ??
                    const SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AccountInfo extends StatelessWidget {
  const _AccountInfo({
    required this.account,
    required this.walletState,
    required this.walletTypeName,
    required this.onTap,
  });

  final KeyAccount account;
  final TonWalletState? walletState;
  final String walletTypeName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    final custodians = walletState?.wallet?.custodians?.length ?? 1;
    final requiredConfirmations =
        walletState?.wallet?.details.requiredConfirmations;

    return GestureDetector(
      onTap: onTap,
      child: SeparatedRow(
        children: [
          UserAvatar(
            address: account.address.address,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  account.name,
                  style: theme.textStyles.headingXSmall,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  maxLines: 1,
                ),
                Row(
                  children: [
                    Icon(
                      LucideIcons.alignCenter,
                      size: DimensSizeV2.d16,
                      color: theme.colors.content3,
                    ),
                    const SizedBox(width: DimensSizeV2.d4),
                    Flexible(
                      child: Text(
                        walletTypeName,
                        style: theme.textStyles.labelXSmall.copyWith(
                          color: theme.colors.content3,
                        ),
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(width: DimensSizeV2.d8),
                    if (requiredConfirmations != null && custodians > 1)
                      SeparatedRow(
                        separatorSize: DimensSizeV2.d4,
                        children: [
                          Icon(
                            LucideIcons.usersRound,
                            size: DimensSizeV2.d16,
                            color: theme.colors.content3,
                          ),
                          Text(
                            '$requiredConfirmations/$custodians',
                            style: theme.textStyles.labelXSmall.copyWith(
                              color: theme.colors.content3,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
