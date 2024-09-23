import 'dart:ui';

enum IdentifyIconData {
  purple(
    hues: [267],
    lightness: _defaultLightness,
    saturation: _defaultSaturation,
    // jdenticon web 0x7c3cdeff transform to Flutter color:
    backgroundColor: Color(0xff7c3cde),
  ),
  blue(
    hues: [254],
    lightness: _defaultLightness,
    saturation: _defaultSaturation,
    // jdenticon web 0x3c6adeff transform to Flutter color:
    backgroundColor: Color(0xff3c6ade),
  ),
  green(
    hues: [107],
    lightness: _defaultLightness,
    saturation: _defaultSaturation,
    // jdenticon web 0x80de3cff transform to Flutter color:
    backgroundColor: Color(0xff80de3c),
  ),
  pink(
    hues: [309],
    lightness: _defaultLightness,
    saturation: Saturation(color: 1, grayscale: 1),
    // jdenticon web 0xfe76dfff transform to Flutter color:
    backgroundColor: Color(0xfffe76df),
  ),
  orange(
    hues: [19],
    lightness: _defaultLightness,
    saturation: _defaultSaturation,
    // jdenticon web 0xff6f2fff transform to Flutter color:
    backgroundColor: Color(0xffff6f2f),
  );

  const IdentifyIconData({
    required this.hues,
    required this.lightness,
    required this.saturation,
    required this.backgroundColor,
  });

  final List<int> hues;
  final Lightness lightness;
  final Saturation saturation;
  final Color backgroundColor;

  String get colorStr => '#${color.value.toRadixString(16).substring(2)}';

  Color get color => backgroundColor;

  static IdentifyIconData? byInt(int? value) {
    for (final ic in IdentifyIconData.values) {
      if (ic.backgroundColor.value == value) {
        return ic;
      }
    }

    return null;
  }
}

class Lightness {
  const Lightness({
    required this.colorMin,
    required this.colorMax,
    required this.grayscale,
  });

  final double colorMin;
  final double colorMax;

  final LightnessGrayscale grayscale;
}

class LightnessGrayscale {
  const LightnessGrayscale({
    required this.min,
    required this.max,
  });

  final double min;
  final double max;
}

class Saturation {
  const Saturation({
    required this.color,
    required this.grayscale,
  });

  final double color;
  final double grayscale;
}

const _defaultLightness = Lightness(
  colorMin: .17,
  colorMax: .17,
  grayscale: LightnessGrayscale(
    min: .18,
    max: .18,
  ),
);

const _defaultSaturation = Saturation(color: .99, grayscale: 1);
