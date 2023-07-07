import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Row with actions for current account.
/// If account is null, then no actions available.
class WalletAccountActions extends StatelessWidget {
  const WalletAccountActions({
    required this.currentAccount,
    super.key,
  });

  final KeyAccount? currentAccount;

  @override
  Widget build(BuildContext context) {
    if (currentAccount == null) return const SizedBox.shrink();

    return SeparatedRow(
      separatorSize: DimensSize.d32,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buttonItem(
          svg: Assets.images.arrowDown.path,
          // ignore: no-empty-block
          onPressed: () {},
          title: LocaleKeys.receiveWord.tr(),
        ),
        _buttonItem(
          svg: Assets.images.arrowUp.path,
          // ignore: no-empty-block
          onPressed: () {},
          title: LocaleKeys.sendWord.tr(),
        ),
        _buttonItem(
          svg: Assets.images.stake.path,
          // ignore: no-empty-block
          onPressed: () {},
          title: LocaleKeys.stakeWord.tr(),
        ),
      ],
    );
  }

  Widget _buttonItem({
    required String svg,
    required VoidCallback onPressed,
    required String title,
  }) {
    return Builder(
      builder: (context) {
        final colors = context.themeStyle.colors;

        return SeparatedColumn(
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonIconButton.svg(
              svg: svg,
              buttonType: EverButtonType.primary,
              onPressed: onPressed,
            ),
            Text(
              title,
              style: StyleRes.addBold.copyWith(color: colors.textPrimary),
            ),
          ],
        );
      },
    );
  }
}
