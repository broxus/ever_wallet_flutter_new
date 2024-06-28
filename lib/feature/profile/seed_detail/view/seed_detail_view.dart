import 'package:app/app/router/router.dart';
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
            Expanded(
              child: SingleChildScrollView(
                child: ShapedContainerColumn(
                  margin: EdgeInsets.zero,
                  titleText: LocaleKeys.keysWord.tr(),
                  mainAxisSize: MainAxisSize.min,
                  children: seed.allKeys
                      .map(
                        (key) => _keyItem(
                          key,
                          currentPublicKey,
                          key != seed.allKeys.last,
                        ),
                      )
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
    PublicKey? currentPublicKey,
    bool isLastItem,
  ) {
    return Builder(
      builder: (context) {
        final colors = context.themeStyle.colors;

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
                    svg: Assets.images.settings.path,
                    color: colors.textSecondary,
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
            if (isLastItem) const CommonDivider(),
          ],
        );
      },
    );
  }
}
