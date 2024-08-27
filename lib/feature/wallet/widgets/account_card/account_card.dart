import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/feature/wallet/widgets/account_card/account_card_cubit.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Card widget that displays information about account.
class AccountCard extends StatelessWidget {
  const AccountCard({
    required this.account,
    super.key,
  });

  final KeyAccount account;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AccountCardCubit(
        nekotonRepository: inject<NekotonRepository>(),
        account: account,
        balanceService: inject<BalanceService>(),
        currencyConvertService: inject<CurrencyConvertService>(),
        balanceStorage: inject(),
      ),
      child: BlocBuilder<AccountCardCubit, AccountCardState>(
        builder: (context, state) {
          return state.when<Widget>(
            subscribeError: (account, walletName, error, isLoading) =>
                WalletSubscribeErrorWidget(
                  error: error,
                  isLoadingError: isLoading,
                  onRetryPressed: _onRetry,
                ),
            data: (account, walletName, balance, custodians) => _AccountCard(
              account: account,
              balance: balance,
              onCopy: () => _onCopy(context),
            ),
          );
        },
      ),
    );
  }

  void _onRetry(BuildContext context) =>
      context.read<AccountCardCubit>().retry();

  void _onCopy(BuildContext context) {
    Clipboard.setData(
      ClipboardData(text: account.address.address),
    );
    inject<MessengerService>().show(
      Message.successful(
        message: LocaleKeys.valueCopiedExclamation.tr(
          args: [account.address.toEllipseString()],
        ),
      ),
    );
  }
}

class _AccountCard extends StatelessWidget {
  const _AccountCard({
    required this.account,
    required this.onCopy,
    required this.balance,
  });

  final KeyAccount account;
  final Money? balance;
  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: onCopy,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: DimensSizeV2.d12,
              horizontal: DimensSizeV2.d24,
            ),
            child: SeparatedRow(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  account.address.toEllipseString(),
                  style: theme.textStyles.labelSmall,
                ),
                const Icon(LucideIcons.copy, size: DimensSizeV2.d16),
              ],
            ),
          ),
        ),
        balance?.let(
          (balance) => AmountWidget(
            amount: balance.formatImproved(),
            style: theme.textStyles.displayMedium,
            sign: r'$',
          ),
        ) ?? const ProgressIndicatorWidget(size: DimensSizeV2.d52),
      ],
    );
  }
}

