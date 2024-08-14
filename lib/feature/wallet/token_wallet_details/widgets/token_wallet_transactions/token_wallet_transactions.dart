import 'package:app/di/di.dart';
import 'package:app/feature/wallet/token_wallet_details/widgets/token_wallet_transactions/token_wallet_transactions_cubit.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:app/v1/feature/wallet/widgets/account_transactions_tab/widgets/scroll_controller_preload_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Widget that allows load transaction for [TokenWallet] and map them into
/// pretty ui.
class TokenWalletTransactionsWidget extends StatelessWidget {
  const TokenWalletTransactionsWidget({
    required this.owner,
    required this.rootTokenContract,
    required this.scrollController,
    super.key,
  });

  final Address owner;
  final Address rootTokenContract;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    return BlocProvider<TokenWalletTransactionsCubit>(
      create: (_) => TokenWalletTransactionsCubit(
        owner: owner,
        rootTokenContract: rootTokenContract,
        nekotonRepository: inject(),
        walletStorage: inject(),
      ),
      child: BlocBuilder<TokenWalletTransactionsCubit,
          TokenWalletTransactionsState>(
        builder: (context, state) {
          return state.when(
            empty: () => SliverFillRemaining(
              child: Center(
                child: Text(
                  LocaleKeys.historyIsEmpty.tr(),
                  style: StyleRes.primaryBold.copyWith(
                    color: colors.textPrimary,
                  ),
                ),
              ),
            ),
            loading: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
            transactions: (transactions, currency, isLoading, _) {
              return ScrollControllerPreloadListener(
                preleloadAction: () => context
                    .read<TokenWalletTransactionsCubit>()
                    .tryPreloadTransactions(),
                scrollController: scrollController,
                child: SliverList.builder(
                  itemCount: transactions.length + (isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == transactions.length) {
                      return const Padding(
                        padding: EdgeInsets.all(DimensSize.d16),
                        child: Center(child: CommonCircularProgressIndicator()),
                      );
                    }

                    final trans = transactions[index];

                    final prev = index == 0 ? null : transactions[index - 1];
                    final displayDate =
                        prev == null || !prev.date.isSameDay(trans.date);

                    final ticker = inject<NekotonRepository>()
                        .currentTransport
                        .nativeTokenTicker;

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: DimensSize.d16,
                      ),
                      child: TokenWalletTransactionWidget(
                        transaction: trans,
                        displayDate: displayDate,
                        transactionFee: Money.fromBigIntWithCurrency(
                          trans.fees,
                          Currencies()[ticker]!,
                        ),
                        transactionValue: Money.fromBigIntWithCurrency(
                          trans.value,
                          currency,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
