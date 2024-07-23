import 'package:ui_components_lib/v2/theme_style_v2.dart';
import 'package:ui_components_lib/v2/widgets/buttons/button.dart';

class GhostButton extends BaseButton {
  const GhostButton({
    required super.buttonShape,
    super.onPressed,
    super.isLoading,
    super.title,
    super.child,
    super.icon,
    super.postfixIcon,
    super.buttonSize,
    super.key,
  });

  @override
  AppButtonStyle getStyle(ThemeStyleV2 theme) =>
      AppButtonStyle.ghost(theme.colors, theme.textStyles);
}