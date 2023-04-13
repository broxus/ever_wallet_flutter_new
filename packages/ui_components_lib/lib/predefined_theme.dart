import 'package:flutter/rendering.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Default theme for ever app
ThemeStyle everPredefinedTheme() {
  return ThemeStyle(
    colors: const ColorsPalette(
      primaryTappableColor: ColorsRes.lightAccentPrimary,
      secondaryTappableColor: ColorsRes.lightAccentSecondary,
    ),
    styles: StylesPalette(
      buttonTextStyle: StyleRes.medium16,
      buttonsStyle: {
        EverButtonType.primary: const EverButtonStyle(
          backgroundColor: ColorsRes.lightAccentPrimary,
          contentColor: ColorsRes.lightTextButtonPrimary,
          disabledBackgroundColor: ColorsRes.lightAccentPrimaryDisabled,
          splashColor: ColorsRes.lightAccentPrimaryPressed,
        ),
        EverButtonType.secondary: const EverButtonStyle(
          backgroundColor: ColorsRes.lightAccentSecondary,
          contentColor: ColorsRes.lightTextButtonSecondary,
          disabledBackgroundColor: ColorsRes.lightAccentSecondaryDisabled,
          splashColor: ColorsRes.lightAccentSecondaryPressed,
          contentDisabledColor: ColorsRes.lightTextButtonDisabled,
        ),
        EverButtonType.tertiary: EverButtonStyle(
          backgroundColor: ColorsRes.transparent,
          contentColor: ColorsRes.lightTextButtonSecondary,
          disabledBackgroundColor: ColorsRes.transparent,
          splashColor: ColorsRes.lightAccentTertiaryPressed,
          border: Border.all(color: ColorsRes.lightAccentTertiary),
          disabledBorder: Border.all(
            color: ColorsRes.lightAccentTertiaryDisabled,
          ),
        ),
        EverButtonType.ghost: const EverButtonStyle(
          backgroundColor: ColorsRes.transparent,
          contentColor: ColorsRes.lightTextButtonSecondary,
          contentDisabledColor: ColorsRes.lightTextButtonDisabled,
          disabledBackgroundColor: ColorsRes.transparent,
          splashColor: ColorsRes.lightAccentTertiaryPressed,
        ),
        EverButtonType.ghostNoPadding: const EverButtonStyle(
          backgroundColor: ColorsRes.transparent,
          contentColor: ColorsRes.lightTextButtonSecondary,
          contentDisabledColor: ColorsRes.lightTextButtonDisabled,
          disabledBackgroundColor: ColorsRes.transparent,
          splashColor: ColorsRes.lightAccentTertiaryPressed,
          contentPadding: EdgeInsets.zero,
        ),
        EverButtonType.attention: const EverButtonStyle(
          backgroundColor: ColorsRes.lightAccentWarning,
          contentColor: ColorsRes.lightTextButtonPrimary,
          disabledBackgroundColor: ColorsRes.lightAccentWarningDisabled,
          splashColor: ColorsRes.lightAccentWarningPressed,
        ),
      },
    ),
  );
}
