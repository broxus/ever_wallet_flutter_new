import 'package:app/feature/profile/widgets/switch_to_seed_sheet/switch_to_seed_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class SwitchToSeedWidget extends ElementaryWidget<SwitchToSeedWidgetModel> {
  const SwitchToSeedWidget({
    required this.publicKey,
    Key? key,
    WidgetModelFactory wmFactory = defaultSwitchToSeedWidgetModelFactory,
  }) : super(wmFactory, key: key);

  final PublicKey publicKey;

  @override
  Widget build(SwitchToSeedWidgetModel wm) {
    final theme = wm.theme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: DimensSizeV2.d24),
        Image.asset(
          Assets.images.checkCircleFill.checkCircleFill.path,
          height: DimensSizeV2.d56,
          width: DimensSizeV2.d56,
        ),
        const SizedBox(height: DimensSizeV2.d16),
        Text(
          LocaleKeys.newSeedPhraseSwitchTitle.tr(),
          style: theme.textStyles.headingLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: DimensSizeV2.d8),
        Text(
          LocaleKeys.newSeedPhraseSwitchSubtitle.tr(),
          style: theme.textStyles.paragraphMedium.copyWith(
            color: theme.colors.content1,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: DimensSizeV2.d24),
        AccentButton(
          buttonShape: ButtonShape.pill,
          title: LocaleKeys.newSeedPhraseSwitchButton.tr(),
          onPressed: wm.onSwitch,
        ),
        const SizedBox(height: DimensSizeV2.d8),
        PrimaryButton(
          buttonShape: ButtonShape.pill,
          title: LocaleKeys.accountAddedSheetContinue.tr(),
          onPressed: wm.onContinue,
        ),
      ],
    );
  }
}
