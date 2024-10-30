import 'package:app/feature/wallet/wallet.dart';
import 'package:app/feature/wallet/wallet_backup/back_up_badge.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Body of wallet, that displays information about accounts and allows
/// scroll between them.
class WalletAccountsBody extends StatelessWidget {
  const WalletAccountsBody({
    required this.account,
    required this.isShowingBadge,
    required this.finishedBackupCallback,
    super.key,
  });

  final KeyAccount? account;
  final bool isShowingBadge;
  final VoidCallback finishedBackupCallback;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d16),
        child: Column(
          children: [
            const SizedBox(height: DimensSizeV2.d24),
            if (account != null)
              AccountCard(account: account!)
            else
              const ProgressIndicatorWidget(size: DimensSizeV2.d80),
            const SizedBox(height: DimensSizeV2.d16),
            WalletAccountActions(
              currentAccount: account,
            ),
            const SizedBox(height: DimensSizeV2.d16),
            if (isShowingBadge) BackUpBadge(account, finishedBackupCallback),
            const SizedBox(height: DimensSizeV2.d16),
          ],
        ),
      ),
    );
  }
}
