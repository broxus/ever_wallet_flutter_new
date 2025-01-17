import 'dart:async';
import 'dart:convert';

import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

/// Paths to load stever abi
const _stEverVaultAbiPath = 'assets/abi/StEverVault.abi.min.json';
const _stEverAccountAbiPath = 'assets/abi/StEverAccount.abi.min.json';
const _stEverVaultNewAbiPath = 'assets/abi/StEverVaultNew.abi.json';
const _stEverAccountNewAbiPath = 'assets/abi/StEverAccountNew.abi.json';

@singleton
class StakingService {
  StakingService(
    this.nekotonRepository,
    this.httpService,
  );

  final NekotonRepository nekotonRepository;
  final HttpService httpService;

  FullContractState? _vaultStateCache;

  /// Initialize service loading abi from files
  Future<void> init() async {
    _stEverVaultAbi = await _abiLoader(_stEverVaultAbiPath);
    _stEverAccountAbi = await _abiLoader(_stEverAccountAbiPath);
    _stEverVaultNewAbi = await _abiLoader(_stEverVaultNewAbiPath);
    _stEverAccountNewAbi = await _abiLoader(_stEverAccountNewAbiPath);
  }

  /// Json strings of contract abi that sends in requests
  late final String _stEverVaultAbi;
  late final String _stEverAccountAbi;
  late final String _stEverVaultNewAbi;
  late final String _stEverAccountNewAbi;

  /// Withdraw request that was cancelled and mustn't be displayed when
  /// [userAvailableWithdraw] returns uncompleted list of blockchain messages.
  final _cancelledWithdraw = <String>[];

  /// key - address of TonWallet that was lisneted to get information about
  /// withdraws
  /// value - list of withdraw requests for this account
  final _withdrawSubject =
      BehaviorSubject<Map<Address, List<StEverWithdrawRequest>>>.seeded({});

  String get stEverVaultAbi =>
      nekotonRepository.currentTransport.networkType == 'ever'
          ? _stEverVaultAbi
          : _stEverVaultNewAbi;

  String get stEverAccountAbi =>
      nekotonRepository.currentTransport.networkType == 'ever'
          ? _stEverAccountAbi
          : _stEverAccountNewAbi;

  /// Get all possible withdraw requests for [accountAddress].
  /// To update withdraws, call [tryUpdateWithdraws].
  Stream<List<StEverWithdrawRequest>> withdrawRequestsStream(
    Address accountAddress,
  ) =>
      _withdrawSubject.stream
          .map((withdraws) => withdraws[accountAddress] ?? []);

  /// This method must be called from AccountCard manually every time when
  /// [TonWallet.fieldUpdatesStream] emits new data.
  Future<void> tryUpdateWithdraws(Address accountAddress) async {
    try {
      final withdraws = await userAvailableWithdraw(accountAddress);
      final existed = _withdrawSubject.value;
      existed[accountAddress] = withdraws;
      _withdrawSubject.add(existed);
    } catch (_) {
      // ignore error
    }
  }

  /// If we are calling any method of staking, then current transport has this
  /// data.
  StakingInformation get stakingInformation =>
      nekotonRepository.currentTransport.stakeInformation!;

  /// Returns body/comment for TonWalletSendPage, all other fields should be
  /// put manually.
  Future<String> depositEverBodyPayload(BigInt depositAmount) {
    final payload = FunctionCall(
      method: 'deposit',
      abi: stEverVaultAbi,
      params: {
        '_nonce': NtpTime.now().millisecondsSinceEpoch,
        '_amount': depositAmount.toString(),
      },
    );

    return encodeInternalInput(
      contractAbi: payload.abi,
      method: payload.method,
      input: payload.params,
    );
  }

  /// Returns body/comment to unstake stever via TokenWalletSendPage
  Future<String> withdrawStEverPayload() async {
    final contract = await getVaultContractState();
    final result = await runLocal(
      accountStuffBoc: contract.boc,
      contractAbi: stEverVaultAbi,
      method: 'encodeDepositPayload',
      input: {
        '_nonce': NtpTime.now().millisecondsSinceEpoch,
      },
      responsible: false,
    );

    return result.output?['depositPayload'] as String? ?? '';
  }

  /// Cancel withdraw request.
  /// Returns body/comment that should be handled via TonWalletSendPage
  Future<String> removeWithdrawPayload(String nonce) {
    final payload = FunctionCall(
      method: 'removePendingWithdraw',
      abi: stEverVaultAbi,
      params: {
        '_nonce': nonce,
      },
    );

    return encodeInternalInput(
      contractAbi: payload.abi,
      method: payload.method,
      input: payload.params,
    );
  }

