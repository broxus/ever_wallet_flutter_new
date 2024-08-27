import 'package:app/feature/wallet/wallet.dart';
import 'package:app/feature/widgets/change_notifier_listener.dart';
import 'package:app/generated/assets.gen.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:render_metrics/render_metrics.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';
import 'package:ui_components_lib/v2/widgets/modals/primary_bottom_sheet.dart';

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
              const _BackUpBadge(),
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

class _BackUpBadge extends StatelessWidget {
  const _BackUpBadge();

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return GestureDetector(
      onTap: () {
        showPrimaryBottomSheet(
          context: context,
          title: 'Back up your '
              'wallet',
          subtitle: 'Don’t lose your wallet! Save an encrypted '
              'copy to iCloud or back it up manually.',
          assetsPath: Assets.images.seedPhraseIcon.path,
          firstButton: PrimaryButton(
            buttonShape: ButtonShape.pill,
            title: 'Back up manually',
            postfixIcon: LucideIcons.penLine,
            onPressed: (){},
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(left: DimensSizeV2.d16),
        decoration: BoxDecoration(
          color: theme.colors.background1,
          borderRadius: BorderRadius.circular(DimensRadiusV2.radius16),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: DimensSizeV2.d100),
              child: Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: DimensSizeV2.d12),
                    Text(
                      LocaleKeys.notBackedUpTitle.tr(),
                      style: theme.textStyles.headingXSmall,
                    ),
                    Text(
                      LocaleKeys.notBackedUpSubtitle.tr(),
                      style: theme.textStyles.paragraphXSmall,
                    ),
                    const SizedBox(height: DimensSizeV2.d16),
                  ],
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerRight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(DimensRadiusV2.radius16),
                  child: Image.asset(
                    Assets.images.lockBackup.path,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
