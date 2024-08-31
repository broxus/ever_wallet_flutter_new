import 'dart:ui';

extension ColorExtension on Color {
  ColorFilter get colorFilter => ColorFilter.mode(
        this,
        BlendMode.srcIn,
      );
}
