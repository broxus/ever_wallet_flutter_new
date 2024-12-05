import 'dart:convert';

import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

/// Service that allows loading and updating list of contracts for transport.
/// This service also provides ability to load information about custom
/// contracts that user can add via [KeyAccount.addTokenWallet].
@singleton
class AssetsService {
  AssetsService(
    this.nekotonRepository,
    this.httpService,
    this.storage,
  );

  static final _logger = Logger('AssetsService');

  final NekotonRepository nekotonRepository;
  final HttpService httpService;
  final GeneralStorageService storage;

  /// Start listening for transport changes and update contracts from manifest
  void init() {
    nekotonRepository.currentTransportStream.listen(_updateSystemContracts);

    nekotonRepository.currentTransportStream.flatMap((transport) {
      return Rx.combineLatest2<List<TokenContractAsset>,
          List<TokenContractAsset>, void>(
        storage.systemTokenContractAssetsStream(transport.networkType),
        storage.customTokenContractAssetsStream(transport.networkType),
        _contractsUpdateListener,
      );
      // listen needs to enable stream api
      // ignore: no-empty-block
    }).listen((_) {});
  }

  /// Get list of contracts (custom and system) that is available for current
  /// active transport.
  /// This is a list of contracts from storage and it can be updated via
  /// [_contractsUpdateListener] and [_updateSystemContracts] or by calling
  /// [contractsForAccount] where new contract will be detected.
  Stream<List<TokenContractAsset>> get contractsStream =>
      nekotonRepository.currentTransportStream.flatMap(
        (transport) {
          return Rx.combineLatest2<List<TokenContractAsset>,
              List<TokenContractAsset>, List<TokenContractAsset>>(
            storage.customTokenContractAssetsStream(transport.networkType),
            storage.systemTokenContractAssetsStream(transport.networkType),
            (a, b) => <TokenContractAsset>{...a, ...b}.toList(),
          );
        },
      );

  /// Returns stream of contracts, that could be created for account with
  /// [address].
  /// This is a subtraction from list of available contracts by created token
  /// wallets in scope of account
  Stream<List<TokenContractAsset>> contractsToCreateForAccount(
    Address address,
  ) {
    return Rx.combineLatest3<List<TokenContractAsset>, TransportStrategy,
        KeyAccount?, List<TokenContractAsset>>(
      contractsStream,
      nekotonRepository.currentTransportStream,
      nekotonRepository.seedListStream
          .map((list) => list.findAccountByAddress(address)),
      (contracts, transport, account) {
        final wallets =
            account?.additionalAssets[transport.transport.group]?.tokenWallets;
        if (wallets == null) return contracts;

        return contracts
            .where(
              (contract) =>
                  // take only contracts that is not created for account
                  wallets.none((w) => w.rootTokenContract == contract.address),
            )
            .toList();
      },
    );
  }

  /// Returns stream, that contains 2 lists:
  /// 1-st list of contracts available to enable for account with [address]
  /// 2-nd list of contracts, already enabled for account with [address].
  ///
  /// This is a combination of streams [contractsForAccount] and
  /// [contractsToCreateForAccount].
  Stream<(List<TokenContractAsset>, List<TokenContractAsset>)>
      allAvailableContractsForAccount(Address address) {
    return Rx.combineLatest3<
        List<TokenContractAsset>,
        TransportStrategy,
        KeyAccount?,
        (TransportStrategy, KeyAccount?, List<TokenContractAsset>)>(
      contractsStream,
      nekotonRepository.currentTransportStream,
      nekotonRepository.seedListStream
          .map((list) => list.findAccountByAddress(address)),
      (contracts, transport, account) => (transport, account, contracts),
    ).asyncExpand<(List<TokenContractAsset>, List<TokenContractAsset>)>(
      (value) {
        final transport = value.$1;
        final account = value.$2;
        final contracts = value.$3;

        final wallets =
            account?.additionalAssets[transport.transport.group]?.tokenWallets;
        if (wallets == null) return Stream.value((contracts, []));

        final notCreated = contracts
            .where(
              (contract) =>
                  // take only contracts that is not created for account
                  wallets.none((w) => w.rootTokenContract == contract.address),
            )
            .toList();

        return Stream.fromFuture(
          Future.value(
            () async {
              return (
                notCreated,
                (await Future.wait(
                  wallets.map(
                    (e) =>
                        getTokenContractAsset(e.rootTokenContract, transport),
                  ),
                ))
                    .whereNotNull()
                    .toList(),
              );
            }(),
          ),
        );
      },
    );
  }

