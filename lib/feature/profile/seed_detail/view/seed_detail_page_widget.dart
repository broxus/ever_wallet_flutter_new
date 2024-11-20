import 'package:app/app/router/router.dart';
import 'package:app/feature/profile/seed_detail/view/seed_detail_page_wm.dart';
import 'package:app/feature/profile/seed_detail/widgets/key_settings_sheet.dart';
import 'package:app/generated/generated.dart';
import 'package:collection/collection.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class SeedDetailPageWidget extends ElementaryWidget<SeedDetailPageWidgetModel> {
  const SeedDetailPageWidget({
    required this.publicKey,
    Key? key,
    WidgetModelFactory wmFactory = defaultSeedDetailPageWidgetModelFactory,
  }) : super(wmFactory, key: key);

  final PublicKey publicKey;

  @override
  Widget build(SeedDetailPageWidgetModel wm) {
    final theme = wm.theme;

    return Scaffold(
      appBar: DefaultAppBar(
        actions: [
          FloatButton(
            buttonShape: ButtonShape.circle,
            icon: LucideIcons.cog,
            buttonSize: ButtonSize.medium,
            onPressed: wm.onSeedSettings,
          ),
        ],
      ),
      body: TripleSourceBuilder(
        firstSource: wm.seed,
        secondSource: wm.currentSeed,
        thirdSource: wm.currentKey,
        builder: (_, seed, currentSeed, currentKey) => ContainerColumn(
          separatorSize: DimensSizeV2.d16,
          padding: const EdgeInsets.all(DimensSizeV2.d16),
          children: [
            SeparatedColumn(
              separatorSize: DimensSizeV2.d4,
              children: [
                if (seed != null && seed == currentSeed)
                  Text(
                    LocaleKeys.currentSeed.tr(),
                    style: theme.textStyles.labelXSmall
                        .copyWith(color: theme.colors.content3),
                  ),
                Text(
                  seed?.name ?? '',
                  style: theme.textStyles.headingLarge,
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: StateNotifierBuilder(
                  listenableState: wm.findingExistingWallets,
                  builder: (_, findingExistingWallets) {
                    final items = seed?.allKeys.mapIndexed(
                      (i, seedKey) => _KeyItem(
                        key: ValueKey(seedKey),
                        seedKey: seedKey,
                        isActive: seedKey.publicKey == currentKey,
                        isShowingDivider: i != seed.allKeys.length - 1,
                        isLoading: findingExistingWallets?.contains(
                              seedKey.publicKey.toString(),
                            ) ??
                            false,
                      ),
                    );

                    return ShapedContainerColumn(
                      color: theme.colors.background1,
                      margin: EdgeInsets.zero,
                      titleText: LocaleKeys.keysWord.tr(),
                      mainAxisSize: MainAxisSize.min,
                      children: items?.toList() ?? [],
                    );
                  },
                ),
              ),
            ),
            if (seed?.masterKey.isLegacy == false)
              PrimaryButton(
                buttonShape: ButtonShape.pill,
                title: LocaleKeys.addKey.tr(),
                postfixIcon: LucideIcons.plus,
                onPressed: wm.onAddkeys,
              ),
          ],
        ),
      ),
    );
  }
}

class _KeyItem extends StatelessWidget {
  const _KeyItem({
    required this.seedKey,
    required this.isActive,
    required this.isShowingDivider,
    required this.isLoading,
    super.key,
  });

  final SeedKey seedKey;
  final bool isActive;
  final bool isShowingDivider;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return Column(
      children: [
        CommonListTile(
          onPressed: () => context.goFurther(
            AppRoute.keyDetail.pathWithData(
              pathParameters: {
                keyDetailPublicKeyPathParam: seedKey.publicKey.publicKey,
              },
            ),
          ),
          padding: EdgeInsets.zero,
          leading: CommonBackgroundedIconWidget.svg(
            svg: Assets.images.key.path,
            backgroundColor: theme.colors.backgroundAlpha,
          ),
          titleText: seedKey.name,
          trailing: SeparatedRow(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isActive)
                CommonIconWidget.svg(
                  svg: Assets.images.check.path,
                  color: theme.colors.content0,
                ),
              CommonIconButton.svg(
                svg: Assets.images.settings.path,
                color: theme.colors.content0,
                buttonType: EverButtonType.ghost,
                size: CommonIconButtonSize.xsmall,
                onPressed: () => showKeySettingsSheet(
                  context: context,
                  publicKey: seedKey.publicKey,
                  isMaster: seedKey.isMaster,
                ),
              ),
            ],
          ),
          subtitleChild: isLoading
              ? ProgressIndicatorWidget(
                  size: DimensSizeV2.d18,
                  color: theme.colors.content3,
                )
              : Text(
                  LocaleKeys.accountsWithData.plural(
                    seedKey.accountList.allAccounts.length,
                    args: ['${seedKey.accountList.allAccounts.length}'],
                  ),
                  style: theme.textStyles.labelXSmall.copyWith(
                    color: theme.colors.content3,
                  ),
                ),
        ),
        if (isShowingDivider) const CommonDivider(),
      ],
    );
  }
}
