import 'package:flutter/widgets.dart';

extension StringUtils on String {
  /// For [TextOverflow.ellipsis] for better displaying with ellipsis
  ///
  /// \u{200B} adds an unbreakable gap
  /// {issue for this https://github.com/flutter/flutter/issues/18761}
  String get overflow =>
      characters.replaceAll(Characters(''), Characters('\u{200B}')).string;
}
