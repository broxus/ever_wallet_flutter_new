import 'package:app/di/di.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Details page of the [TonWallet], that is used to look though transactions
/// history and to send tokens.
class TonWalletDetailsPage extends StatelessWidget {
  const TonWalletDetailsPage({
    required this.address,
    super.key,
  });

  final Address address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(),
      body: BlocProvider<TonWalletDetailsCubit>(
        create: (_) => TonWalletDetailsCubit(
          address: address,
          nekotonRepository: inject(),
          currencyConvertService: inject(),
          balanceService: inject(),
        ),
        child: BlocBuilder<TonWalletDetailsCubit, TonWalletDetailsState>(
          builder: (context, state) {
            final colors = context.themeStyle.colors;

            return state.when(
              initial: () => const SizedBox.shrink(),
              empty: () => const SizedBox.shrink(),
              data: (walletName, account, tokenBalance, fiatBalance) {
                return CommonSlidingPanel(
                  // ignore: no-magic-number
                  minHeightSizePercent: 0.65,
                  maxHeightSizePercent: 1,
                  body: SeparatedColumn(
                    mainAxisSize: MainAxisSize.min,
                    separatorSize: DimensSize.d24,
                    children: [
                      _header(walletName, tokenBalance, fiatBalance),
                      WalletAccountActions(
                        currentAccount: account,
                        allowStake: false,
                        sendSpecified: true,
                      ),
                    ],
                  ),
                  panelBuilder: (context, controller) => CustomScrollView(
                    controller: controller,
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: DimensSize.d16,
                          ),
                          child: Text(
                            LocaleKeys.transactionsHistory.tr(),
                            style: StyleRes.h2.copyWith(
                              color: colors.textPrimary,
                            ),
                          ),
                        ),
                      ),
                      AccountTransactionsTab(
                        account: account,
                        scrollController: controller,
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(height: DimensSize.d8),
                      ),
                    ],
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
    String walletName,
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
              walletName,
              style: StyleRes.addRegular.copyWith(color: colors.textSecondary),
            ),
            MoneyWidget(money: tokenBalance, style: MoneyWidgetStyle.primary),
            MoneyWidget(money: fiatBalance, style: MoneyWidgetStyle.secondary),
          ],
        );
      },
    );
  }
}
