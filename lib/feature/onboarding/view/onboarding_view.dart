import 'package:app/app/router/app_route.dart';
import 'package:app/feature/onboarding/onboarding.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:url_launcher/url_launcher_string.dart';

const decentralizationPolicyLink =
    'https://l1.broxus.com/everscale/wallet/terms';

/// Main widget of onboarding that new users see
class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    return SafeArea(
      minimum: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          const Expanded(child: SlidingBlockChains()),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: DimensSize.d12),
                Text(
                  LocaleKeys.welcomeTitle.tr(),
                  style: StyleRes.balance.copyWith(color: colors.textPrimary),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: DimensSize.d12),
                Text(
                  LocaleKeys.supportTokenAndAccessEverscale.tr(),
                  style: StyleRes.primaryRegular
                      .copyWith(color: colors.textPrimary),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: DimensSize.d24),
                CommonButton.primary(
                  text: LocaleKeys.createNewWallet.tr(),
                  onPressed: () => context.goFurther(AppRoute.createSeed.path),
                  fillWidth: true,
                ),
                const SizedBox(height: DimensSize.d8),
                CommonButton.secondary(
                  text: LocaleKeys.signInWithPhrase.tr(),
                  onPressed: () => context.goFurther(AppRoute.enterSeed.path),
                  fillWidth: true,
                ),
                // const SizedBox(height: 12),
                // CommonButton.secondary(
                // TODO(alex-a4): change icon
                //   leading: Assets.images.ledger.svg(
                //     color: style.styles.secondaryButtonStyle.color,
                //   ),
                //   onPressed: () {},
                // ),
                const SizedBox(height: DimensSize.d16),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: LocaleKeys.byProcessingAcceptLicense.tr(),
                        style: StyleRes.addRegular
                            .copyWith(color: colors.textSecondary),
                      ),
                      TextSpan(
                        text: LocaleKeys.readHere.tr(),
                        style: StyleRes.addRegular.copyWith(color: colors.blue),
                        recognizer: TapGestureRecognizer()..onTap = _onLinkTap,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onLinkTap() => launchUrlString(decentralizationPolicyLink);
}
