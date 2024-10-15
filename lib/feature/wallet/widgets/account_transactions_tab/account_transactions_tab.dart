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

                  return _transactionItem(
                    trans,
                    displayDate,
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
