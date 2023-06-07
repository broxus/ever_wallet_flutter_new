import 'package:flutter/widgets.dart';

extension StringUtils on String {
  /// For [TextOverflow.ellipsis] for better displaying with ellipsis
  ///
  /// \u{200B} adds an unbreakable gap
  /// {issue for this https://github.com/flutter/flutter/issues/18761}
  String get overflow =>
      characters.replaceAll(Characters(''), Characters('\u{200B}')).string;
}

extension ListExtension<T> on Iterable<T> {
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
}
