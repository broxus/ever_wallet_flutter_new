import 'package:app/app/router/app_route.dart';
import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/onboarding/onboarding.dart';
import 'package:app/l10n/l10n.dart';
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
    final l10n = context.l10n;
    final colors = context.themeStyle.colors;

    return OnboardingBackground(
      child: SafeArea(
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
                  CommonButton.primary(
                    text: 'Message',
                    onPressed: () => inject<MessengerService>().show(
                      Message.info(message: 'Message'),
                    ),
                    fillWidth: true,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    l10n.welcomeTitle,
                    style: StyleRes.balance.copyWith(color: colors.textPrimary),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.supportTokenAndAccessEverscale,
                    style: StyleRes.primaryRegular
                        .copyWith(color: colors.textPrimary),
                  ),
                  const SizedBox(height: 32),
                  CommonButton.primary(
                    text: context.l10n.createNewWallet,
                    onPressed: () =>
                        context.goFurther(AppRoute.createSeed.path),
                    fillWidth: true,
                  ),
                  const SizedBox(height: 8),
                  CommonButton.secondary(
                    text: context.l10n.signIn,
                    onPressed: () => context.goFurther(AppRoute.enterSeed.path),
                    fillWidth: true,
                  ),
                  // const SizedBox(height: 12),
                  // CommonButton.secondary(
                  //   text: l10n.signWithLedger,
                  // TODO(alex-a4): change icon
                  //   leading: Assets.images.ledger.svg(
                  //     color: style.styles.secondaryButtonStyle.color,
                  //   ),
                  //   onPressed: () {},
                  // ),
                  const SizedBox(height: 16),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: l10n.byProcessingAcceptLicense,
                          style: StyleRes.addRegular.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                        TextSpan(
                          text: l10n.readHere,
                          style:
                              StyleRes.addRegular.copyWith(color: colors.blue),
                          recognizer: TapGestureRecognizer()..onTap = onLinkTap,
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
      ),
    );
  }

  void onLinkTap() => launchUrlString(decentralizationPolicyLink);
}
