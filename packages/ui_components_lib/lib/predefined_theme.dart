import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Default theme for ever app with light brightness
ThemeData everPredefinedLightTheme() {
  const colors = ColorsPalette(
    backgroundPrimary: ColorsRes.white,
    backgroundOverlay: ColorsRes.neutral300Opacity60,
    textPrimary: ColorsRes.black,
    textSecondary: ColorsRes.neutral300,
    textTertiary: ColorsRes.neutral600,
    textButtonPrimary: ColorsRes.white,
    textButtonSecondary: ColorsRes.bluePrimary,
    textNegative: ColorsRes.redPrimary,
    textPositive: ColorsRes.greenPrimary,
    textButtonPressed: ColorsRes.blue200,
    textButtonDisabled: ColorsRes.blue800,
    accentPrimary: ColorsRes.bluePrimary,
    accentPrimaryPressed: ColorsRes.blue200,
    accentPrimaryDisabled: ColorsRes.blue900,
    accentSecondary: ColorsRes.blue950,
    accentSecondaryPressed: ColorsRes.blue850,
    accentSecondaryDisabled: ColorsRes.blue970,
    accentTertiary: ColorsRes.blue950,
    accentTertiaryPressed: ColorsRes.blue950,
    accentTertiaryDisabled: ColorsRes.blue950,
    accentWarning: ColorsRes.redPrimary,
    accentWarningPressed: ColorsRes.red200,
    accentWarningDisabled: ColorsRes.red900,
    fillingPrimary: ColorsRes.neutral950,
    fillingSecondary: ColorsRes.blue950,
    fillingTertiary: ColorsRes.neutral700,
    fillingHover: ColorsRes.neutral900,
    statusPositiveTitle: ColorsRes.green300,
    statusPositiveBackground: ColorsRes.green900,
    statusMediumTitle: ColorsRes.yellow300,
    statusMediumBackground: ColorsRes.yellow900,
    statusNegativeTitle: ColorsRes.red300,
    statusNegativeBackground: ColorsRes.red900,
  );
  return ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: colors.backgroundPrimary,
    extensions: [
      ThemeStyle(
        colors: colors,
        styles: StylesPalette(
          buttonTextStyle: StyleRes.medium16,
          buttonsStyle: {
            EverButtonType.primary: EverButtonStyle(
              backgroundColor: colors.accentPrimary,
              contentColor: colors.textButtonPrimary,
              disabledBackgroundColor: colors.accentPrimaryDisabled,
              splashColor: colors.accentPrimaryPressed,
            ),
            EverButtonType.secondary: EverButtonStyle(
              backgroundColor: colors.accentSecondary,
              contentColor: colors.textButtonSecondary,
              disabledBackgroundColor: colors.accentSecondaryDisabled,
              splashColor: colors.accentSecondaryPressed,
              contentDisabledColor: colors.textButtonDisabled,
            ),
            EverButtonType.tertiary: EverButtonStyle(
              backgroundColor: ColorsRes.transparent,
              contentColor: colors.textButtonSecondary,
              disabledBackgroundColor: ColorsRes.transparent,
              splashColor: colors.accentTertiaryPressed,
              border: Border.all(color: colors.accentTertiary),
              disabledBorder: Border.all(
                color: colors.accentTertiaryDisabled,
              ),
            ),
            EverButtonType.ghost: EverButtonStyle(
              backgroundColor: ColorsRes.transparent,
              contentColor: colors.textButtonSecondary,
              contentDisabledColor: colors.textButtonDisabled,
              disabledBackgroundColor: ColorsRes.transparent,
              splashColor: colors.accentTertiaryPressed,
            ),
            EverButtonType.ghostNoPadding: EverButtonStyle(
              backgroundColor: ColorsRes.transparent,
              contentColor: colors.textButtonSecondary,
              contentDisabledColor: colors.textButtonDisabled,
              disabledBackgroundColor: ColorsRes.transparent,
              splashColor: colors.accentTertiaryPressed,
              contentPadding: EdgeInsets.zero,
            ),
            EverButtonType.attention: EverButtonStyle(
              backgroundColor: colors.accentWarning,
              contentColor: colors.textButtonPrimary,
              disabledBackgroundColor: colors.accentWarningDisabled,
              splashColor: colors.accentWarningPressed,
            ),
          },
        ),
      ),
    ],
  );
}

