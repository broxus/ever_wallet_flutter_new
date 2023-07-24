import 'package:app/app/service/service.dart';
import 'package:app/data/models/custom_currency.dart';
import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

/// Service that provides a single point for loading balances for accounts.
@singleton
class BalanceService {
  BalanceService(
    this.nekotonRepository,
    this.currenciesService,
  );

  static final _logger = Logger('BalanceService');

  final NekotonRepository nekotonRepository;
  final CurrenciesService currenciesService;

  /// Calculate balance in fiat currency for TonWallet, specified by [address],
  /// and all existed TokenWallets for this [address]. This is quite complicated
  /// logic and uses already created subscriptions for Ton/TokenWallets.
  ///
  /// If you need to get amount without subscriptions, use [getKeyBalance] or
  /// [getAccountBalance].
  // ignore: long-method
  Stream<Fixed> accountOverallBalance(Address address) {
    return Rx.combineLatest3<TonWallet?, TransportStrategy, KeyAccount?,
        (TonWallet?, TransportStrategy, KeyAccount?)>(
      // subscribe for wallet appearing, because it can happens later
      nekotonRepository.walletsStream
          .map((list) => list.firstWhereOrNull((w) => w.address == address)),
      nekotonRepository.currentTransportStream,
      nekotonRepository.seedListStream
          .map((list) => list.findAccountByAddress(address)),
      (a, b, c) => (a, b, c),
    ).flatMap<Fixed>((value) {
      final wallet = value.$1;
      final transport = value.$2;
      final account = value.$3;

      // _logger.finest('');

      if (wallet == null || account == null) return Stream.value(Fixed.zero);

      /// Balance for native wallet, concatenate changing of balance
      /// of wallet and currency updating.
      final tonWalletBalanceStream =
          Rx.combineLatest2<BigInt, CustomCurrency?, Fixed>(
        wallet.fieldUpdatesStream
            .map((_) => wallet.contractState.balance)
            .startWith(wallet.contractState.balance),
        currenciesService.currenciesStream(transport.networkType).map(
              (curs) => curs.firstWhereOrNull(
                (cur) => cur.address == transport.nativeTokenAddress,
              ),
            ),
        (a, b) => b != null
            ? Fixed.fromBigInt(
                  a,
                  scale: transport.defaultNativeCurrencyDecimal,
                ) *
                Fixed.parse(b.price)
            : Fixed.zero,
      );

      final tokenWallets = account
              .additionalAssets[transport.transport.group]?.tokenWallets
              .map((e) => e.rootTokenContract)
              .toList() ??
          [];

      /// Balance for token wallets, concatenate changing of money
      /// of wallet and currency for every token.
      final tokenWalletsBalances = tokenWallets.map<Stream<Fixed>>(
        (contract) =>
            // subscribe for wallet appearing, because it can happens later
            nekotonRepository.tokenWalletsStream
                .map(
          (list) => list.firstWhereOrNull(
            (w) => w.address == contract && w.owner == address,
          ),
        )
                .flatMap(
          (wallet) {
            if (wallet == null) return Stream.value(Fixed.zero);

            return Rx.combineLatest2<Money?, CustomCurrency?, Fixed>(
              wallet.onMoneyBalanceChangedStream.startWith(wallet.moneyBalance),
              currenciesService.currenciesStream(transport.networkType).map(
                    (curs) => curs.firstWhereOrNull(
                      (cur) => cur.address == contract,
                    ),
                  ),
              (a, b) => b != null && a != null
                  ? a.amount * Fixed.parse(b.price)
                  : Fixed.zero,
            );
          },
        ),
      );

      /// Summarize all possible balances for native and token wallets
      return Rx.combineLatestList(
        [tonWalletBalanceStream, ...tokenWalletsBalances],
      ).map(
        (e) => e.fold(Fixed.zero, (previous, element) => previous + element),
      );
    }).onErrorReturnWith((e, st) {
      _logger.severe('accountOverallBalance', e, st);

      return Fixed.zero;
    });
  }

