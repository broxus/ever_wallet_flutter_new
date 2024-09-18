import 'dart:ui';

enum IdentifyColor {
  // jdenticon web 0x7c3cdeff transform to Flutter color:
  purple(Color(0xff7c3cde)),
  // jdenticon web 0x3c6adeff transform to Flutter color:
  blue(Color(0xff3c6ade)),
  // jdenticon web 0x80de3cff transform to Flutter color:
  green(Color(0xff80de3c)),
  // jdenticon web 0xfe76dfff transform to Flutter color:
  pink(Color(0xfffe76df)),
  // jdenticon web 0xff6f2fff transform to Flutter color:
  orange(Color(0xffff6f2f));

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
