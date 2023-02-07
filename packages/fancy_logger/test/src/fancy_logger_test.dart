// ignore_for_file: prefer_const_constructors

import 'package:fancy_logger/fancy_logger.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FancyLogger', () {
    test('can be instantiated', () {
      expect(FancyLogger(), isNotNull);
    });
  });
}
