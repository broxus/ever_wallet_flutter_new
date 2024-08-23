// ignore_for_file: deprecated_member_use_from_same_package

import 'package:app/app/router/router.dart';
import 'package:app/feature/profile/manage_seeds_accounts/manage_seeds_accounts.dart';
import 'package:app/generated/generated.dart';
import 'package:app/v1/feature/add_seed/enter_seed_name/enter_seed_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Main widget that displays content of manage seeds and accounts feature
class ManageSeedsAccountsView extends StatelessWidget {
  const ManageSeedsAccountsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageSeedsAccountsCubit, ManageSeedsAccountsState>(
      builder: (context, state) {
        final theme = context.themeStyleV2;

        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: DimensSize.d12,
            horizontal: DimensSize.d16,
          ),
          child: SeparatedColumn(
            separatorSize: DimensSize.d16,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: DimensSizeV2.d40,
                ),
                child: Text(
                  LocaleKeys.manageSeedsAndAccounts.tr(),
                  style: theme.textStyles.headingLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: ShapedContainerColumn(
                    color: theme.colors.background1,
                    margin: EdgeInsets.zero,
                    separator: const Padding(
                      padding: EdgeInsets.symmetric(vertical: DimensSize.d4),
                      child: CommonDivider(),
                    ),
                    titleText: LocaleKeys.seedPhrases.tr(),
                    children: state.seeds
                        .map(
                          (seed) => _mapSeedTile(
                            seed: seed,
                            currentSeed: state.currentSeed,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
              const SizedBox(height: DimensSize.d8),
              PrimaryButton(
                buttonShape: ButtonShape.pill,
                postfixIcon: LucideIcons.plus,
                title: LocaleKeys.addSeedPhrase.tr(),
                onPressed: () => _showAddSeedSheet(context),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showAddSeedSheet(BuildContext context) async {
    final selected = await showSelectAddSeedTypeSheet(context);

    if (context.mounted && selected != null) {
      switch (selected) {
        case SelectAddSeedType.create:
          context.goFurther(
            AppRoute.enterSeedName.pathWithData(
              pathParameters: {
                enterSeedNameCommandPathParam: EnterSeedNameCommand.create.name,
              },
            ),
          );
        case SelectAddSeedType.import:
          context.goFurther(
            AppRoute.enterSeedName.pathWithData(
              pathParameters: {
                enterSeedNameCommandPathParam: EnterSeedNameCommand.import.name,
              },
            ),
          );
      }
    }
  }

  Widget _mapSeedTile({
    required Seed seed,
    required Seed? currentSeed,
  }) {
    return Builder(
      builder: (context) {
        final theme = context.themeStyleV2;

        return CommonListTile(
          padding: EdgeInsets.zero,
          onPressed: () => context.goFurther(
            AppRoute.seedDetail.pathWithData(
              pathParameters: {
                seedDetailPublicKeyPathParam: seed.publicKey.publicKey,
              },
            ),
          ),
          leading: CommonBackgroundedIconWidget.svg(
            svg: Assets.images.sparxLogoSmall.path,
            backgroundColor: theme.colors.backgroundAlpha,
            useDefaultColor: false,
          ),
          titleText: seed.name,
          subtitleText: LocaleKeys.publicKeysWithData.plural(
            seed.allKeys.length,
            args: ['${seed.allKeys.length}'],
          ),
          trailing: SeparatedRow(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (currentSeed?.publicKey == seed.publicKey)
                CommonIconWidget.svg(
                  svg: Assets.images.check.path,
                  color: theme.colors.content0,
                ),
              CommonIconButton.svg(
                color: theme.colors.content0,
                svg: Assets.images.settings.path,
                buttonType: EverButtonType.ghost,
                size: CommonIconButtonSize.xsmall,
                onPressed: () => showSeedSettingsSheet(context, seed.publicKey),
              ),
            ],
          ),
        );
      },
    );
  }
}
