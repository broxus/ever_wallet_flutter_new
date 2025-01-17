import 'package:app/feature/wallet/staking/models/models.dart';
import 'package:app/feature/wallet/widgets/widgets.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/widgets.dart';

/// Helper function that displays [StEverHowItWorksSheet]
Future<void> showStEverHowItWorksSheet({
  required BuildContext context,
  required StakingInfo info,
  required String nativeTokenTicker,
  required String nativeTokenIcon,
}) {
  return showCommonBottomSheet(
    context: context,
    useAppBackgroundColor: true,
    title: LocaleKeys.howLiquidStakingWorks.tr(),
    centerTitle: true,
    body: (_, scrollController) => StEverHowItWorksSheet(
      scrollController: scrollController,
      info: info,
      nativeTokenTicker: nativeTokenTicker,
      nativeTokenIcon: nativeTokenIcon,
    ),
  );
}

/// Sheet that describes how StEver works
class StEverHowItWorksSheet extends StatelessWidget {
  const StEverHowItWorksSheet({
    required this.scrollController,
    required this.info,
    required this.nativeTokenTicker,
    required this.nativeTokenIcon,
    super.key,
  });

  final ScrollController scrollController;
  final StakingInfo info;
  final String nativeTokenTicker;
  final String nativeTokenIcon;

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
                    icon: TonWalletIconWidget(path: nativeTokenIcon),
                    title: LocaleKeys.stakeEverTitle.tr(
                      args: [nativeTokenTicker],
                    ),
                    subtitle: LocaleKeys.stakeEverSubtitle.tr(
                      args: [nativeTokenTicker],
                    ),
                  ),
                  _step(
                    icon: TonWalletIconWidget(
                      path: info.tokenContractAsset?.logoURI ??
                          Assets.images.tokenDefaultIcon.path,
                    ),
                    title: LocaleKeys.receiveSteverTitle.tr(
                      args: [info.tokenWallet.symbol.name],
                    ),
                    subtitle: LocaleKeys.receiveSteverSubtitle.tr(
                      args: [info.tokenWallet.symbol.name],
                    ),
                  ),
                  _step(
                    icon: Assets.images.stever.steverDefi.svg(
                      width: DimensSizeV2.d40,
                      height: DimensSizeV2.d40,
                    ),
                    title: LocaleKeys.useSteverTitle.tr(
                      args: [info.tokenWallet.symbol.name],
                    ),
                    subtitle: LocaleKeys.useSteverSubtitle.tr(
                      args: [info.tokenWallet.symbol.name],
                    ),
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