  /// Returns unstake requests that in progress
  Future<List<StEverWithdrawRequest>> userAvailableWithdraw(
    Address accountAddress,
  ) async {
    final vaultState = await getVaultContractState();
    final result = await runLocal(
      accountStuffBoc: vaultState.boc,
      contractAbi: stEverVaultAbi,
      method: 'getAccountAddress',
      input: {'answerId': 0, '_user': accountAddress.address},
      responsible: true,
    );
    final address = result.output?.values.firstOrNull as String?;
    if (address == null) return [];

    try {
      // This method can drop exception if there were no any transactions with
      // stever and we ignore it
      final userState = await getUserContractState(Address(address: address));
      final requestsResult = await runLocal(
        accountStuffBoc: userState.boc,
        contractAbi: stEverAccountAbi,
        method: 'withdrawRequests',
        input: {},
        responsible: false,
      );
      final items = (requestsResult.output?['withdrawRequests'] as List? ?? [])
          .cast<List<dynamic>>();

      return items
          // ignore cancelled withdraws
          .where((e) => !_cancelledWithdraw.contains(e[0] as String))
          .map(
            (e) => StEverWithdrawRequest(
              accountAddress: accountAddress,
              nonce: e[0] as String,
              data: StEverWithdrawRequestData.fromJson(
                e[1] as Map<String, dynamic>,
              ),
            ),
          )
          .sortedBy((e) => e.data.timestamp)
          .reversed
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// How many stevers receive for evers
  Future<BigInt> getDepositStEverAmount(BigInt evers) async {
    final contractState = await getVaultContractState();
    final result = await runLocal(
      accountStuffBoc: contractState.boc,
      contractAbi: stEverVaultAbi,
      method: 'getDepositStEverAmount',
      input: {'_amount': evers.toString()},
      responsible: false,
    );
    final amount = result.output?.values.firstOrNull as String?;

    return BigInt.parse(amount ?? '0');
  }

  /// How many evers receive for stevers
  Future<BigInt> getWithdrawEverAmount(BigInt stEvers) async {
    final contractState = await getVaultContractState();
    final result = await runLocal(
      accountStuffBoc: contractState.boc,
      contractAbi: stEverVaultAbi,
      method: 'getWithdrawEverAmount',
      input: {'_amount': stEvers.toString()},
      responsible: false,
    );
    final amount = result.output?.values.firstOrNull as String?;

    return BigInt.parse(amount ?? '0');
  }

  /// Information about current staking state in blockchain
  Future<StEverDetails> getStEverDetails() async {
    final contractState = await getVaultContractState();
    final result = await runLocal(
      accountStuffBoc: contractState.boc,
      contractAbi: stEverVaultAbi,
      method: 'getDetails',
      input: {'answerId': 0},
      responsible: true,
    );
    final detailsJson =
        result.output?.values.firstOrNull as Map<String, dynamic>?;
    if (detailsJson == null) throw Exception('StEver details not provided');

    return StEverDetails.fromJson(detailsJson);
  }

  /// Get contract state for staking valut, can be used to call [runLocal]
  /// methods with this contract.
  Future<FullContractState> getVaultContractState() async {
    _vaultStateCache ??= await nekotonRepository.currentTransport.transport
        .getFullContractState(stakingInformation.stakingValutAddress);

    if (_vaultStateCache == null) {
      throw Exception('StEver contract state not provided');
    }

    return _vaultStateCache!;
  }

  /// Get contract state for user staking, that can be used to call [runLocal]
  /// methods to get information about user staking.
  Future<FullContractState> getUserContractState(
    Address accountVault,
  ) async {
    final contractState = await nekotonRepository.currentTransport.transport
        .getFullContractState(accountVault);
    if (contractState == null) {
      throw Exception('User StEver contract state not provided');
    }

    return contractState;
  }

  /// Remember cancelled withdraw request and don't show it in
  /// [userAvailableWithdraw]
  void acceptCancelledWithdraw(StEverWithdrawRequest request) {
    _cancelledWithdraw.add(request.nonce);
    tryUpdateWithdraws(request.accountAddress);
  }

  /// Load average apy from stever website.
  /// This returns value from 0 to 100.
  Future<double> getAverageAPYPercent() async {
    final encoded = await httpService.getTransportData(
      stakingInformation.stakingAPYLink.toString(),
    );
    final decoded = jsonDecode(encoded) as Map<String, dynamic>;

    // ignore: avoid_dynamic_calls, no-magic-number
    return double.parse(decoded['data']?['apy'] as String? ?? '0.0') * 100;
  }

  void resetCache() => _vaultStateCache = null;

  Future<String> _abiLoader(String path) => rootBundle.loadString(path);
}
