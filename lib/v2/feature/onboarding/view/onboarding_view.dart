import 'package:app/app/router/app_route.dart';
import 'package:app/generated/generated.dart';
import 'package:app/v2/feature/onboarding/onboarding.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/buttons/button.dart';
import 'package:url_launcher/url_launcher_string.dart';

const decentralizationPolicyLink =
    'https://l1.broxus.com/everscale/wallet/terms';

/// Main widget of onboarding that new users see
class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeStyle = context.themeStyleV2;

    return SafeArea(
      minimum: const EdgeInsets.only(bottom: DimensSize.d16),
      child: Column(
        children: [
          const Spacer(),
          const SlidingBlockChains(),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: DimensSize.d12),
                Center(
                  child: Text(
                    LocaleKeys.welcomeTitle.tr(),
                    style: themeStyle.textStyles.displayMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: DimensSize.d12),
                Center(
                  child: Text(
                    LocaleKeys.welcomeSubtitle.tr(),
                    style: themeStyle.textStyles.paragraphMedium
                        .copyWith(color: themeStyle.colors.content0),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: DimensSize.d24),
                AccentButton(
                  title: LocaleKeys.welcomeGetNewWallet.tr(),
                  onPressed: () =>
                      context.goFurther(AppRoute.importWallet.path),
                  buttonShape: ButtonShape.pill,
                ),
                const SizedBox(height: DimensSize.d8),
                PrimaryButton(
                  title: LocaleKeys.welcomeIHaveOne.tr(),
                  onPressed: () => context.goFurther(AppRoute.enterSeed.path),
                  buttonShape: ButtonShape.pill,
                ),
                const SizedBox(height: DimensSize.d16),
                Center(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: LocaleKeys.welcomeYouAccept.tr(),
                          style: themeStyle.textStyles.paragraphXSmall
                              .copyWith(color: themeStyle.colors.content3),
                        ),
                        TextSpan(
                          text: LocaleKeys.welcomeLicenceAgreement.tr(),
                          style: themeStyle.textStyles.paragraphXSmall
                              .copyWith(color: themeStyle.colors.content0),
                          recognizer: TapGestureRecognizer()
                            ..onTap = _onLinkTap,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
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
