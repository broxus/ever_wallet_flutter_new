import 'package:app/di/di.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/account_transactions_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Details page of the [TonWallet], that is used to look though transactions
/// history and to send tokens.
class TonWalletDetailsPage extends StatefulWidget {
  const TonWalletDetailsPage({
    required this.address,
    super.key,
  });

  final Address address;

  @override
  State<TonWalletDetailsPage> createState() => _TonWalletDetailsPageState();
}

class _TonWalletDetailsPageState extends State<TonWalletDetailsPage> {
  final controller = ScrollController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(),
      body: BlocProvider<TonWalletDetailsCubit>(
        create: (_) => TonWalletDetailsCubit(
          address: widget.address,
          nekotonRepository: inject(),
          currencyConvertService: inject(),
          balanceService: inject(),
        ),
        child: BlocBuilder<TonWalletDetailsCubit, TonWalletDetailsState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox.shrink(),
              empty: () => const SizedBox.shrink(),
              subscribeError: (walletName, account, error, isLoading) => _Body(
                walletName: walletName,
                account: account,
                error: error,
                isLoadingError: isLoading,
                controller: controller,
              ),
              data: (walletName, account, tokenBalance, fiatBalance) => _Body(
                walletName: walletName,
                account: account,
                tokenBalance: tokenBalance,
                fiatBalance: fiatBalance,
                controller: controller,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.account,
    required this.walletName,
    required this.controller,
    this.tokenBalance,
    this.fiatBalance,
    this.error,
    this.isLoadingError = false,
  });

  final KeyAccount account;
  final String walletName;
  final Money? tokenBalance;
  final Money? fiatBalance;
  final Object? error;
  final bool isLoadingError;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                walletName,
                style: theme.textStyles.labelSmall.copyWith(
                  color: theme.colors.content3,
                ),
              ),
              const SizedBox(height: DimensSizeV2.d12),
              if (tokenBalance != null)
                AmountWidget.fromMoney(
                  amount: tokenBalance!,
                  style: theme.textStyles.headingXLarge,
                  useDefaultFormat: true,
                ),
              const SizedBox(height: DimensSizeV2.d4),
              if (fiatBalance != null)
                AmountWidget.fromMoney(
                  amount: fiatBalance!,
                  style: theme.textStyles.labelXSmall,
                  useDefaultFormat: true,
                ),
              const SizedBox(height: DimensSizeV2.d16),
              if (error == null)
                WalletAccountActions(
                  currentAccount: account,
                  allowStake: false,
                  sendSpecified: true,
                ),
              const SizedBox(height: DimensSizeV2.d48),
            ],
          ),
        ),
        DecoratedSliver(
          decoration: BoxDecoration(
            color: theme.colors.background1,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(DimensRadiusV2.radius24),
            ),
          ),
          sliver: SliverPadding(
            padding: const EdgeInsets.all(DimensSizeV2.d16),
            sliver: error == null
                ? AccountTransactionsTab(
                    account: account,
                    scrollController: controller,
                  )
                : null,
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Container(
            color: theme.colors.background1,
            padding: const EdgeInsets.symmetric(
              horizontal: DimensSizeV2.d16,
            ),
            child: error != null
                ? Center(
                    child: WalletSubscribeErrorWidget(
                      error: error!,
                      isLoadingError: isLoadingError,
                      onRetryPressed: (context) =>
                          context.read<TonWalletDetailsCubit>().retry(),
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
