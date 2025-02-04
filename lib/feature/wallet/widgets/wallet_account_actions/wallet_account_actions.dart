// ignore_for_file: lines_longer_than_80_chars, unused_element

import 'package:app/app/router/router.dart';
import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/feature/wallet/wallet_deploy/widgets/deploy_wallet_min_ever_modal.dart';
import 'package:app/feature/wallet/widgets/account_settings/account_settings.dart';
import 'package:app/feature/wallet/widgets/wallet_account_actions/wallet_account_actions_cubit.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:app/v1/feature/add_seed/enter_seed_name/enter_seed_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';

/// Row with actions for current account.
/// If account is null, then no actions available.
class WalletAccountActions extends StatelessWidget {
  const WalletAccountActions({
    required this.currentAccount,
    this.allowStake = true,
    this.sendSpecified = false,
    this.padding = const EdgeInsets.symmetric(vertical: DimensSizeV2.d32),
    super.key,
  });

  final KeyAccount? currentAccount;
  final bool allowStake;

  /// If send action should be navigated to send specified token or select token
  final bool sendSpecified;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final account = currentAccount;

    return AnimatedOpacity(
      opacity: account == null ? 0 : 1,
      duration: const Duration(milliseconds: 400),
      child: account == null
          ? IgnorePointer(
              child: _ActionList(
                action: WalletAccountActionBehavior.send,
                padding: padding,
              ),
            )
          // TODO(komarov): elementary
          : BlocProvider<WalletAccountActionsCubit>(
              key: Key('WalletAccountActions-${account.address}'),
              create: (_) => WalletAccountActionsCubit(
                inject<NekotonRepository>(),
                account.address,
                inject(),
              ),
              child: BlocBuilder<WalletAccountActionsCubit,
                  WalletAccountActionsState>(
                builder: (context, state) {
                  return state.when(
                    loading: (hasStake, nativeTokenTicker) => _ActionList(
                      action: WalletAccountActionBehavior.send,
                      hasStake: hasStake && allowStake,
                      sendSpecified: sendSpecified,
                      padding: padding,
                      nativeTokenTicker: nativeTokenTicker,
                    ),
                    data: (
                      action,
                      hasStake,
                      hasStakeActions,
                      balance,
                      minBalance,
                      custodians,
                      nativeTokenTicker,
                      numberUnconfirmedTransactions,
                    ) =>
                        _ActionList(
                      account: account,
                      action: action,
                      hasStake: hasStake && allowStake,
                      hasStakeActions: hasStakeActions,
                      sendSpecified: sendSpecified,
                      padding: padding,
                      balance: balance,
                      minBalance: minBalance,
                      custodians: custodians,
                      nativeTokenTicker: nativeTokenTicker,
                      numberUnconfirmedTransactions:
                          numberUnconfirmedTransactions,
                    ),
                  );
                },
              ),
            ),
    );
  }
}

class _ActionList extends StatelessWidget {
  const _ActionList({
    required this.action,
    required this.padding,
    this.nativeTokenTicker,
    this.account,
    this.hasStake = false,
    this.hasStakeActions = false,
    this.sendSpecified = false,
    this.balance,
    this.minBalance,
    this.custodians,
    this.numberUnconfirmedTransactions,
  });

