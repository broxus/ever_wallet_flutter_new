import 'dart:convert';

import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

const currencyRefreshInterval = Duration(seconds: 60);

/// Refresher that will try to update currencies for current accounts and
/// transport.
class CurrencyRefresher implements RefreshingInterface {
  CurrencyRefresher(
    this.currenciesService,
    this.nekotonRepository,
    this.currentAccountsService,
  );

  final NekotonRepository nekotonRepository;
  final CurrentAccountsService currentAccountsService;
  final CurrenciesService currenciesService;

  @override
  Future<void> refresh() => currenciesService._currencyChangedListener(
        currentAccountsService.currentAccounts?.displayAccounts,
        nekotonRepository.currentTransport,
      );

  @override
  String get refreshDescription => 'CurrencyRefresher';
}

/// Service that allows automatically updating currencies of tokens and native
/// wallets and save it to storage.
@singleton
class CurrenciesService {
  CurrenciesService({
    required this.httpService,
    required this.nekotonRepository,
    required this.currentAccounts,
    required this.storageService,
    required this.appLifecycle,
  });

  static final _logger = Logger('CurrenciesService');

  final HttpService httpService;
  final NekotonRepository nekotonRepository;
  final CurrentAccountsService currentAccounts;
  final GeneralStorageService storageService;
  final AppLifecycleService appLifecycle;

  /// Get stream of currencies from storage for [type] of network.
  Stream<List<CustomCurrency>> currenciesStream(NetworkType type) =>
      storageService.currenciesStream(type);

  /// Get list of currencies from storage for [type] of network.
  List<CustomCurrency> currencies(NetworkType type) =>
      storageService.getCurrencies(type);

  RefreshPollingQueue? _poller;

  /// Init subscriptions for accounts and transport and start polling
  void init() {
    // skip 1 to avoid duplicate calls
    nekotonRepository.currentTransportStream
        .skip(1)
        .listen((_) => startPolling());
    currentAccounts.currentAccountsStream.skip(1).listen((_) => startPolling());

    appLifecycle.appLifecycleStateStream.skip(1).listen((cycle) {
      switch (cycle) {
        case AppLifecycleState.resumed:
          startPolling(refreshImmediately: false);
        case AppLifecycleState.inactive:
        case AppLifecycleState.detached:
        case AppLifecycleState.paused:
          stopPolling();
      }
    });

    startPolling();
  }

  /// Start polling for updating currency
  void startPolling({bool refreshImmediately = true}) {
    _poller?.stopPolling();

    _poller = RefreshPollingQueue(
      refresher: CurrencyRefresher(
        this,
        nekotonRepository,
        currentAccounts,
      ),
      refreshInterval: currencyRefreshInterval,
      stopPollingIfError: false,
    )..startPolling(refreshImmediately: refreshImmediately);
  }

  /// Stop polling for currencies (when app turned into background)
  void stopPolling() {
    _poller?.stopPolling();
  }

  /// Get single currency for [rootTokenContract] in scope of [transport], save
  /// this currency to storage and return.
  Future<CustomCurrency?> getCurrencyForContract(
    TransportStrategy transport,
    Address rootTokenContract,
  ) async {
    try {
      final encoded = await httpService.postRequest(
        endpoint: transport.currencyUrl(rootTokenContract.address),
      );

      final currency = _decodeCurrency(encoded, transport);

      await storageService.saveOrUpdateCurrency(currency: currency);

      return currency;
    } catch (e, st) {
      _logger.severe('getCurrencyForContract', e, st);

      return null;
    }
  }

  /// Update all currencies for [assets] and its token contracts in scope of
  /// [transport]. All currencies will be saved to storage.
  Future<void> _currencyChangedListener(
    List<KeyAccount>? assets,
    TransportStrategy transport,
  ) async {
    if (assets == null) return;

    try {
      final rootTokenContracts = [
        ...{
          transport.nativeTokenAddress,
          ...assets
              .map(
                (e) => e.additionalAssets.values
                    .map((e) => e.tokenWallets)
                    .expand((e) => e),
              )
              .expand((e) => e)
              .map((e) => e.rootTokenContract),
        },
      ];

      for (final rootTokenContract in rootTokenContracts) {
        try {
          final encoded = await httpService.postRequest(
            endpoint: transport.currencyUrl(rootTokenContract.address),
          );
          final currency = _decodeCurrency(encoded, transport);

          await storageService.saveOrUpdateCurrency(currency: currency);
        } catch (_) {
          rethrow;
        }
      }
    } catch (err, st) {
      _logger.severe('_currencyChangedMapper', err, st);
    }
  }

  CustomCurrency _decodeCurrency(String encoded, TransportStrategy transport) {
    final decoded = jsonDecode(encoded) as Map<String, dynamic>;
    decoded['networkType'] = transport.networkType.name;

    return CustomCurrency.fromJson(decoded);
  }
}