  /// Get list of contracts, added to account with [address].
  /// This stream listens for contracts from storage and load contracts if
  /// needed or return it from storage.
  Stream<List<TokenContractAsset>> contractsForAccount(Address address) {
    return nekotonRepository.currentTransportStream.switchMap((transport) {
      return Rx.combineLatest2(
        contractsStream,
        nekotonRepository.seedListStream.map(
          (list) => list.findAccountByAddress(address),
        ),
        // we ignore result of contracts, this needed just to trigger updating
        (a, c) => c,
      ).asyncExpand((account) {
        final group = transport.transport.group;
        final wallets = account?.additionalAssets[group]?.tokenWallets;
        if (wallets == null) return Stream.value([]);

        return Stream.fromFuture(
          Future.wait(
            wallets.map(
              (e) => getTokenContractAsset(e.rootTokenContract, transport),
            ),
          ).then((e) => e.whereNotNull().toList()),
        );
      });
    });
  }

  /// Get token contract if it's already was added to storage or download its
  /// data from blockchain.
  Future<TokenContractAsset?> getTokenContractAsset(
    Address rootTokenContract,
    TransportStrategy transport,
  ) async {
    var asset = storage
            .getCustomTokenContractAssets(transport.networkType)
            .firstWhereOrNull((c) => c.address == rootTokenContract) ??
        storage
            .getSystemTokenContractAssets(transport.networkType)
            .firstWhereOrNull((c) => c.address == rootTokenContract);

    if (asset != null) return asset;

    try {
      if (transport.transport.disposed) return null;

      final tokenRootDetails = await TokenWallet.getTokenRootDetails(
        transport: transport.transport,
        tokenRoot: rootTokenContract,
      );

      asset = TokenContractAsset(
        name: tokenRootDetails.name,
        symbol: tokenRootDetails.symbol,
        decimals: tokenRootDetails.decimals,
        address: rootTokenContract,
        ownerAddress: tokenRootDetails.ownerAddress,
        totalSupply: tokenRootDetails.totalSupply,
        version: tokenRootDetails.version,
        networkType: transport.networkType,
        isCustom: true,
      );

      storage.addCustomTokenContractAsset(asset);

      return asset;
    } catch (e, st) {
      _logger.severe('getTokenContractAsset, $rootTokenContract', e, st);

      return null;
    }
  }

  /// Try getting contract of existed token contract from storage.
  /// This can be helpful when you know, that token exists, but you do not have
  /// direct access to TokenWallet.
  TokenContractAsset? maybeGetTokenContract(
    Address rootTokenContract,
    TransportStrategy transport,
  ) {
    return storage
            .getCustomTokenContractAssets(transport.networkType)
            .firstWhereOrNull((c) => c.address == rootTokenContract) ??
        storage
            .getSystemTokenContractAssets(transport.networkType)
            .firstWhereOrNull((c) => c.address == rootTokenContract);
  }

  /// Get list of current possible system contracts for transport
  List<TokenContractAsset> get currentSystemTokenContractAssets =>
      storage.getSystemTokenContractAssets(
        nekotonRepository.currentTransport.networkType,
      );

  /// Load manifest specified for transport and update system contracts that
  /// user can add to list of its contracts.
  Future<void> _updateSystemContracts(TransportStrategy transport) async {
    if (transport.manifestUrl.isEmpty) return;

    try {
      final encoded = await httpService.getRequest(transport.manifestUrl);
      final decoded = jsonDecode(encoded) as Map<String, dynamic>;

      for (final token in (decoded['tokens'] as List<dynamic>)
          .cast<Map<String, dynamic>>()) {
        token['networkType'] = transport.networkType.name;
        token['version'] =
            intToWalletContractConvert(token['version'] as int).toString();
        token['isCustom'] = false;
      }

      final manifest = TonAssetsManifest.fromJson(decoded);

      storage.updateSystemTokenContractAssets(manifest.tokens);
    } catch (e, st) {
      _logger.severe('_updateSystemContracts', e, st);
    }
  }

  /// Listen for changing contracts and remove old tokens and remove duplicated
  /// tokens that could be moved from custom to system.
  void _contractsUpdateListener(
    List<TokenContractAsset> systemAssets,
    List<TokenContractAsset> customAssets,
  ) {
    final duplicatedAssets = customAssets
        .where((e) => systemAssets.any((el) => e.address == el.address));

    for (final asset in duplicatedAssets) {
      storage.removeCustomTokenContractAsset(asset);
    }

    final oldAssets =
        customAssets.where((e) => e.version == TokenWalletVersion.oldTip3v4);

    for (final asset in oldAssets) {
      storage.removeCustomTokenContractAsset(asset);
    }
  }
}