  final WalletAccountActionBehavior action;
  final KeyAccount? account;
  final bool hasStake;
  final bool hasStakeActions;
  final bool sendSpecified;
  final EdgeInsetsGeometry padding;
  final BigInt? balance;
  final BigInt? minBalance;
  final List<PublicKey>? custodians;
  final String? nativeTokenTicker;
  final int? numberUnconfirmedTransactions;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return Padding(
      padding: padding,
      child: SizedBox(
        height: DimensSizeV2.d74,
        child: SeparatedRow(
          separator: VerticalDivider(
            width: DimensStroke.small,
            thickness: DimensStroke.small,
            color: theme.colors.borderAlpha,
          ),
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            WalletActionButton(
              label: LocaleKeys.receiveWord.tr(),
              icon: LucideIcons.arrowDown,
              onPressed: account?.let(
                (value) => () => showReceiveFundsSheet(context, value.address),
              ),
            ),
            WalletActionButton(
              label: _actionTitle(action),
              icon: _actionIcon(action),
              onPressed: account?.let(
                (_) => _actionOnPressed(
                  context: context,
                  balance: balance,
                  minBalance: minBalance,
                  numberUnconfirmedTransactions: numberUnconfirmedTransactions,
                ),
              ),
            ),
            if (hasStake)
              WalletActionButton(
                label: LocaleKeys.stakeWord.tr(),
                icon: LucideIcons.layers2,
                badge: hasStakeActions,
                onPressed: account?.let(
                  (account) => () {
                    if ((numberUnconfirmedTransactions ?? 0) >= 5) {
                      inject<MessengerService>().show(
                        Message.error(
                          context: context,
                          message: LocaleKeys
                              .errorMessageMaxUnconfirmedTransactions
                              .tr(),
                        ),
                      );
                    } else {
                      context.goFurther(
                        AppRoute.walletStake.pathWithData(
                          pathParameters: {
                            walletStakeAddressPathParam:
                                account.address.address,
                          },
                        ),
                      );
                    }
                  },
                ),
              ),
            if (!sendSpecified)
              WalletActionButton(
                label: LocaleKeys.info.tr(),
                icon: LucideIcons.ellipsis,
                onPressed: () {
                  if (account != null) {
                    showAccountSettingsModal(
                      context: context,
                      account: account!,
                      custodians: custodians,
                    );
                  }
                },
              ),
          ],
        ),
      ),
    );
  }

  IconData _actionIcon(WalletAccountActionBehavior action) => switch (action) {
        WalletAccountActionBehavior.deploy => LucideIcons.settings,
        _ => LucideIcons.arrowUp,
      };

  String _actionTitle(WalletAccountActionBehavior action) => switch (action) {
        WalletAccountActionBehavior.deploy => LocaleKeys.deployWord.tr(),
        _ => LocaleKeys.sendWord.tr(),
      };

  VoidCallback _actionOnPressed({
    required BuildContext context,
    BigInt? balance,
    BigInt? minBalance,
    int? numberUnconfirmedTransactions,
  }) =>
      switch (action) {
        WalletAccountActionBehavior.send => () {
            if ((numberUnconfirmedTransactions ?? 0) >= 5) {
              inject<MessengerService>().show(
                Message.error(
                  context: context,
                  message:
                      LocaleKeys.errorMessageMaxUnconfirmedTransactions.tr(),
                ),
              );
            } else if (sendSpecified) {
              final transport = inject<NekotonRepository>().currentTransport;
              context.goFurther(
                AppRoute.walletPrepareTransferSpecified.pathWithData(
                  pathParameters: {
                    walletPrepareTransferAddressPathParam:
                        account!.address.address,
                    walletPrepareTransferRootTokenAddressPathParam:
                        transport.nativeTokenAddress.address,
                    walletPrepareTransferSymbolPathParam:
                        transport.nativeTokenTicker,
                  },
                ),
              );
            } else {
              context.goFurther(
                AppRoute.walletPrepareTransfer.pathWithData(
                  pathParameters: {
                    walletPrepareTransferAddressPathParam:
                        account!.address.address,
                  },
                ),
              );
            }
          },
        // ignore: no-empty-block
        WalletAccountActionBehavior.deploy => () {
            if ((balance ?? BigInt.zero) >= (minBalance ?? BigInt.zero)) {
              context.goFurther(
                AppRoute.walletDeploy.pathWithData(
                  pathParameters: {
                    walletDeployAddressPathParam: account!.address.address,
                    walletDeployPublicKeyPathParam:
                        account!.publicKey.publicKey,
                  },
                ),
              );
            } else {
              if (nativeTokenTicker != null) {
                showDeployMinEverModal(
                  context: context,
                  account: account!,
                  minAmount: minBalance!,
                  symbol: nativeTokenTicker!,
                );
              }
            }
          },
        WalletAccountActionBehavior.sendLocalCustodiansNeeded => () =>
            inject<MessengerService>().show(
              Message.error(
                context: context,
                message: LocaleKeys.toSendMultisigAddCustodian.tr(),
                actionText: LocaleKeys.addWord.tr(),
                onAction: () => _showAddSeedSheet(context),
              ),
            ),
      };

  Future<void> _showAddSeedSheet(BuildContext context) async {
    if (!context.mounted) return;

    final selected = await showSelectAddSeedTypeSheet(context);

    if (context.mounted && selected != null) {
      switch (selected) {
        case SelectAddSeedType.create:
          context.goFurther(
            AppRoute.enterSeedName.pathWithData(
              pathParameters: {
                enterSeedNameCommandPathParam: EnterSeedNameCommand.create.name,
              },
            ),
          );
        case SelectAddSeedType.import:
          context.goFurther(
            AppRoute.enterSeedName.pathWithData(
              pathParameters: {
                enterSeedNameCommandPathParam: EnterSeedNameCommand.import.name,
              },
            ),
          );
      }
    }
  }
}
