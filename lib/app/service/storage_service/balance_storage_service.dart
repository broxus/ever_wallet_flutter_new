import 'dart:convert';

import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

const _overallBalancesDomain = 'overallBalancesDomain';
const _balancesDomain = 'balancesDomain';

@singleton
class BalanceStorageService extends AbstractStorageService {
  BalanceStorageService(this._storage);

  /// Storage that is used to store data
  final EncryptedStorage _storage;

  @override
  Future<void> init() => Future.wait([
        _streamedOverallBalance(),
        _streamedBalance(),
      ]);

  @override
  Future<void> clearSensitiveData() => Future.wait([
        deleteOverallBalances(),
      ]);

  /// Subject for overall balances for accounts
  /// key - address of account, value - overall balance in fiat
  final _overallBalancesSubject =
      BehaviorSubject<Map<Address, Fixed>>.seeded({});

  /// Get cached overall balance for accounts
  /// key - address of account, value - overall balance in fiat
  Map<Address, Fixed> get overallBalance => _overallBalancesSubject.value;

  /// Stream that allows tracking overall balance changing
  Stream<Map<Address, Fixed>> get overallBalancesStream =>
      _overallBalancesSubject;

  /// Put overall balances into stream
  Future<void> _streamedOverallBalance() async =>
      _overallBalancesSubject.add(await readOverallBalances());

  /// Get all overall balances for accounts
  /// key - address, value - overall balance
  Future<Map<Address, Fixed>> readOverallBalances() async {
    final encoded = await _storage.getDomain(domain: _overallBalancesDomain);

    return encoded.map(
      (key, value) => MapEntry(
        Address(address: key),
        FixedImprover.fromJson(jsonDecode(value) as Map<String, dynamic>),
      ),
    );
  }

  /// Set overall balance for specified account
  Future<void> setOverallBalance({
    required Address accountAddress,
    required Fixed balance,
  }) async {
    await _storage.set(
      accountAddress.address,
      jsonEncode(balance.toJson()),
      domain: _overallBalancesDomain,
    );
    await _streamedOverallBalance();
  }

  /// Delete overall balances
  Future<void> deleteOverallBalances() async {
    await _storage.clearDomain(_overallBalancesDomain);
  }

  /// Subject for token balances for accounts
  /// key - address of account, value - list of balances for tokens in scope of
  /// this account.
  final _balancesSubject =
      BehaviorSubject<Map<Address, List<AccountBalanceModel>>>.seeded({});

  /// Get cached token balances for accounts
  /// key - address of account, value - list of balances for tokens in scope of
  /// this account.
  Map<Address, List<AccountBalanceModel>> get balances =>
      _balancesSubject.value;

  /// Stream that allows tracking token balances for accounts
  Stream<Map<Address, List<AccountBalanceModel>>> get balancesStream =>
      _balancesSubject;

  /// Put token balances for accounts into stream
  Future<void> _streamedBalance() async =>
      _balancesSubject.add(await readBalances());

  /// Get all token balances for accounts
  /// key - address of account, value - list of balances for tokens in scope of
  /// this account.
  Future<Map<Address, List<AccountBalanceModel>>> readBalances() async {
    final encoded = await _storage.getDomain(domain: _balancesDomain);

    return encoded.map(
      (key, value) {
        final decoded = jsonDecode(value) as List<dynamic>;

        return MapEntry(
          Address(address: key),
          decoded
              .map(
                (e) => AccountBalanceModel.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
        );
      },
    );
  }

  /// Set token balances for accounts with [accountAddress]
  Future<void> setBalances({
    required Address accountAddress,
    required AccountBalanceModel balance,
  }) async {
    var existedForAccount = balances[accountAddress];

    if (existedForAccount == null) {
      existedForAccount = [balance];
    } else {
      existedForAccount
        ..removeWhere((b) => b == balance)
        ..add(balance);
    }

    await _storage.set(
      accountAddress.address,
      jsonEncode(existedForAccount.map((b) => b.toJson()).toList()),
      domain: _balancesDomain,
    );
    await _streamedOverallBalance();
  }

  /// Delete token balances
  Future<void> deleteBalances() async {
    await _storage.clearDomain(_balancesDomain);
  }
}
