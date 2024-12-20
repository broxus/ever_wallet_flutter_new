import 'package:app/app/service/connection/network_type.dart';
import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

const _overallBalancesDomain = 'overallBalancesDomain';
const _balancesDomain = 'balancesDomain';

typedef ByNetwork<T> = Map<NetworkType, T>;

@singleton
class BalanceStorageService extends AbstractStorageService {
  BalanceStorageService(
    @Named(overallBalancesContainer) this._overallBalancesStorage,
    @Named(balancesContainer) this._balancesStorage,
  );

  static final _logger = Logger('BalanceStorageService');
  static const overallBalancesContainer = _overallBalancesDomain;
  static const balancesContainer = _balancesDomain;
  static const containers = [
    overallBalancesContainer,
    balancesContainer,
  ];

  /// Storage that is used to store data
  final GetStorage _overallBalancesStorage;
  final GetStorage _balancesStorage;

  @override
  Future<void> init() async {
    await Future.wait(containers.map(GetStorage.init));
    _streamedOverallBalance();
    _streamedBalance();
  }

  @override
  Future<void> clearSensitiveData() => Future.wait([
        deleteOverallBalances(),
        deleteBalances(),
      ]);

  /// Subject for overall balances for accounts
  /// key - address of account, value - overall balance in fiat
  final _overallBalancesSubject =
      BehaviorSubject<ByNetwork<Map<Address, Fixed>>>.seeded({});

  /// Get cached overall balance for accounts
  /// key - address of account, value - overall balance in fiat
  Map<Address, Fixed> getOverallBalance(NetworkType network) =>
      _overallBalancesSubject.value[network] ?? {};

  /// Stream that allows tracking overall balance changing
  Stream<Map<Address, Fixed>> getOverallBalancesStream(NetworkType network) =>
      _overallBalancesSubject.map((event) => event[network] ?? {});

  /// Put overall balances into stream
  void _streamedOverallBalance() =>
      _overallBalancesSubject.add(readOverallBalances());

  /// Get all overall balances for accounts
  /// key - address, value - overall balance
  ByNetwork<Map<Address, Fixed>> readOverallBalances() {
    final encoded = _overallBalancesStorage.getEntries();

    return encoded.entries
        .map(
          (entry) => (
            _Key.fromString(entry.key),
            FixedFixer.fromJson(entry.value as Map<String, dynamic>),
          ),
        )
        .groupFoldBy<NetworkType, Map<Address, Fixed>>(
          (item) => item.$1.network,
          (prev, item) => (prev ?? {})..set(item.$1.address, item.$2),
        );
  }

  /// Set overall balance for specified account
  void setOverallBalance({
    required NetworkType network,
    required Address accountAddress,
    required Fixed balance,
  }) {
    try {
      _overallBalancesStorage.write(
        _Key(network: network, address: accountAddress).toString(),
        balance.toJson(),
      );
      _streamedOverallBalance();
    } catch (e, t) {
      _logger.severe('setOverallBalance', e, t);
    }
  }

  /// Delete overall balances
  Future<void> deleteOverallBalances() async {
    await _overallBalancesStorage.erase();
  }

  /// Subject for token balances for accounts
  /// key - address of account, value - list of balances for tokens in scope of
  /// this account.
  final _balancesSubject = BehaviorSubject<
      ByNetwork<Map<Address, List<AccountBalanceModel>>>>.seeded({});

  /// Get cached token balances for accounts
  /// key - address of account, value - list of balances for tokens in scope of
  /// this account.
  Map<Address, List<AccountBalanceModel>> getBalances(NetworkType network) =>
      _balancesSubject.value[network] ?? {};

  /// Stream that allows tracking token balances for accounts
  Stream<Map<Address, List<AccountBalanceModel>>> getBalancesStream(
      NetworkType network,
  ) =>
      _balancesSubject.map((event) => event[network] ?? {});

  /// Put token balances for accounts into stream
  void _streamedBalance() => _balancesSubject.add(readBalances());

  /// Get all token balances for accounts
  /// key - address of account, value - list of balances for tokens in scope of
  /// this account.
  ByNetwork<Map<Address, List<AccountBalanceModel>>> readBalances() {
    final encoded = _balancesStorage.getEntries();

    return encoded.entries
        .map(
          (entry) => (
            _Key.fromString(entry.key),
            (entry.value as List<dynamic>)
                .map(
                  (e) => AccountBalanceModel.fromJson(
                    e as Map<String, dynamic>,
                  ),
                )
                .toList(),
          ),
        )
        .groupFoldBy<NetworkType, Map<Address, List<AccountBalanceModel>>>(
          (item) => item.$1.network,
          (prev, item) => (prev ?? {})..set(item.$1.address, item.$2),
        );
  }

  /// Set token balances for accounts with [accountAddress]
  void setBalances({
    required NetworkType network,
    required Address accountAddress,
    required AccountBalanceModel balance,
  }) {
    try {
      var existedForAccount = getBalances(network)[accountAddress];

      if (existedForAccount == null) {
        existedForAccount = [balance];
      } else {
        existedForAccount
          ..removeWhere(
            (b) =>
                b.rootTokenContract == balance.rootTokenContract &&
                b.isNative == balance.isNative,
          )
          ..add(balance);
      }

      _balancesStorage.write(
        _Key(network: network, address: accountAddress).toString(),
        existedForAccount.map((b) => b.toJson()).toList(),
      );
      _streamedBalance();
    } catch (e, t) {
      _logger.severe('setBalances', e, t);
    }
  }

  /// Delete token balances
  Future<void> deleteBalances() async {
    await _balancesStorage.erase();
  }
}

@immutable
class _Key {
  const _Key({
    required this.network,
    required this.address,
  });

  factory _Key.fromString(String value) {
    final parts = value.split('::');

    assert(parts.length == 2, 'Invalid key format: $value');

    return _Key(
      network: parts[0],
      address: Address(address: parts[1]),
    );
  }

  final NetworkType network;
  final Address address;

  @override
  String toString() => '$network::${address.address}';

  @override
  int get hashCode => Object.hash(runtimeType, network, address);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _Key &&
          runtimeType == other.runtimeType &&
          network == other.network &&
          address == other.address;
}
