import 'package:app/di/di.dart';
import 'package:app/feature/wallet/token_wallet_details/widgets/token_wallet_transactions/token_wallet_transactions_cubit.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/scroll_controller_preload_listener.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
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
    final theme = context.themeStyleV2;

    return BlocProvider<TokenWalletTransactionsCubit>(
      create: (_) => TokenWalletTransactionsCubit(
        owner: owner,
        rootTokenContract: rootTokenContract,
        nekotonRepository: inject(),
        walletStorage: inject(),
        currenciesService: inject(),
      ),
      child: BlocBuilder<TokenWalletTransactionsCubit,
          TokenWalletTransactionsState>(
        builder: (context, state) {
          return state.when(
            empty: () => SliverFillRemaining(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: DimensSizeV2.d24),
                child: SeparatedColumn(
                  separatorSize: DimensSizeV2.d12,
                  children: [
                    SvgPicture.asset(
                      Assets.images.lightning.path,
                      colorFilter: theme.colors.content3.colorFilter,
                      width: DimensSizeV2.d56,
                      height: DimensSizeV2.d56,
                    ),
                    Text(
                      LocaleKeys.emptyHistoryTitle.tr(),
                      style: theme.textStyles.paragraphSmall.copyWith(
                        color: theme.colors.content1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            loading: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
            transactions: (
              transactions,
              currency,
              isLoading,
              _,
              customCurrency,
            ) {
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
                        padding: EdgeInsets.symmetric(
                          vertical: DimensSizeV2.d16,
                        ),
                        child: Center(child: CommonCircularProgressIndicator()),
                      );
                    }

                    final prev = index == 0 ? null : transactions[index - 1];
                    final trans = transactions[index];
                    final next = index == transactions.length - 1
                        ? null
                        : transactions[index + 1];
                    final isFirst =
                        prev == null || !prev.date.isSameDay(trans.date);
                    final isLast =
                        next == null || !next.date.isSameDay(trans.date);

                    final ticker = inject<NekotonRepository>()
                        .currentTransport
                        .nativeTokenTicker;

                    return TokenWalletTransactionWidget(
                      transaction: trans,
                      isFirst: isFirst,
                      isLast: isLast,
                      transactionFee: Money.fromBigIntWithCurrency(
                        trans.fees,
                        Currencies()[ticker]!,
                      ),
                      transactionValue: Money.fromBigIntWithCurrency(
                        trans.value,
                        currency,
                      ),
                      price: Fixed.parse(customCurrency?.price ?? '0'),
                      rootTokenContract: rootTokenContract,
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
