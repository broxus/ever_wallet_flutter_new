import 'package:app/feature/counter/counter.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

class MockCounterCubit extends MockCubit<int> implements CounterCubit {}

void main() {
  group('CounterPage', () {
    testWidgets('renders CounterView', (tester) async {
      await tester.pumpApp(const CounterPage());
      expect(find.byType(CounterView), findsOneWidget);
    });
  });
}
