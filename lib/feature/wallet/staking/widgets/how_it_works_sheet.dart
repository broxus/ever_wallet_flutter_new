import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/widgets.dart';

/// Helper function that displays [StEverHowItWorksSheet]
Future<void> showStEverHowItWorksSheet(BuildContext context) {
  return showCommonBottomSheet(
    context: context,
    useAppBackgroundColor: true,
    title: LocaleKeys.howLiquidStakingWorks.tr(),
    centerTitle: true,
    body: (_, scrollController) => StEverHowItWorksSheet(
      scrollController: scrollController,
    ),
  );
}

/// Sheet that describes how StEver works
class StEverHowItWorksSheet extends StatelessWidget {
  const StEverHowItWorksSheet({
    required this.scrollController,
    super.key,
  });

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return SeparatedColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      separatorSize: DimensSizeV2.d16,
      children: [
        Flexible(
          child: SingleChildScrollView(
            controller: scrollController,
            child: PrimaryCard(
              padding: EdgeInsets.zero,
              borderRadius: BorderRadius.circular(DimensRadiusV2.radius12),
              child: SeparatedColumn(
                mainAxisSize: MainAxisSize.min,
                separator: const CommonDivider(),
                children: [
                  _step(
                    icon: Assets.images.ever.svg(
                      width: DimensSizeV2.d40,
                      height: DimensSizeV2.d40,
                    ),
                    title: LocaleKeys.stakeEverTitle.tr(),
                    subtitle: LocaleKeys.stakeEverSubtitle.tr(),
                  ),
                  _step(
                    icon: Assets.images.stever.stever.svg(
                      width: DimensSizeV2.d40,
                      height: DimensSizeV2.d40,
                    ),
                    title: LocaleKeys.receiveSteverTitle.tr(),
                    subtitle: LocaleKeys.receiveSteverSubtitle.tr(),
                  ),
                  _step(
                    icon: Assets.images.stever.steverDefi.svg(
                      width: DimensSizeV2.d40,
                      height: DimensSizeV2.d40,
                    ),
                    title: LocaleKeys.useSteverTitle.tr(),
                    subtitle: LocaleKeys.useSteverSubtitle.tr(),
                  ),
                ],
              ),
            ),
          ),
        ),
        PrimaryButton(
          buttonShape: ButtonShape.pill,
          title: LocaleKeys.gotIt.tr(),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  Widget _step({
    required Widget icon,
    required String title,
    required String subtitle,
  }) {
    return Builder(
      builder: (context) {
        final theme = context.themeStyleV2;

        return Padding(
          padding: const EdgeInsets.all(DimensSizeV2.d16),
          child: SeparatedRow(
            crossAxisAlignment: CrossAxisAlignment.start,
            separatorSize: DimensSizeV2.d12,
            children: [
              icon,
              Expanded(
                child: SeparatedColumn(
                  separatorSize: DimensSizeV2.d4,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textStyles.headingSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: theme.textStyles.paragraphSmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
