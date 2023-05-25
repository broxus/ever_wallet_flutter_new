import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Build number generation', () {
    test('getting new numbers and compare them', () async {
      Future<int> runQuery() async {
        final regex = RegExp('New build number: ([0-9]+)');

        final result = await Process.run(
          'sh',
          [
            'scripts/get-build-number.sh',
          ],
        );
        expect(result.exitCode, 0);
        final number = int.parse(
          regex.firstMatch(result.stdout.toString())?.group(1) ?? '-1',
        );
        expect(number, isPositive);
        return number;
      }

      final first = await runQuery();
      final second = await runQuery();

      expect(second, greaterThan(first));
    });
  });
}
