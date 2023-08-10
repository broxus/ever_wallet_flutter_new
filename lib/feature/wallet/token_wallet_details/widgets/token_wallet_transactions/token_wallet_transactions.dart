import 'package:app/di/di.dart';
import 'package:app/feature/wallet/token_wallet_details/widgets/token_wallet_transactions/token_wallet_transactions_cubit.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:collection/collection.dart';
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
    super.key,
  });

  final Address owner;
  final Address rootTokenContract;

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
            empty: () => Center(
              child: Text(
                LocaleKeys.historyIsEmpty.tr(),
                style: StyleRes.primaryBold.copyWith(
                  color: colors.textPrimary,
                ),
              ),
            ),
            loading: () => const SizedBox.shrink(),
            transactions: (transactions, currency) {
              return SeparatedColumn(
                children: transactions.mapIndexed(
                  (index, e) {
                    final prev = index == 0 ? null : transactions[index - 1];
                    final displayDate =
                        prev == null || !prev.date.isSameDay(e.date);

                    final ticker = inject<NekotonRepository>()
                        .currentTransport
                        .nativeTokenTicker;

                    return TokenWalletTransactionWidget(
                      transaction: e,
                      displayDate: displayDate,
                      transactionFee: Money.fromBigIntWithCurrency(
                        e.fees,
                        Currencies()[ticker]!,
                      ),
                      transactionValue: Money.fromBigIntWithCurrency(
                        e.value,
                        currency,
                      ),
                    );
                  },
                ).toList(),
              );
            },
          );
        },
      ),
    );
  }
}
