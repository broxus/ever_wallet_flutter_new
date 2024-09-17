import 'dart:ui';

enum IdentifyColor {
  purple(Color(0x7c3cdeff)),
  blue(Color(0x3c6adeff)),
  green(Color(0x80de3cff)),
  pink(Color(0xfe76dfff)),
  orange(Color(0xff6f2fff));

  const IdentifyColor(this.color);

  final Color color;

  static IdentifyColor? byInt(int? value) {
    for (final ic in IdentifyColor.values) {
      if (ic.color.value == value) {
        return ic;
      }
    }

    return null;
  }
}
