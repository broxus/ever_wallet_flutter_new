import 'package:app/feature/wallet/wallet.dart';
import 'package:app/feature/widgets/change_notifier_listener.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Body of wallet, that displays information about accounts and allows
/// scroll between them.
class WalletAccountsBody extends StatefulWidget {
  const WalletAccountsBody({
    required this.accounts,
    required this.currentAccount,
    required this.controller,
    required this.publicKey,
    super.key,
  });

  final List<KeyAccount> accounts;
  final PublicKey publicKey;
  final KeyAccount? currentAccount;
  final PageController controller;

  @override
  State<WalletAccountsBody> createState() => _WalletAccountsBodyState();
}

class _WalletAccountsBodyState extends State<WalletAccountsBody> {
  @override
  Widget build(BuildContext context) {
    final list = widget.accounts;

    return SeparatedColumn(
      mainAxisSize: MainAxisSize.min,
      separatorSize: DimensSize.d16,
      children: [
        Container(
          margin: const EdgeInsets.only(top: DimensSize.d12),
          height: DimensSize.d220,
          width: double.infinity,
          child: Center(
            child: PageView.builder(
              controller: widget.controller,
              itemCount: list.length + 1,
              // we do not need this callback, we have listener in cubit
              // ignore: no-empty-block
              onPageChanged: (_) {},
              itemBuilder: (_, index) {
                Widget child;
                if (index == list.length) {
                  child = AddNewAccountCard(
                    height: DimensSize.d220,
                    publicKey: widget.publicKey,
                  );
                } else {
                  final item = list[index];
                  child = AccountCard(
                    account: item,
                    key: ValueKey(item.hashCode),
                    height: DimensSize.d220,
                  );
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DimensSize.d16,
                  ),
                  child: child,
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _pageIndicators(list.length + 1),
              Padding(
                padding: const EdgeInsets.only(top: DimensSize.d8),
                child:
                    WalletAccountActions(currentAccount: widget.currentAccount),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _pageIndicators(int count) {
    return SeparatedRow(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, _indicator),
    );
  }

  Widget _indicator(int index) {
    return ChangeNotifierListener(
      changeNotifier: widget.controller,
      builder: (context) {
        final selected = widget.controller.page?.round() == index;
        final colors = context.themeStyle.colors;

        return AnimatedContainer(
          duration: kThemeAnimationDuration,
          width: DimensSize.d8,
          height: DimensSize.d8,
          decoration: BoxDecoration(
            color: selected ? colors.textPrimary : colors.textSecondary,
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }
}
