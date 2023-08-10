import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/account_transactions_tab_cubit.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/models/account_transaction_item.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/widgets.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:collection/collection.dart';
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
    super.key,
  });

  final KeyAccount account;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccountTransactionsTabCubit>(
      create: (_) => AccountTransactionsTabCubit(
        account: account,
        nekotonRepository: inject<NekotonRepository>(),
        walletStorage: inject<TonWalletStorageService>(),
      ),
      child:
          BlocBuilder<AccountTransactionsTabCubit, AccountTransactionsTabState>(
        builder: (context, state) {
          final colors = context.themeStyle.colors;

          return state.when(
            empty: () => Center(
              child: Text(
                LocaleKeys.historyIsEmpty.tr(),
                style: StyleRes.primaryBold.copyWith(
                  color: colors.textPrimary,
                ),
              ),
            ),
            loading: () => const SizedBox.shrink(),
            transactions: (transactions) {
              return SeparatedColumn(
                children: transactions.mapIndexed((index, e) {
                  final prev = index == 0 ? null : transactions[index - 1];
                  final displayDate =
                      prev == null || !prev.date.isSameDay(e.date);

                  return switch (e.type) {
                    AccountTransactionType.ordinary =>
                      TonWalletOrdinaryTransactionWidget(
                        transaction:
                            e.transaction as TonWalletOrdinaryTransaction,
                        displayDate: displayDate,
                      ),
                    AccountTransactionType.pending =>
                      TonWalletPendingTransactionWidget(
                        transaction:
                            e.transaction as TonWalletPendingTransaction,
                        displayDate: displayDate,
                      ),
                    AccountTransactionType.expired =>
                      TonWalletExpiredTransactionWidget(
                        transaction:
                            e.transaction as TonWalletExpiredTransaction,
                        displayDate: displayDate,
                      ),
                    AccountTransactionType.multisigOrdinary =>
                      TonWalletMultisigOrdinaryTransactionWidget(
                        transaction: e.transaction
                            as TonWalletMultisigOrdinaryTransaction,
                        displayDate: displayDate,
                      ),
                    AccountTransactionType.multisigPending =>
                      TonWalletMultisigPendingTransactionWidget(
                        transaction: e.transaction
                            as TonWalletMultisigPendingTransaction,
                        displayDate: displayDate,
                      ),
                    AccountTransactionType.multisigExpired =>
                      TonWalletMultisigExpiredTransactionWidget(
                        transaction: e.transaction
                            as TonWalletMultisigExpiredTransaction,
                        displayDate: displayDate,
                      ),
                  };
                }).toList(),
              );
            },
          );
        },
      ),
    );
  }
}
