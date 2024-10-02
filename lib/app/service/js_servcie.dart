import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@singleton
class JsService {
  JsService() {
    loadNekotonJs();
  }

  final _nekotonJsState = EntityStateNotifier<String?>();

  EntityValueListenable<String?> get nekotonJsState => _nekotonJsState;

  EntityState<String?> get _nekotonJsValue => _nekotonJsState.value;

  Future<void> loadNekotonJs() async {
    if (_nekotonJsValue.isLoadingState || _nekotonJsValue.data != null) {
      return;
    }

    try {
      _nekotonJsState
        ..loading()
        ..content(
          await rootBundle.loadString('assets/js/nekoton.js'),
        );
    } catch (_) {
      _nekotonJsState.error();
    }
  }
}
