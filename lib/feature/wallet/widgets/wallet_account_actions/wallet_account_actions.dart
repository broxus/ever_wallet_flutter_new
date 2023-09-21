import 'package:app/app/router/router.dart';
import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/add_seed/enter_seed_name/enter_seed_name.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/feature/wallet/widgets/wallet_account_actions/wallet_account_actions_cubit.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';

/// Row with actions for current account.
/// If account is null, then no actions available.
class WalletAccountActions extends StatelessWidget {
  const WalletAccountActions({
    required this.currentAccount,
    this.allowStake = true,
    this.sendSpecified = false,
    super.key,
  });

  final KeyAccount? currentAccount;
  final bool allowStake;

  /// If send action should be navigated to send specified token or select token
  final bool sendSpecified;

  @override
  Widget build(BuildContext context) {
    final account = currentAccount;
    if (account == null) return const SizedBox.shrink();

    return BlocProvider<WalletAccountActionsCubit>(
      key: Key('WalletAccountActions-${account.address}'),
      create: (_) => WalletAccountActionsCubit(
        inject<NekotonRepository>(),
        account.address,
        inject(),
      ),
      child: BlocBuilder<WalletAccountActionsCubit, WalletAccountActionsState>(
        builder: (context, state) {
          return state.when(
            loading: () => const SizedBox.shrink(),
            data: (action, hasStake, hasStakeActions) {
              return SeparatedRow(
                separatorSize: DimensSize.d32,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buttonItem(
                    svg: Assets.images.arrowDown.path,
                    onPressed: () => showReceiveFundsSheet(
                      context,
                      currentAccount!.address,
                    ),
                    title: LocaleKeys.receiveWord.tr(),
                  ),
                  _buttonItem(
                    onPressed: _actionOnPressed(context, action),
                    svg: _actionIcon(action),
                    title: _actionTitle(action),
                  ),
                  if (hasStake && allowStake)
                    _buttonItem(
                      svg: Assets.images.stake.path,
                      onPressed: () => context.goFurther(
                        AppRoute.walletStake.pathWithData(
                          pathParameters: {
                            walletStakeAddressPathParam:
                                currentAccount!.address.address,
                          },
                        ),
                      ),
                      title: LocaleKeys.stakeWord.tr(),
                      showPoint: hasStakeActions,
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  String _actionIcon(WalletAccountActionBehavior action) => switch (action) {
        WalletAccountActionBehavior.deploy => Assets.images.deploy.path,
        _ => Assets.images.arrowUp.path,
      };

  String _actionTitle(WalletAccountActionBehavior action) => switch (action) {
        WalletAccountActionBehavior.deploy => LocaleKeys.deployWord.tr(),
        _ => LocaleKeys.sendWord.tr(),
      };

  VoidCallback _actionOnPressed(
    BuildContext context,
    WalletAccountActionBehavior action,
  ) =>
      switch (action) {
        WalletAccountActionBehavior.send => () {
            if (sendSpecified) {
              context.goFurther(
                AppRoute.walletPrepareTransferSpecified.pathWithData(
                  pathParameters: {
                    walletPrepareTransferAddressPathParam:
                        currentAccount!.address.address,
                    walletPrepareTransferRootTokenAddressPathParam:
                        inject<NekotonRepository>()
                            .currentTransport
                            .nativeTokenAddress
                            .address,
                  },
                ),
              );
            } else {
              context.goFurther(
                AppRoute.walletPrepareTransfer.pathWithData(
                  pathParameters: {
                    walletPrepareTransferAddressPathParam:
                        currentAccount!.address.address,
                  },
                ),
              );
            }
          },
        // ignore: no-empty-block
        WalletAccountActionBehavior.deploy => () => context.goFurther(
              AppRoute.walletDeploy.pathWithData(
                pathParameters: {
                  walletDeployAddressPathParam: currentAccount!.address.address,
                  walletDeployPublicKeyPathParam:
                      currentAccount!.publicKey.publicKey,
                },
              ),
            ),
        WalletAccountActionBehavior.sendLocalCustodiansNeeded => () =>
            inject<MessengerService>().show(
              Message.error(
                message: LocaleKeys.toSendMultisigAddCustodian.tr(),
                actionText: LocaleKeys.addWord.tr(),
                onAction: () => _showAddSeedSheet(context),
              ),
            ),
      };

  Widget _buttonItem({
    required String svg,
    required VoidCallback onPressed,
    required String title,
    bool showPoint = false,
  }) {
    return Builder(
      builder: (context) {
        final colors = context.themeStyle.colors;

        final button = CommonIconButton.svg(
          svg: svg,
          buttonType: EverButtonType.primary,
          onPressed: onPressed,
        );

        return SeparatedColumn(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showPoint)
              Stack(
                children: [
                  button,
                  Positioned(
                    top: DimensStroke.medium,
                    right: DimensStroke.medium,
                    child: Container(
                      width: DimensSize.d12,
                      height: DimensSize.d12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colors.blue,
                      ),
                    ),
                  ),
                ],
              )
            else
              button,
            Text(
              title,
              style: StyleRes.addBold.copyWith(color: colors.textPrimary),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showAddSeedSheet(BuildContext context) async {
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
