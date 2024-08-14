import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/widgets.dart';

/// Collection [ChangeNotifier]]
class _NotifierSubscriptionsCollection {
  final _notifiers = <ChangeNotifier>[];

  /// Add [ChangeNotifier] or its successor to the notifier collection
  T add<T extends ChangeNotifier>(T notifier) {
    _notifiers.add(notifier);
    return notifier;
  }

  /// Closes all [ChangeNotifier] and clears the collection
  void dispose() {
    for (final notifier in _notifiers) {
      notifier.dispose();
    }
    _notifiers.clear();
  }
}

mixin NotifierSubscriptionsMixin<W extends ElementaryWidget,
    M extends ElementaryModel> on WidgetModel<W, M> {
  late final _subscriptionsCollection = _NotifierSubscriptionsCollection();

  @override
  @mustCallSuper
  void dispose() {
    _subscriptionsCollection.dispose();
    super.dispose();
  }

  /// Create [StateNotifier] and add to the notifier collection
  StateNotifier<T> createNotifier<T>([T? initValue]) {
    return _subscriptionsCollection.add(
      StateNotifier<T>(initValue: initValue),
    );
  }

  /// Create [ValueNotifier] and add to the notifier collection
  ValueNotifier<T> createValueNotifier<T>(T initValue) {
    return _subscriptionsCollection.add(
      ValueNotifier<T>(initValue),
    );
  }

  /// Create [Entity StateNotifier] and add to the notifier collection
  EntityStateNotifier<T?> createEntityNotifier<T>([
    EntityState<T?>? initialData,
  ]) {
    return _subscriptionsCollection.add(
      EntityStateNotifier<T?>(initialData),
    );
  }

  /// Create [TextEditingController] and add to the informant collection
  TextEditingController createTextEditingController([
    String? initialText,
  ]) {
    return _subscriptionsCollection.add(
      TextEditingController(text: initialText),
    );
  }

  /// Create [FocusNode] and add to the informant collection
  FocusNode createFocusNode() {
    return _subscriptionsCollection.add(FocusNode());
  }

  /// Create [ScrollController] and add to the informants collectionx
  ScrollController createScrollController() {
    return _subscriptionsCollection.add(ScrollController());
  }
}
