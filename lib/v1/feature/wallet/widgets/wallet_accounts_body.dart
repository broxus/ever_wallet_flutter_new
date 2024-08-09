import 'package:app/feature/widgets/change_notifier_listener.dart';
import 'package:app/v1/feature/wallet/wallet.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:render_metrics/render_metrics.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

const walletAccountCardHeight = DimensSize.d220;
const walletAccountsPageIndicatorHeight = DimensSize.d8;
const walletAccountIndicatorSpace = DimensSize.d16;

/// Body of wallet, that displays information about accounts and allows
/// scroll between them.
class WalletAccountsBody extends StatefulWidget {
  const WalletAccountsBody({
    required this.accounts,
    required this.currentAccount,
    required this.controller,
    required this.publicKey,
    required this.onMount,
    super.key,
  });

  final List<KeyAccount> accounts;
  final PublicKey publicKey;
  final KeyAccount? currentAccount;
  final PageController controller;
  final ValueChanged<double> onMount;

  @override
  State<WalletAccountsBody> createState() => _WalletAccountsBodyState();
}

class _WalletAccountsBodyState extends State<WalletAccountsBody> {
  final _renderId = 0;

  @override
  Widget build(BuildContext context) {
    final list = widget.accounts;

    return SeparatedColumn(
      mainAxisSize: MainAxisSize.min,
      separatorSize: walletAccountIndicatorSpace,
      children: [
        Container(
          margin: const EdgeInsets.only(top: DimensSize.d12),
          height: walletAccountCardHeight,
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
                    height: walletAccountCardHeight,
                    publicKey: widget.publicKey,
                  );
                } else {
                  final item = list[index];
                  child = AccountCard(
                    account: item,
                    key: ValueKey(item.hashCode),
                    height: walletAccountCardHeight,
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
          child: SeparatedColumn(
            mainAxisSize: MainAxisSize.min,
            children: [
              _pageIndicators(list.length + 1),
              RenderMetricsObject(
                id: _renderId,
                onMount: _onUpdate,
                onUpdate: _onUpdate,
                child: WalletAccountActions(
                  currentAccount: widget.currentAccount,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _onUpdate(_, RenderMetricsBox rb) {
    Future.delayed(const Duration(milliseconds: 100), () {
      try {
        widget.onMount(rb.data.bottomCenter.y);
      } on Object catch (e) {
        debugPrint(e.toString());
      }
    });
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
          height: walletAccountsPageIndicatorHeight,
          decoration: BoxDecoration(
            color: selected ? colors.textPrimary : colors.textSecondary,
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }
}
