import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/utils/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

const _overallBalancesDomain = 'overallBalancesDomain';
const _balancesDomain = 'balancesDomain';

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
      BehaviorSubject<Map<Address, Fixed>>.seeded({});

  /// Get cached overall balance for accounts
  /// key - address of account, value - overall balance in fiat
  Map<Address, Fixed> get overallBalance => _overallBalancesSubject.value;

  /// Stream that allows tracking overall balance changing
  Stream<Map<Address, Fixed>> get overallBalancesStream =>
      _overallBalancesSubject;

  /// Put overall balances into stream
  void _streamedOverallBalance() =>
      _overallBalancesSubject.add(readOverallBalances());

  /// Get all overall balances for accounts
  /// key - address, value - overall balance
  Map<Address, Fixed> readOverallBalances() {
    final encoded = _overallBalancesStorage.getEntries();

    return encoded.map(
      (key, value) => MapEntry(
        Address(address: key),
        FixedFixer.fromJson(value as Map<String, dynamic>),
      ),
    );
  }

  /// Set overall balance for specified account
  void setOverallBalance({
    required Address accountAddress,
    required Fixed balance,
  }) {
    try {
      _overallBalancesStorage.write(
        accountAddress.address,
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
  void _streamedBalance() => _balancesSubject.add(readBalances());

  /// Get all token balances for accounts
  /// key - address of account, value - list of balances for tokens in scope of
  /// this account.
  Map<Address, List<AccountBalanceModel>> readBalances() {
    final encoded = _balancesStorage.getEntries();

    return encoded.map(
      (key, value) {
        return MapEntry(
          Address(address: key),
          (value as List<dynamic>)
              .map(
                (e) => AccountBalanceModel.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
        );
      },
    );
  }

  /// Set token balances for accounts with [accountAddress]
  void setBalances({
    required Address accountAddress,
    required AccountBalanceModel balance,
  }) {
    try {
      var existedForAccount = balances[accountAddress];

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
        accountAddress.address,
        existedForAccount.map((b) => b.toJson()).toList(),
      );
      _streamedOverallBalance();
    } catch (e, t) {
      _logger.severe('setBalances', e, t);
    }
  }

  /// Delete token balances
  Future<void> deleteBalances() async {
    await _balancesStorage.erase();
  }
}
