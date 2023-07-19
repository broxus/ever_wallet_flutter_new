import 'package:app/feature/profile/profile.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Widget of card that allows to add new account from wallet screen.
class AddNewAccountCard extends StatelessWidget {
  const AddNewAccountCard({
    required this.height,
    required this.publicKey,
    super.key,
  });

  /// Height of card, just to sync with 'AccountCard'
  final double height;

  /// Key for which account will be added
  final PublicKey publicKey;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    return Material(
      color: colors.backgroundSecondary,
      shape: const SquircleShapeBorder(cornerRadius: DimensRadius.large),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(DimensSize.d12),
              child: CommonIconButton(
                onPressed: () => showAddNewLocalAccountSheet(
                  context: context,
                  publicKey: publicKey,
                ),
                svg: Assets.images.plus.path,
                buttonType: EverButtonType.primary,
                backgroundColor: colors.blue,
                color: colors.backgroundSecondary,
              ),
            ),
            Text(
              LocaleKeys.addAccount.tr(),
              style: StyleRes.primaryBold.copyWith(color: colors.textPrimary),
            ),
            const SizedBox(height: DimensSize.d4),
            Text(
              LocaleKeys.createAccountOrAddExisted.tr(),
              style: StyleRes.addRegular.copyWith(color: colors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
