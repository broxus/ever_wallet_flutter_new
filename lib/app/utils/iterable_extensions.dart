extension ListWidgetExtension<T> on Iterable<T> {
  /// Separate every element of list by [separator].
  /// Typically used in widgets.
  List<T> separated(T separator) {
    if (isEmpty) return toList();

    final children = <T>[];
    for (var i = 0; i < length; i++) {
      children.add(elementAt(i));

      if (length - i != 1) {
        children.add(separator);
      }
    }

    return children;
  }

  /// Do some action for every element with its index
  void forEachIndexed<R>(R Function(T item, int index) each) {
    for (var i = 0; i < length; i++) {
      each(elementAt(i), i);
    }
  }
}
