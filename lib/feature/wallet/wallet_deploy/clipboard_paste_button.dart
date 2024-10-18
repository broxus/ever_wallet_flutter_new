import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/v2/widgets/widgets.dart';

class ClipboardPasteButton extends PrimaryButton {
  const ClipboardPasteButton({
    super.key,
    super.onPressed,
  }) : super(
          buttonShape: ButtonShape.square,
          icon: LucideIcons.clipboardPaste,
          buttonSize: ButtonSize.small,
        );
}
