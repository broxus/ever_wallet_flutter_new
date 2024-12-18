import 'package:ui_components_lib/v2/theme_style_v2.dart';
import 'package:ui_components_lib/v2/widgets/buttons/button.dart';

const defaultBackgroundBlur = 25.0;

class FloatButton extends BaseButton {
  const FloatButton({
    required super.buttonShape,
    super.onPressed,
    super.isLoading,
    super.title,
    super.child,
    super.icon,
    super.postfixIcon,
    super.buttonSize,
    super.key,
    super.isFullWidth,
    super.backgroundBlur = defaultBackgroundBlur,
  });

  @override
  AppButtonStyle getStyle(ThemeStyleV2 theme) =>
      AppButtonStyle.float(theme.colors, theme.textStyles);
}
