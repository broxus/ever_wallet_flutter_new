import 'package:app/app/router/router.dart';
import 'package:app/feature/profile/seed_detail/seed_detail.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class SeedDetailView extends StatelessWidget {
  const SeedDetailView({
    required this.publicKey,
    super.key,
  });

  final PublicKey publicKey;

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
    PublicKey? currentPublicKey,
  ) {
    return Builder(
      builder: (context) {
        final theme = context.themeStyleV2;

        return ContainerColumn(
          separatorSize: DimensSizeV2.d16,
          padding: const EdgeInsets.all(DimensSizeV2.d16),
          children: [
            SeparatedColumn(
              separatorSize: DimensSizeV2.d4,
              children: [
                if (isCurrentSeed)
                  Text(
                    LocaleKeys.currentSeed.tr(),
                    style: theme.textStyles.labelXSmall
                        .copyWith(color: theme.colors.content3),
                  ),
                Text(
                  seed.name,
                  style: theme.textStyles.headingLarge,
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: ShapedContainerColumn(
                  color: theme.colors.background1,
                  margin: EdgeInsets.zero,
                  titleText: LocaleKeys.keysWord.tr(),
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (var i = 0; i < seed.allKeys.length; i++)
                      _keyItem(
                        seed.allKeys[i],
                        currentPublicKey,
                        i != seed.allKeys.length - 1,
                      ),
                  ],
                ),
              ),
            ),
            if (!seed.masterKey.isLegacy)
              PrimaryButton(
              buttonShape: ButtonShape.pill,
              title: LocaleKeys.addKey.tr(),
              postfixIcon: LucideIcons.plus,
              onPressed: () => showDeriveKeysSheetPassword(context, publicKey),
            ),
          ],
        );
      },
    );
  }

  Widget _keyItem(
    SeedKey key,
    PublicKey? currentPublicKey,
    bool isShowingDivider,
  ) {
    return Builder(
      builder: (context) {
        final colors = context.themeStyleV2.colors;

        return Column(
          children: [
            CommonListTile(
              onPressed: () => context.goFurther(
                AppRoute.keyDetail.pathWithData(
                  pathParameters: {
                    keyDetailPublicKeyPathParam: key.publicKey.publicKey,
                  },
                ),
              ),
              padding: EdgeInsets.zero,
              leading: CommonBackgroundedIconWidget.svg(
                svg: Assets.images.key.path,
                backgroundColor: colors.backgroundAlpha,
              ),
              titleText: key.name,
              trailing: SeparatedRow(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (currentPublicKey == key.publicKey)
                    CommonIconWidget.svg(
                      svg: Assets.images.check.path,
                      color: colors.content0,
                    ),
                  CommonIconButton.svg(
                    svg: Assets.images.settings.path,
                    color: colors.content0,
                    buttonType: EverButtonType.ghost,
                    size: CommonIconButtonSize.xsmall,
                    onPressed: () => showKeySettingsSheet(
                      context: context,
                      publicKey: key.publicKey,
                      isMaster: key.isMaster,
                    ),
                  ),
                ],
              ),
              subtitleText: LocaleKeys.accountsWithData.plural(
                key.accountList.allAccounts.length,
                args: ['${key.accountList.allAccounts.length}'],
              ),
            ),
            if (isShowingDivider) const CommonDivider(),
          ],
        );
      },
    );
  }
}
