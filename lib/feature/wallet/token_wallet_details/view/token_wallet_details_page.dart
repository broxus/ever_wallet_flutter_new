import 'package:app/app/router/router.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Details page of the [TokenWallet], that is used to look though transactions
/// history and to send/receive tokens.
class TokenWalletDetailsPage extends StatelessWidget {
  const TokenWalletDetailsPage({
    required this.owner,
    required this.rootTokenContract,
    super.key,
  });

  final Address owner;
  final Address rootTokenContract;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(),
      body: BlocProvider<TokenWalletDetailsCubit>(
        create: (_) => TokenWalletDetailsCubit(
          owner: owner,
          rootTokenContract: rootTokenContract,
          nekotonRepository: inject(),
          currencyConvertService: inject(),
          balanceService: inject(),
          assetsService: inject(),
        ),
        child: BlocBuilder<TokenWalletDetailsCubit, TokenWalletDetailsState>(
          builder: (context, state) {
            final colors = context.themeStyle.colors;

            return state.when(
              initial: () => const SizedBox.shrink(),
              empty: () => const SizedBox.shrink(),
              data: (
                contractName,
                account,
                tokenBalance,
                fiatBalance,
                canSend,
              ) {
                return CommonSlidingPanel(
                  // ignore: no-magic-number
                  minHeightSizePercent: 0.65,
                  maxHeightSizePercent: 1,
                  body: SeparatedColumn(
                    mainAxisSize: MainAxisSize.min,
                    separatorSize: DimensSize.d24,
                    children: [
                      _header(contractName, tokenBalance, fiatBalance),
                      _actions(canSend, context),
                    ],
                  ),
                  panelBuilder: (context, controller) => SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimensSize.d16,
                    ),
                    controller: controller,
                    child: SeparatedColumn(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.transactionsHistory.tr(),
                          style: StyleRes.h2.copyWith(
                            color: colors.textPrimary,
                          ),
                        ),
                        TokenWalletTransactionsWidget(
                          rootTokenContract: rootTokenContract,
                          owner: owner,
                        ),
                        const SizedBox(height: DimensSize.d8),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _header(
    String contractName,
    Money tokenBalance,
    Money fiatBalance,
  ) {
    return Builder(
      builder: (context) {
        final colors = context.themeStyle.colors;

        return SeparatedColumn(
          mainAxisSize: MainAxisSize.min,
          separatorSize: DimensSize.d4,
          children: [
            Text(
              contractName,
              style: StyleRes.addRegular.copyWith(color: colors.textSecondary),
            ),
            MoneyWidget(money: tokenBalance, style: MoneyWidgetStyle.primary),
            MoneyWidget(money: fiatBalance, style: MoneyWidgetStyle.secondary),
          ],
        );
      },
    );
  }

  Widget _actions(bool canSend, BuildContext context) {
    return SeparatedRow(
      separatorSize: DimensSize.d32,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buttonItem(
          svg: Assets.images.arrowDown.path,
          onPressed: () => showReceiveFundsSheet(context, owner),
          title: LocaleKeys.receiveWord.tr(),
        ),
        if (canSend)
          _buttonItem(
            onPressed: () => context.goFurther(
              AppRoute.walletPrepareTransferSpecified.pathWithData(
                pathParameters: {
                  walletPrepareTransferAddressPathParam: owner.address,
                  walletPrepareTransferRootTokenAddressPathParam:
                      rootTokenContract.address,
                },
              ),
            ),
            svg: Assets.images.arrowUp.path,
            title: LocaleKeys.sendWord.tr(),
          ),
      ],
    );
  }

  Widget _buttonItem({
    required String svg,
    required VoidCallback onPressed,
    required String title,
  }) {
    return Builder(
      builder: (context) {
        final colors = context.themeStyle.colors;

        return SeparatedColumn(
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonIconButton.svg(
              svg: svg,
              buttonType: EverButtonType.primary,
              onPressed: onPressed,
            ),
            Text(
              title,
              style: StyleRes.addBold.copyWith(color: colors.textPrimary),
            ),
          ],
        );
      },
    );
  }
}
