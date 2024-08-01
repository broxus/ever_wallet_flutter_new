import 'package:app/di/di.dart';
import 'package:app/v2/feature/wallet/wallet.dart';
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
            return state.when(
              initial: () => const SizedBox.shrink(),
              empty: () => const SizedBox.shrink(),
              subscribeError: (walletName, account, error, isLoading) => _body(
                walletName: walletName,
                account: account,
                error: error,
                isLoadingError: isLoading,
              ),
              data: (walletName, account, tokenBalance, fiatBalance) => _body(
                walletName: walletName,
                account: account,
                tokenBalance: tokenBalance,
                fiatBalance: fiatBalance,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _header(
    String walletName,
    Money? tokenBalance,
    Money? fiatBalance,
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
            if (tokenBalance != null)
              MoneyWidget(money: tokenBalance, style: MoneyWidgetStyle.primary),
            if (fiatBalance != null)
              MoneyWidget(
                money: fiatBalance,
                style: MoneyWidgetStyle.secondary,
              ),
          ],
        );
      },
    );
  }

  // ignore: long-method
  Widget _body({
    required String walletName,
    required KeyAccount account,
    Money? tokenBalance,
    Money? fiatBalance,
    Object? error,
    bool isLoadingError = false,
  }) {
    return CommonSlidingPanel(
      // ignore: no-magic-number
      minHeightSizePercent: 0.65,
      maxHeightSizePercent: 1,
      body: SeparatedColumn(
        mainAxisSize: MainAxisSize.min,
        separatorSize: DimensSize.d24,
        children: [
          _header(walletName, tokenBalance, fiatBalance),
          if (error == null)
            WalletAccountActions(
              currentAccount: account,
              allowStake: false,
              sendSpecified: true,
            ),
        ],
      ),
      panelBuilder: (context, controller) => Builder(
        builder: (context) {
          final colors = context.themeStyle.colors;

          return CustomScrollView(
            controller: controller,
            slivers: error != null
                ? <Widget>[
                    SliverFillRemaining(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: DimensSize.d16,
                        ),
                        child: Center(
                          child: WalletSubscribeErrorWidget(
                            error: error,
                            isLoadingError: isLoadingError,
                            onRetryPressed: (context) =>
                                context.read<TonWalletDetailsCubit>().retry(),
                          ),
                        ),
                      ),
                    ),
                  ]
                : <Widget>[
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
          );
        },
      ),
    );
  }
}
