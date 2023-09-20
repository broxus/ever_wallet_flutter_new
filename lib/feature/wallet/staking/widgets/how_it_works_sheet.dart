import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper function that displays [StEverHowItWorksSheet]
Future<void> showStEverHowItWorksSheet(BuildContext context) {
  return showCommonBottomSheet(
    context: context,
    title: LocaleKeys.howLiquidStakingWorks.tr(),
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
      children: [
        Expanded(
          child: SingleChildScrollView(
            controller: scrollController,
            child: ShapedContainerColumn(
              margin: EdgeInsets.zero,
              padding: const EdgeInsets.symmetric(vertical: DimensSize.d16),
              separator: const Padding(
                padding: EdgeInsets.symmetric(vertical: DimensSize.d8),
                child: CommonDivider(),
              ),
              children: [
                _step(
                  icon: Assets.images.ever.svg(
                    width: DimensSize.d40,
                    height: DimensSize.d40,
                  ),
                  title: LocaleKeys.stakeEverTitle.tr(),
                  subtitle: LocaleKeys.stakeEverSubtitle.tr(),
                ),
                _step(
                  icon: Assets.images.stever.stever.svg(
                    width: DimensSize.d40,
                    height: DimensSize.d40,
                  ),
                  title: LocaleKeys.receiveSteverTitle.tr(),
                  subtitle: LocaleKeys.receiveSteverSubtitle.tr(),
                ),
                _step(
                  icon: Assets.images.stever.steverDefi.svg(
                    width: DimensSize.d40,
                    height: DimensSize.d40,
                  ),
                  title: LocaleKeys.useSteverTitle.tr(),
                  subtitle: LocaleKeys.useSteverSubtitle.tr(),
                ),
              ],
            ),
          ),
        ),
        CommonButton.primary(
          text: LocaleKeys.gotIt.tr(),
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
        final colors = context.themeStyle.colors;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
          child: SeparatedRow(
            crossAxisAlignment: CrossAxisAlignment.start,
            separatorSize: DimensSize.d12,
            children: [
              icon,
              Expanded(
                child: SeparatedColumn(
                  separatorSize: DimensSize.d4,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: StyleRes.primaryRegular.copyWith(
                        color: colors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: StyleRes.secondaryRegular.copyWith(
                        color: colors.textPrimary,
                      ),
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