  /// Returns stream which emits balance of TonWallet with [address] in fiat
  /// currency.
  /// To listen for this stream, subscription for TonWallet must be created
  /// in [NekotonRepository].
  /// To listen TokenWallet, use [tokenWalletBalanceStream].
  Stream<Fixed> tonWalletBalanceStream(Address address) {
    return Rx.combineLatest2<TonWallet?, TransportStrategy,
        (TonWallet?, TransportStrategy)>(
      // subscribe for wallet appearing, because it can happens later
      nekotonRepository.walletsStream
          .map((list) => list.firstWhereOrNull((w) => w.address == address)),
      nekotonRepository.currentTransportStream, (a, b) => (a, b),
    ).flatMap((value) {
      final wallet = value.$1;
      final transport = value.$2;

      if (wallet == null) return Stream.value(Fixed.zero);

      return Rx.combineLatest2<BigInt, CustomCurrency?, Fixed>(
        wallet.fieldUpdatesStream
            .map((_) => wallet.contractState.balance)
            .startWith(wallet.contractState.balance),
        currenciesService.currenciesStream(transport.networkType).map(
              (curs) => curs.firstWhereOrNull(
                (cur) => cur.address == transport.nativeTokenAddress,
              ),
            ),
        (a, b) => b != null
            ? Fixed.fromBigInt(
                  a,
                  scale: transport.defaultNativeCurrencyDecimal,
                ) *
                Fixed.parse(b.price)
            : Fixed.zero,
      );
    }).onErrorReturnWith((e, st) {
      _logger.severe('tonWalletBalanceStream', e, st);

      return Fixed.zero;
    });
  }

  /// Returns stream which emits balance of TokenWallet with [owner] and
  /// [rootTokenContract] in fiat currency.
  /// To listen for this stream, subscription for TokenWallet must be created
  /// in [NekotonRepository].
  /// To listen TonWallet, use [tonWalletBalanceStream].
  Stream<Fixed> tokenWalletBalanceStream({
    required Address owner,
    required Address rootTokenContract,
  }) {
    return Rx.combineLatest2<TokenWallet?, TransportStrategy,
        (TokenWallet?, TransportStrategy)>(
      // subscribe for wallet appearing, because it can happens later
      nekotonRepository.tokenWalletsStream.map(
        (list) => list.firstWhereOrNull(
          (w) => w.address == rootTokenContract && w.owner == owner,
        ),
      ),
      nekotonRepository.currentTransportStream,
      (a, b) => (a, b),
    ).flatMap((value) {
      final wallet = value.$1;
      final transport = value.$2;

      if (wallet == null) return Stream.value(Fixed.zero);

      return Rx.combineLatest2<Money?, CustomCurrency?, Fixed>(
        wallet.onMoneyBalanceChangedStream.startWith(wallet.moneyBalance),
        currenciesService.currenciesStream(transport.networkType).map(
              (curs) => curs.firstWhereOrNull(
                (cur) => cur.address == rootTokenContract,
              ),
            ),
        (a, b) => b != null && a != null
            ? a.amount * Fixed.parse(b.price)
            : Fixed.zero,
      );
    }).onErrorReturnWith((e, st) {
      _logger.severe('tokenWalletBalanceStream', e, st);

      return Fixed.zero;
    });
  }

  /// Get balance of public key and all related Ton/Token wallets of it without
  /// creating subscriptions.
  // TODO(alex-a4): implement later
  Future<Fixed> getKeyBalance(PublicKey _) async {
    return Fixed.zero;
  }

  /// Get balance of account and all tokens of wallet without
  /// creating subscriptions.
  // TODO(alex-a4): implement later
  Future<Fixed> getAccountBalance(KeyAccount _) async {
    return Fixed.zero;
  }
}
