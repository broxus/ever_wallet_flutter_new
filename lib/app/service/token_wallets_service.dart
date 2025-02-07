import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/http/http.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:string_extensions/string_extensions.dart';

const _tokenRootAbiPath = 'assets/abi/TokenRoot.abi.json';
const _tokenWalletAbiPath = 'assets/abi/TokenWallet.abi.json';

typedef SearchStreamValue = List<(TokenContractAsset, Money)>;

@singleton
class TokenWalletsService {
  TokenWalletsService(
    this.nekotonRepository,
    this.httpService,
    this.assetsService,
    this.tokenRepository,
  );

  static final _logger = Logger('TokenWalletService');

  final NekotonRepository nekotonRepository;
  final HttpService httpService;
  final AssetsService assetsService;
  final TokenRepository tokenRepository;

  late final String _tokenRootAbi;
  late final String _tokenWalletAbi;

  bool get canSearch =>
      nekotonRepository.currentTransport.manifestUrl.isNotBlank;

  Stream<bool> get canSearchStream =>
      nekotonRepository.currentTransportStream.map(
        (transport) => transport.manifestUrl.isNotBlank,
      );

  Future<void> init() async {
    final abis = await Future.wait([
      rootBundle.loadString(_tokenRootAbiPath),
      rootBundle.loadString(_tokenWalletAbiPath),
    ]);
    _tokenRootAbi = abis[0];
    _tokenWalletAbi = abis[1];
  }

  /// Search for non-empty token wallets for account address
  Stream<SearchStreamValue> searchTokenWalletsForAddress(
    Address address,
  ) {
    if (!canSearch) return const Stream.empty();

    final subject = ReplaySubject<SearchStreamValue>();
    _searchTokenWalletsForAddress(address: address, subject: subject);
    return subject.stream;
  }

  Future<void> _searchTokenWalletsForAddress({
    required Address address,
    required Subject<SearchStreamValue> subject,
  }) async {
    try {
      final contracts =
          await assetsService.allAvailableContractsForAccount(address).first;

      final success = await _searchWithAPI(
        address: address,
        contracts: contracts.$1,
        subject: subject,
      );

      if (!success) {
        if (nekotonRepository.currentTransport.networkName == 'TON') {
          await _searchWithService(
            contracts.$1,
            address,
            subject,
          );
        } else {
          await _searchWithBlockchain(
            address: address,
            contracts: contracts.$1,
            subject: subject,
          );
        }
      }
    } finally {
      await subject.close();
    }
  }

  Future<void> _searchWithService(
    List<TokenContractAsset> assets,
    Address root,
    Subject<SearchStreamValue> subject,
  ) async {
    for (final asset in assets) {
      try {
        final wallet = await subscribeToken(asset.address, root);

        if (wallet.wallet?.moneyBalance != null &&
            wallet.wallet?.moneyBalance.amount != Fixed.zero) {
          subject.add([(asset, wallet.wallet!.moneyBalance)]);
        }
      } finally {
        unsubscribeToken(asset.address, root);
      }
    }
  }

  Future<bool> _searchWithAPI({
    required Address address,
    required Subject<SearchStreamValue> subject,
    required List<TokenContractAsset> contracts,
  }) async {
    if (nekotonRepository.currentTransport.tokenApiBaseUrl == null) {
      return false;
    }

    try {
      final balances = await tokenRepository.getBalances(
        address: address,
        rootAddresses: contracts.map((item) => item.address).toList(),
      );

      final values = balances
          .map((item) {
            final amount = Fixed.parse(item.amount);
            final contract = contracts.firstWhereOrNull(
              (contract) => contract.address == item.rootAddress,
            );

            if (contract == null || amount.isZero) return null;

            final balance = Money.fromFixedWithCurrency(
              amount,
              _getCurrency(contract),
            );

            return (contract, balance);
          })
          .nonNulls
          .toList();

      subject.add(values);
    } catch (e, st) {
      _logger.severe('_searchWithAPI', e, st);
      return false;
    }

    return true;
  }

  Future<void> _searchWithBlockchain({
    required Address address,
    required Subject<SearchStreamValue> subject,
    required List<TokenContractAsset> contracts,
  }) async {
    for (final contract in contracts) {
      Money? balance;

      try {
        final walletAddress = await _getWalletOf(
          address: contract.address,
          walletOwner: address.toString(),
        );

        if (walletAddress == null) continue;

        final value = await _getBalance(
          address: Address(address: walletAddress),
        );

        if (value == null) continue;

        balance = Money.fromBigIntWithCurrency(
          BigInt.parse(value),
          _getCurrency(contract),
        );
      } catch (e, st) {
        _logger.warning('_searchWithBlockchain', e, st);
      }

      if (balance != null && !balance.isZero) {
        subject.add([(contract, balance)]);
      }
    }
  }

  Future<TokenWalletState> subscribeToken(
    Address address,
    Address rootTokenContract,
  ) {
    return nekotonRepository.subscribeToken(
      owner: rootTokenContract,
      rootTokenContract: address,
    );
  }

  void unsubscribeToken(Address address, Address rootTokenContract) {
    nekotonRepository.unsubscribeToken(
      rootTokenContract,
      address,
    );
  }

  Currency _getCurrency(TokenContractAsset contract) => Currency.create(
        contract.symbol,
        contract.decimals,
        symbol: contract.symbol,
        pattern: contract.decimals > 0 ? '0.${'#' * contract.decimals}' : '0',
      );

  Future<String?> _getWalletOf({
    required Address address,
    required String walletOwner,
  }) async {
    final state = await nekotonRepository.currentTransport.transport
        .getFullContractState(address);

    if (state == null) return null;

    final walletOf = await runLocal(
      accountStuffBoc: state.boc,
      contractAbi: _tokenRootAbi,
      method: 'walletOf',
      input: {'answerId': 0, 'walletOwner': walletOwner},
      responsible: true,
    );

    return walletOf.output?['value0'].toString();
  }

  Future<String?> _getBalance({
    required Address address,
  }) async {
    final state = await nekotonRepository.currentTransport.transport
        .getFullContractState(address);

    if (state == null) return null;

    final balance = await runLocal(
      accountStuffBoc: state.boc,
      contractAbi: _tokenWalletAbi,
      method: 'balance',
      input: {'answerId': 0},
      responsible: true,
    );

    return balance.output?['value0'].toString();
  }
}
