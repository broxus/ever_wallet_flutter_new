import 'package:app/app/router/app_route.dart';
import 'package:app/feature/add_seed/enter_seed_name/enter_seed_name.dart';
import 'package:app/feature/profile/manage_seeds_accounts/manage_seeds_accounts.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Main widget that displays content of manage seeds and accounts feature
class ManageSeedsAccountsView extends StatelessWidget {
  const ManageSeedsAccountsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageSeedsAccountsCubit, ManageSeedsAccountsState>(
      builder: (context, state) {
        final colors = context.themeStyle.colors;

        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: DimensSize.d12,
            horizontal: DimensSize.d16,
          ),
          child: SeparatedColumn(
            separatorSize: DimensSize.d16,
            children: [
              Text(
                LocaleKeys.manageSeedsAndAccounts.tr(),
                style: StyleRes.h1.copyWith(color: colors.textPrimary),
              ),
              SeparatedRow(
                children: [
                  Expanded(
                    child: CommonCard(
                      height: DimensSize.d76,
                      padding: const EdgeInsets.symmetric(
                        horizontal: DimensSize.d16,
                      ),
                      topSubtitleText: LocaleKeys.currentSeed.tr(),
                      titleText: state.currentSeed?.name ?? '',
                    ),
                  ),
                  Expanded(
                    child: CommonCard(
                      padding: const EdgeInsets.symmetric(
                        horizontal: DimensSize.d16,
                      ),
                      height: DimensSize.d76,
                      topSubtitleText: LocaleKeys.totalBalance.tr(),
                      titleText: '0 USD',
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: ShapedContainerColumn(
                    margin: EdgeInsets.zero,
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
              CommonButton(
                leading: CommonButtonIconWidget.svg(
                  svg: Assets.images.plus.path,
                ),
                text: LocaleKeys.addSeedPhrase.tr(),
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
            AppRoute.enterSeedName
                .pathWithData(EnterSeedNameCommand.create.name),
          );
        case SelectAddSeedType.import:
          context.goFurther(
            AppRoute.enterSeedName
                .pathWithData(EnterSeedNameCommand.import.name),
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
        final colors = context.themeStyle.colors;

        return CommonListTile(
          padding: EdgeInsets.zero,
          onPressed: () => context.goFurther(
            AppRoute.seedDetail.pathWithData(seed.publicKey.publicKey),
          ),
          leading: CommonBackgroundedIconWidget.svg(
            svg: Assets.images.sparxLogoSmall.path,
            useDefaultColor: false,
          ),
          titleText: seed.name,
          subtitleText: LocaleKeys.publicKeysWithData.plural(
            seed.allKeys.length,
            args: ['${seed.allKeys.length}', '0 USD'],
          ),
          trailing: SeparatedRow(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (currentSeed?.publicKey == seed.publicKey)
                CommonIconWidget.svg(
                  svg: Assets.images.check.path,
                  color: colors.textPrimary,
                ),
              CommonIconButton.svg(
                color: colors.textSecondary,
                svg: Assets.images.settings.path,
                buttonType: EverButtonType.ghost,
                onPressed: () => showSeedSettingsSheet(context, seed.publicKey),
                innerPadding: const EdgeInsets.all(DimensSize.d8),
              ),
            ],
          ),
        );
      },
    );
  }
}
