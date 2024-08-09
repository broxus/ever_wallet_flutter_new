import 'package:app/feature/localization/bloc/localization_bloc.dart';
import 'package:app/feature/onboarding/screen/welcome/welcome_screen_wm.dart';
import 'package:app/feature/onboarding/widgets/sliding_block_chains.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/factories/bloc_factories/localization_bloc_factory.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Onboarding welcome screen
class WelcomeScreen extends ElementaryWidget<WelcomeScreenWidgetModel> {
  const WelcomeScreen({
    Key? key,
    WidgetModelFactory<WelcomeScreenWidgetModel> wmFactory =
        defaultWelcomeScreenWidgetModelFactory,
  }) : super(
          wmFactory,
          key: key,
        );

  @override
  Widget build(WelcomeScreenWidgetModel wm) {
    final themeStyle = wm.themeStyle;

    return BlocProvider<LocalizationBloc>(
      create: localizationBlocFactory,
      child: Scaffold(
        backgroundColor: themeStyle.colors.background0,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
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
                      onPressed: wm.onPressedCreateWallet,
                      buttonShape: ButtonShape.pill,
                    ),
                    const SizedBox(height: DimensSize.d8),
                    PrimaryButton(
                      title: LocaleKeys.welcomeIHaveOne.tr(),
                      onPressed: wm.onPressedWalletLogin,
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
                                ..onTap = wm.onLinkTap,
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
        ),
      ),
    );
  }
}
