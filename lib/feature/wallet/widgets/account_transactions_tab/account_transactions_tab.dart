import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/account_transactions_tab_cubit.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/models/account_transaction_item.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/widgets.dart';
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
          return state.when(
            empty: () => const SizedBox.shrink(),
            loading: () => const SizedBox.shrink(),
            transactions: (transactions) {
              return SeparatedColumn(
                separator: const Padding(
                  padding: EdgeInsets.symmetric(vertical: DimensSize.d8),
                  child: CommonDivider(),
                ),
                children: transactions.map((e) {
                  return switch (e.type) {
                    AccountTransactionType.ordinary =>
                      TonWalletOrdinaryTransactionWidget(
                        transaction:
                            e.transaction as TonWalletOrdinaryTransaction,
                      ),
                    AccountTransactionType.pending =>
                      TonWalletPendingTransactionWidget(
                        transaction:
                            e.transaction as TonWalletPendingTransaction,
                      ),
                    AccountTransactionType.expired =>
                      TonWalletExpiredTransactionWidget(
                        transaction:
                            e.transaction as TonWalletExpiredTransaction,
                      ),
                    AccountTransactionType.multisigOrdinary =>
                      TonWalletMultisigOrdinaryTransactionWidget(
                        transaction: e.transaction
                            as TonWalletMultisigOrdinaryTransaction,
                      ),
                    AccountTransactionType.multisigPending =>
                      TonWalletMultisigPendingTransactionWidget(
                        transaction: e.transaction
                            as TonWalletMultisigPendingTransaction,
                      ),
                    AccountTransactionType.multisigExpired =>
                      TonWalletMultisigExpiredTransactionWidget(
                        transaction: e.transaction
                            as TonWalletMultisigExpiredTransaction,
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
