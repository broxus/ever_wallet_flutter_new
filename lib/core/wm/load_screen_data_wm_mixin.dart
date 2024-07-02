import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';

mixin LoadScreenDataMixin<W extends ElementaryWidget, M extends ElementaryModel,
    T> on WidgetModel<W, M> {
  EntityStateNotifier<T> get screenState;

  @protected
  Future<void> loadScreenData(
    Future<T?> Function() loadDataCallback, {
    ValueChanged<T>? onSuccess,
    void Function(Object error)? onError,
    VoidCallback? onEmpty,
  }) async {
    screenState.loading();
    try {
      final data = await loadDataCallback();

      if (data == null) {
        screenState.error();
        onEmpty?.call();
        return;
      }

      onSuccess?.call(data);

      screenState.content(data);
    } on Object catch (e) {
      screenState.error();
      onError?.call(e);
    }
  }
}
