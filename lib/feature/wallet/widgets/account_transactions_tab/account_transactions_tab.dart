import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/account_transactions_tab_cubit.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/models/account_transaction_item.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/scroll_controller_preload_listener.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_expired_transaction_widget.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_multisig_expired_transaction_widget.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_multisig_ordinary_transaction_widget.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_multisig_pending_transaction_widget.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_ordinary_transaction_widget.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_pending_transaction_widget.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Tab from <WalletBottomPanel> that allows display list of transactions
/// related to TonWallet for [account].
///
/// !!! TokenWallet transactions should be displayed in a separate tab,
/// specified for asset.
class AccountTransactionsTab extends StatelessWidget {
  const AccountTransactionsTab({
    required this.account,
    required this.scrollController,
    super.key,
  });

  final ScrollController scrollController;
  final KeyAccount account;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return BlocProvider<AccountTransactionsTabCubit>(
      create: (_) => AccountTransactionsTabCubit(
        account: account,
        nekotonRepository: inject<NekotonRepository>(),
        walletStorage: inject<TonWalletStorageService>(),
        currenciesService: inject<CurrenciesService>(),
      ),
      child:
          BlocBuilder<AccountTransactionsTabCubit, AccountTransactionsTabState>(
        builder: (context, state) {
          final colors = context.themeStyle.colors;

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
            transactions: (transactions, isLoading, _, currency) {
              return ScrollControllerPreloadListener(
                preleloadAction: () => context
                    .read<AccountTransactionsTabCubit>()
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

                    final prev = index == 0 ? null : transactions[index - 1];
                    final trans = transactions[index];
                    final displayDate =
                        prev == null || !prev.date.isSameDay(trans.date);

                    return Container(
                      color: theme.colors.background1,
                      padding: const EdgeInsets.symmetric(
                        horizontal: DimensSize.d16,
                      ),
                      child: _transactionItem(
                        trans,
                        displayDate,
                        Fixed.parse(currency?.price ?? '0'),
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

  Widget _transactionItem(
    AccountTransactionItem<dynamic> trans,
    bool displayDate,
    Fixed price,
  ) {
    return switch (trans.type) {
      AccountTransactionType.ordinary => TonWalletOrdinaryTransactionWidget(
          transaction: trans.transaction as TonWalletOrdinaryTransaction,
          displayDate: displayDate,
          price: price,
        ),
      AccountTransactionType.pending => TonWalletPendingTransactionWidget(
          transaction: trans.transaction as TonWalletPendingTransaction,
          displayDate: displayDate,
        ),
      AccountTransactionType.expired => TonWalletExpiredTransactionWidget(
          transaction: trans.transaction as TonWalletExpiredTransaction,
          displayDate: displayDate,
        ),
      AccountTransactionType.multisigOrdinary =>
        TonWalletMultisigOrdinaryTransactionWidget(
          transaction:
              trans.transaction as TonWalletMultisigOrdinaryTransaction,
          displayDate: displayDate,
          price: price,
        ),
      AccountTransactionType.multisigPending =>
        TonWalletMultisigPendingTransactionWidget(
          transaction: trans.transaction as TonWalletMultisigPendingTransaction,
          displayDate: displayDate,
          price: price,
        ),
      AccountTransactionType.multisigExpired =>
        TonWalletMultisigExpiredTransactionWidget(
          transaction: trans.transaction as TonWalletMultisigExpiredTransaction,
          displayDate: displayDate,
          price: price,
        ),
    };
  }
}
