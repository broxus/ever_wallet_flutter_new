import 'package:flutter/rendering.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Default theme for ever app
ThemeStyle everPredefinedTheme() {
  return ThemeStyle(
    colors: const ColorsPalette(
      primaryTappableColor: ColorsRes.bluePrimary,
      secondaryTappableColor: ColorsRes.blue950,
    ),
    styles: StylesPalette(
      buttonTextStyle: StyleRes.medium16,
      buttonsStyle: {
        EverButtonType.primary: const EverButtonStyle(
          backgroundColor: ColorsRes.bluePrimary,
          contentColor: ColorsRes.white,
          disabledBackgroundColor: ColorsRes.blue900,
          splashColor: ColorsRes.blue200,
        ),
        EverButtonType.secondary: const EverButtonStyle(
          backgroundColor: ColorsRes.blue950,
          contentColor: ColorsRes.bluePrimary,
          disabledBackgroundColor: ColorsRes.blue970,
          splashColor: ColorsRes.blue850,
          contentDisabledColor: ColorsRes.blue800,
        ),
        EverButtonType.tertiary: EverButtonStyle(
          backgroundColor: ColorsRes.transparent,
          contentColor: ColorsRes.bluePrimary,
          disabledBackgroundColor: ColorsRes.blue970,
          splashColor: ColorsRes.blue850,
          border: Border.all(color: ColorsRes.bluePrimary),
          disabledBorder: Border.all(color: ColorsRes.blue950),
        ),
        EverButtonType.ghost: const EverButtonStyle(
          backgroundColor: ColorsRes.transparent,
          contentColor: ColorsRes.bluePrimary,
          contentDisabledColor: ColorsRes.blue800,
          disabledBackgroundColor: ColorsRes.transparent,
          splashColor: ColorsRes.blue850,
        ),
        EverButtonType.ghostNoPadding: const EverButtonStyle(
          backgroundColor: ColorsRes.transparent,
          contentColor: ColorsRes.bluePrimary,
          contentDisabledColor: ColorsRes.blue800,
          disabledBackgroundColor: ColorsRes.transparent,
          splashColor: ColorsRes.blue850,
          contentPadding: EdgeInsets.zero,
        ),
        EverButtonType.attention: const EverButtonStyle(
          backgroundColor: ColorsRes.redPrimary,
          contentColor: ColorsRes.white,
          disabledBackgroundColor: ColorsRes.red900,
          splashColor: ColorsRes.red200,
        ),
      },
    ),
  );
}
