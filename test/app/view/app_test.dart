import 'package:app/app/app.dart';
import 'package:app/feature/counter/counter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const AppPage());
      expect(find.byType(CounterPage), findsOneWidget);
    });
  });
}
