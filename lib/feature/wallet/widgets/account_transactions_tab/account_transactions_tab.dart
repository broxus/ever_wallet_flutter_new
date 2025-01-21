import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/account_transactions_tab_cubit.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/models/account_transaction_item.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/scroll_controller_preload_listener.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_expired_transaction_widget.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_multisig_expired_transaction/ton_wallet_multisig_expired_transaction_widget.dart';
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
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

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
        builder: (context, state) => state.when(
          empty: () => SliverToBoxAdapter(
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
          loading: () => SliverToBoxAdapter(
            child: ProgressIndicatorWidget(
              size: DimensSizeV2.d32,
              color: theme.colors.content0,
            ),
          ),
          transactions: (transactions, isLoading, _, price) {
            return ScrollControllerPreloadListener(
              preloadAction: () => context
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
                  final next = index == transactions.length - 1
                      ? null
                      : transactions[index + 1];
                  final isFirst =
                      prev == null || !prev.date.isSameDay(trans.date);
                  final isLast =
                      next == null || !next.date.isSameDay(trans.date);

                  return _transactionItem(
                    trans,
                    isFirst,
                    isLast,
                    price,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _transactionItem(
    AccountTransactionItem<dynamic> trans,
    bool isFirst,
    bool isLast,
    Fixed price,
  ) {
    return switch (trans.type) {
      AccountTransactionType.ordinary => TonWalletOrdinaryTransactionWidget(
          transaction: trans.transaction as TonWalletOrdinaryTransaction,
          isFirst: isFirst,
          isLast: isLast,
          price: price,
        ),
      AccountTransactionType.pending => TonWalletPendingTransactionWidget(
          transaction: trans.transaction as TonWalletPendingTransaction,
          isFirst: isFirst,
          isLast: isLast,
        ),
      AccountTransactionType.expired => TonWalletExpiredTransactionWidget(
          transaction: trans.transaction as TonWalletExpiredTransaction,
          isFirst: isFirst,
          isLast: isLast,
        ),
      AccountTransactionType.multisigOrdinary =>
        TonWalletMultisigOrdinaryTransactionWidget(
          transaction:
              trans.transaction as TonWalletMultisigOrdinaryTransaction,
          isFirst: isFirst,
          isLast: isLast,
          price: price,
          account: account,
        ),
      AccountTransactionType.multisigPending =>
        TonWalletMultisigPendingTransactionWidget(
          transaction: trans.transaction as TonWalletMultisigPendingTransaction,
          isFirst: isFirst,
          isLast: isLast,
          price: price,
          account: account,
        ),
      AccountTransactionType.multisigExpired =>
        TonWalletMultisigExpiredTransactionWidget(
          transaction: trans.transaction as TonWalletMultisigExpiredTransaction,
          isFirst: isFirst,
          isLast: isLast,
          price: price,
          account: account,
        ),
    };
  }
}
