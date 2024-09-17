import 'dart:ui';

abstract interface class IIdentifyIconsService {
  abstract final List<Color> availableColors;

  Stream<Map<String, Color>> get cacheStream;

  Color get initialColor;

  Future<void> setColor(String key, Color color);
}
