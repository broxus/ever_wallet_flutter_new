import 'package:app/app/service/identify/i_identify_icons_service.dart';
import 'package:app/app/service/secure_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@LazySingleton(as: IIdentifyIconsService)
class IdentifyIconsService implements IIdentifyIconsService {
  IdentifyIconsService(this._secureStorageService);

  @override
  final availableColors = const [
    Color(0x7c3cdeff),
    Color(0x3c6adeff),
    Color(0x80de3cff),
    Color(0xfe76dfff),
    Color(0xff6f2fff),
  ];

  final SecureStorageService _secureStorageService;

  final _initialIndex = 1;

  final _cacheSubject = BehaviorSubject<Map<String, Color>>.seeded({});

  @override
  Stream<Map<String, Color>> get cacheStream => _cacheSubject.stream;

  @override
  Color get initialColor => availableColors[_initialIndex];

  Map<String, Color> get _cache => _cacheSubject.value;

  @override
  Future<void> setColor(String key, Color color) async {
    try {
      await _secureStorageService.addValue<int>(
        key,
        color.value,
      );
    } finally {
      final newCache = {..._cache};
      newCache[key] = color;

      _cacheSubject.add(newCache);
    }
  }
}
