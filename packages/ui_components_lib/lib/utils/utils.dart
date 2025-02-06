import 'package:flutter/widgets.dart';
import 'package:money2/money2.dart';
import 'package:money2_fixer/money2_fixer.dart';

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

String _moneyPattern(int decimal) => '0.${'#' * decimal}';

String _formatThousands(
  String value, {
  String decimalSeparator = '.',
  String groupSeparator = ',',
}) {
  final [integerPart, ...decimalPart] = value.split(decimalSeparator);

  if (integerPart.length <= 3 || decimalPart.length > 1) return value;

  final buffer = StringBuffer();
  for (var i = 0; i < integerPart.length; i++) {
    if (i > 0 && (integerPart.length - i) % 3 == 0) {
      buffer.write(groupSeparator);
    }
    buffer.write(integerPart[i]);
  }

  if (decimalPart.isNotEmpty) {
    buffer
      ..write(decimalSeparator)
      ..write(decimalPart.first);
  }

  return buffer.toString();
}

extension MoneyFormat on Money {
  String defaultFormat() {
    final d = toDouble();

    if (currency.isoCode == 'USD') {
      if (d < 0.00001) {
        return formatImproved(pattern: _moneyPattern(6));
      } else if (d < 0.0001) {
        return formatImproved(pattern: _moneyPattern(5));
      } else if (d < 0.001) {
        return formatImproved(pattern: _moneyPattern(4));
      } else if (d < 0.01) {
        return formatImproved(pattern: _moneyPattern(3));
      }

      return _formatThousands(
        formatImproved(pattern: _moneyPattern(2)),
      );
    }

    if (d < 1) {
      return formatImproved(pattern: _moneyPattern(8));
    } else if (d < 1000) {
      return formatImproved(pattern: _moneyPattern(4));
    }

    return _formatThousands(
      formatImproved(pattern: _moneyPattern(0)),
    );
  }
}

extension DoubleExt on double {
  /// Converts a double value to an integer byte representation.
  ///
  /// The method multiplies the double value by 255.0 and rounds the result
  /// to the nearest integer.
  ///
  /// Returns an integer value between 0 and 255.
  int toByteInt() {
    assert(this >= 0 && this <= 1, 'Value must be between 0 and 1');
    return (255.0 * this).round();
  }
}
