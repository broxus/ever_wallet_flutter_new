import 'package:app/feature/profile/manage_seeds_accounts/widgets/widgets.dart';
import 'package:app/feature/profile/seed_detail/seed_detail.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class SeedDetailView extends StatelessWidget {
  const SeedDetailView({
    required this.publicKey,
    super.key,
  });

  final String publicKey;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SeedDetailCubit, SeedDetailState>(
      listener: (context, state) {
        state.whenOrNull(empty: () => context.pop());
      },
      builder: (context, state) {
        return state.maybeWhen(
          data: _buildSeed,
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }

  Widget _buildSeed(
    Seed seed,
    bool isCurrentSeed,
    String? currentPublicKey,
  ) {
    return Builder(
      builder: (context) {
        final colors = context.themeStyle.colors;

        return ContainerColumn(
          separatorSize: DimensSize.d16,
          padding: const EdgeInsets.all(DimensSize.d16),
          children: [
            SeparatedColumn(
              separatorSize: DimensSize.d4,
              children: [
                if (isCurrentSeed)
                  Text(
                    LocaleKeys.currentSeed.tr(),
                    style: StyleRes.addRegular
                        .copyWith(color: colors.textSecondary),
                  ),
                Text(
                  seed.name,
                  style: StyleRes.h1.copyWith(color: colors.textPrimary),
                ),
              ],
            ),
            CommonCard(
              topSubtitleText: LocaleKeys.totalBalance.tr(),
              titleText: '0 USD',
              height: DimensSize.d76,
              width: double.infinity,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: ShapedContainerColumn(
                  margin: EdgeInsets.zero,
                  titleText: LocaleKeys.keysWord.tr(),
                  mainAxisSize: MainAxisSize.min,
                  children: seed.allKeys
                      .map((key) => _keyItem(key, seed, currentPublicKey))
                      .toList(),
                ),
              ),
            ),
            CommonButton(
              text: LocaleKeys.addKey.tr(),
              leading: CommonButtonIconWidget.svg(svg: Assets.images.plus.path),
              onPressed: () => showDeriveKeysSheetPassword(context, publicKey),
            ),
          ],
        );
      },
    );
  }

  Widget _keyItem(
    SeedKey key,
    Seed seed,
    String? currentPublicKey,
  ) {
    return Builder(
      builder: (context) {
        final colors = context.themeStyle.colors;

        return CommonListTile(
          padding: EdgeInsets.zero,
          leading: CommonBackgroundedIconWidget.svg(
            svg: Assets.images.key.path,
          ),
          titleText: key.name,
          trailing: SeparatedRow(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (currentPublicKey == key.publicKey)
                CommonIconWidget.svg(
                  svg: Assets.images.check.path,
                  color: colors.textPrimary,
                ),
              CommonIconButton.svg(
                color: colors.textSecondary,
                svg: Assets.images.settings.path,
                buttonType: EverButtonType.ghost,
                onPressed: () => seed.publicKey == key.publicKey
                    ? showSeedSettingsSheet(
                        context,
                        key.publicKey,
                      )
                    : showKeySettingsSheet(
                        context,
                        key.publicKey,
                      ),
                innerPadding: const EdgeInsets.all(DimensSize.d8),
              ),
            ],
          ),
          subtitleText: LocaleKeys.accountsWithData.plural(
            key.accountList.allAccounts.length,
            args: [
              '${key.accountList.allAccounts.length}',
              '0 USD',
            ],
          ),
        );
      },
    );
  }
}
