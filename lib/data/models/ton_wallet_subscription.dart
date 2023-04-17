import 'dart:async';

import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:tuple/tuple.dart';

typedef TonWalletOnMessageSent = void Function(
  Tuple2<PendingTransaction, Transaction?> event,
);
typedef TonWalletOnMessageExpired = void Function(PendingTransaction event);
typedef TonWalletOnStateChanged = void Function(ContractState event);
typedef TonWalletOnTransactionsFound = void Function(
  Tuple2<List<TransactionWithData<TransactionAdditionalInfo?>>,
          TransactionsBatchInfo>
      event,
);

class TonWalletSubscription {
  TonWalletSubscription.subscribe({
    required this.tonWallet,
    required TonWalletOnMessageSent onMessageSent,
    required TonWalletOnMessageExpired onMessageExpired,
    required TonWalletOnStateChanged onStateChanged,
    required TonWalletOnTransactionsFound onTransactionsFound,
  }) {
    _initialize(
      onMessageSent: onMessageSent,
      onMessageExpired: onMessageExpired,
      onStateChanged: onStateChanged,
      onTransactionsFound: onTransactionsFound,
    );
  }

  final TonWallet tonWallet;
  late final StreamSubscription<Tuple2<PendingTransaction, Transaction?>>
      _onMessageSentStreamSubscription;
  late final StreamSubscription<PendingTransaction>
      _onMessageExpiredStreamSubscription;
  late final StreamSubscription<ContractState>
      _onStateChangedStreamSubscription;
  late final StreamSubscription<
      Tuple2<List<TransactionWithData<TransactionAdditionalInfo?>>,
          TransactionsBatchInfo>> _onTransactionsFoundStreamSubscription;

  Future<void> dispose() async {
    tonWallet.dispose();
    await _onMessageSentStreamSubscription.cancel();
    await _onMessageExpiredStreamSubscription.cancel();
    await _onStateChangedStreamSubscription.cancel();
    await _onTransactionsFoundStreamSubscription.cancel();
  }

  void _initialize({
    required TonWalletOnMessageSent onMessageSent,
    required TonWalletOnMessageExpired onMessageExpired,
    required TonWalletOnStateChanged onStateChanged,
    required TonWalletOnTransactionsFound onTransactionsFound,
  }) {
    _onMessageSentStreamSubscription =
        tonWallet.onMessageSentStream.listen(onMessageSent);
    _onMessageExpiredStreamSubscription =
        tonWallet.onMessageExpiredStream.listen(onMessageExpired);
    _onStateChangedStreamSubscription =
        tonWallet.onStateChangedStream.listen(onStateChanged);
    _onTransactionsFoundStreamSubscription =
        tonWallet.onTransactionsFoundStream.listen(onTransactionsFound);
  }
}