// TODO(alex-a4): add when design will be ready
/// Default theme for ever app with dark brightness
ThemeData everPredefinedDarkTheme() {
  const colors = ColorsPalette(
    backgroundPrimary: ColorsRes.dark060C32,
    backgroundOverlay: ColorsRes.neutral300Opacity60,
    textPrimary: ColorsRes.black,
    textSecondary: ColorsRes.neutral300,
    textTertiary: ColorsRes.neutral600,
    textButtonPrimary: ColorsRes.white,
    textButtonSecondary: ColorsRes.bluePrimary,
    textNegative: ColorsRes.redPrimary,
    textPositive: ColorsRes.greenPrimary,
    textButtonPressed: ColorsRes.blue200,
    textButtonDisabled: ColorsRes.blue800,
    accentPrimary: ColorsRes.bluePrimary,
    accentPrimaryPressed: ColorsRes.blue200,
    accentPrimaryDisabled: ColorsRes.blue900,
    accentSecondary: ColorsRes.blue950,
    accentSecondaryPressed: ColorsRes.blue850,
    accentSecondaryDisabled: ColorsRes.blue970,
    accentTertiary: ColorsRes.blue950,
    accentTertiaryPressed: ColorsRes.blue950,
    accentTertiaryDisabled: ColorsRes.blue950,
    accentWarning: ColorsRes.redPrimary,
    accentWarningPressed: ColorsRes.red200,
    accentWarningDisabled: ColorsRes.red900,
    fillingPrimary: ColorsRes.neutral600,
    fillingSecondary: ColorsRes.blue950,
    fillingTertiary: ColorsRes.neutral600,
    fillingHover: ColorsRes.neutral900,
    statusPositiveTitle: ColorsRes.green300,
    statusPositiveBackground: ColorsRes.green900,
    statusMediumTitle: ColorsRes.yellow300,
    statusMediumBackground: ColorsRes.yellow900,
    statusNegativeTitle: ColorsRes.red300,
    statusNegativeBackground: ColorsRes.red900,
  );
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: colors.backgroundPrimary,
    extensions: [
      ThemeStyle(
        colors: colors,
        styles: StylesPalette(
          buttonTextStyle: StyleRes.medium16,
          buttonsStyle: {
            EverButtonType.primary: EverButtonStyle(
              backgroundColor: colors.accentPrimary,
              contentColor: colors.textButtonPrimary,
              disabledBackgroundColor: colors.accentPrimaryDisabled,
              splashColor: colors.accentPrimaryPressed,
            ),
            EverButtonType.secondary: EverButtonStyle(
              backgroundColor: colors.accentSecondary,
              contentColor: colors.textButtonSecondary,
              disabledBackgroundColor: colors.accentSecondaryDisabled,
              splashColor: colors.accentSecondaryPressed,
              contentDisabledColor: colors.textButtonDisabled,
            ),
            EverButtonType.tertiary: EverButtonStyle(
              backgroundColor: ColorsRes.transparent,
              contentColor: colors.textButtonSecondary,
              disabledBackgroundColor: ColorsRes.transparent,
              splashColor: colors.accentTertiaryPressed,
              border: Border.all(color: colors.accentTertiary),
              disabledBorder: Border.all(
                color: colors.accentTertiaryDisabled,
              ),
            ),
            EverButtonType.ghost: EverButtonStyle(
              backgroundColor: ColorsRes.transparent,
              contentColor: colors.textButtonSecondary,
              contentDisabledColor: colors.textButtonDisabled,
              disabledBackgroundColor: ColorsRes.transparent,
              splashColor: colors.accentTertiaryPressed,
            ),
            EverButtonType.ghostNoPadding: EverButtonStyle(
              backgroundColor: ColorsRes.transparent,
              contentColor: colors.textButtonSecondary,
              contentDisabledColor: colors.textButtonDisabled,
              disabledBackgroundColor: ColorsRes.transparent,
              splashColor: colors.accentTertiaryPressed,
              contentPadding: EdgeInsets.zero,
            ),
            EverButtonType.attention: EverButtonStyle(
              backgroundColor: colors.accentWarning,
              contentColor: colors.textButtonPrimary,
              disabledBackgroundColor: colors.accentWarningDisabled,
              splashColor: colors.accentWarningPressed,
            ),
          },
        ),
      ),
    ],
  );
}
