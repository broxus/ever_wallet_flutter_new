import 'package:app/feature/network/network.dart';
import 'package:app/feature/wallet/widgets/wallet_app_bar/wallet_app_bar_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
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
                      ),
                    ) ??
                    const SizedBox.shrink(),
              ),
            ),
            SeparatedRow(
              separatorSize: DimensSizeV2.d12,
              children: [
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
                FloatButton(
                  buttonShape: ButtonShape.circle,
                  buttonSize: ButtonSize.small,
                  icon: LucideIcons.cog,
                  onPressed: wm.onSettings,
                ),
              ],
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
  });

  final KeyAccount account;
  final TonWalletState? walletState;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    final contract = account.account.tonWallet.contract;
    final custodians = walletState?.wallet?.custodians?.length ?? 1;
    final requiredConfirmations =
        walletState?.wallet?.details.requiredConfirmations;

    return SeparatedRow(
      children: [
        ClipOval(
          child: Image.asset(
            Assets.images.userAvatar.userAvatar.path,
            width: DimensSizeV2.d40,
            height: DimensSizeV2.d40,
          ),
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
                      contract.toReadableName(),
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
    );
  }
}

extension on WalletType {
  String toReadableName() => when(
        multisig: (type) => switch (type) {
          MultisigType.safeMultisigWallet => 'SafeMultisig24h',
          MultisigType.safeMultisigWallet24h => 'SafeMultisig24h',
          MultisigType.setcodeMultisigWallet => 'SetcodeMultisig',
          MultisigType.setcodeMultisigWallet24h => 'SetcodeMultisig24h',
          MultisigType.bridgeMultisigWallet => 'BridgeMultisig',
          MultisigType.surfWallet => 'Surf wallet',
          MultisigType.multisig2 => 'Multisig',
          MultisigType.multisig2_1 => 'Multisig 2.1',
        },
        walletV3: () => 'WalletV3',
        highloadWalletV2: () => 'HighloadWalletV2',
        everWallet: () => 'EVER Wallet',
      );
}
