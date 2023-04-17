import 'dart:async';

import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:tuple/tuple.dart';

typedef TokenWalletOnBalanceChanged = void Function(BigInt event);
typedef TokenWalletOnTransactionsFound = void Function(
  Tuple2<List<TransactionWithData<TokenWalletTransaction?>>,
          TransactionsBatchInfo>
      event,
);

class TokenWalletSubscription {
  TokenWalletSubscription._(this.tokenWallet);

  final TokenWallet tokenWallet;
  late final StreamSubscription<BigInt> _onBalanceChangedStreamSubscription;
  late final StreamSubscription<
      Tuple2<List<TransactionWithData<TokenWalletTransaction?>>,
          TransactionsBatchInfo>> _onTransactionsFoundStreamSubscription;

  static Future<TokenWalletSubscription> subscribe({
    required TokenWallet tokenWallet,
    required TokenWalletOnBalanceChanged onBalanceChanged,
    required TokenWalletOnTransactionsFound onTransactionsFound,
  }) async {
    final instance = TokenWalletSubscription._(tokenWallet);
    await instance._initialize(
      onBalanceChanged: onBalanceChanged,
      onTransactionsFound: onTransactionsFound,
    );
    return instance;
  }

  Future<void> dispose() async {
    tokenWallet.dispose();
    await _onBalanceChangedStreamSubscription.cancel();
    await _onTransactionsFoundStreamSubscription.cancel();
  }

  Future<void> _initialize({
    required TokenWalletOnBalanceChanged onBalanceChanged,
    required TokenWalletOnTransactionsFound onTransactionsFound,
  }) async {
    _onBalanceChangedStreamSubscription =
        tokenWallet.onBalanceChangedStream.listen(onBalanceChanged);
    _onTransactionsFoundStreamSubscription =
        tokenWallet.onTransactionsFoundStream.listen(onTransactionsFound);
  }
}
