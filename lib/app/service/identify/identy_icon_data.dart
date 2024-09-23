import 'dart:ui';

enum IdentifyIconData {
  purple(
    hues: [267],
    lightness: _defaultLightness,
    saturation: _defaultSaturation,
    bacColor: '#7c3cdeff',
    // jdenticon web 0x7c3cdeff transform to Flutter color:
    color: Color(0xff7c3cde),
  ),
  blue(
    hues: [254],
    lightness: _defaultLightness,
    saturation: _defaultSaturation,
    bacColor: '#3c6adeff',
    // jdenticon web 0x3c6adeff transform to Flutter color:
    color: Color(0xff3c6ade),
  ),
  green(
    hues: [107],
    lightness: _defaultLightness,
    saturation: _defaultSaturation,
    bacColor: '#80de3cff',
    // jdenticon web 0x80de3cff transform to Flutter color:
    color: Color(0xff80de3c),
  ),
  pink(
    hues: [309],
    lightness: _defaultLightness,
    saturation: Saturation(color: 1, grayscale: 1),
    bacColor: '#fe76dfff',
    // jdenticon web 0xfe76dfff transform to Flutter color:
    color: Color(0xfffe76df),
  ),
  orange(
    hues: [19],
    lightness: _defaultLightness,
    saturation: _defaultSaturation,
    bacColor: '#ff6f2fff',
    // jdenticon web 0xff6f2fff transform to Flutter color:
    color: Color(0xffff6f2f),
  );

  const IdentifyIconData({
    required this.hues,
    required this.lightness,
    required this.saturation,
    required this.color,
    required this.bacColor,
  });

  final List<int> hues;
  final Lightness lightness;
  final Saturation saturation;
  final String bacColor;
  final Color color;

  static IdentifyIconData? byNameOrNull(String? name) {
    if (name == null) {
      return null;
    }

    try {
      return IdentifyIconData.values.byName(name);
    } catch (_) {
      return null;
    }
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
