import 'package:app/data/models/contract_updates_subscription.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ContractUpdatesSubscription', () {
    test('empty', () {
      const c = ContractUpdatesSubscription();
      expect(c.state, isNull);
      expect(c.transactions, isNull);
      expect(c.toJson(), isEmpty);
    });

    test('with state', () {
      const c = ContractUpdatesSubscription(state: true);
      expect(c.state, true);
      expect(c.transactions, isNull);
      expect(c.toJson(), {'state': true});
    });

    test('with transactions', () {
      const c = ContractUpdatesSubscription(transactions: false);
      expect(c.state, isNull);
      expect(c.transactions, false);
      expect(c.toJson(), {'transactions': false});
    });

    test('with state and transactions', () {
      const c = ContractUpdatesSubscription(state: false, transactions: true);
      expect(c.state, false);
      expect(c.transactions, true);
      expect(c.toJson(), {'state': false, 'transactions': true});
    });
  });
}
