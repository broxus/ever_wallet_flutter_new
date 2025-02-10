import 'dart:async';
import 'dart:convert';

import 'package:app/app/service/connection/connection_factory.dart';
import 'package:app/app/service/presets_connection/presets_connection_service.dart';
import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/http/repository/ton_repository.dart';
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
    this.connectionsStorageService,
    this.currentAccountsService,
    this.presetsConnectionService,
    this.httpService,
    this.storage,
    this.connectionFactory,
    this.tonRepository,
  );

  static final _logger = Logger('AssetsService');

  final NekotonRepository nekotonRepository;
  final ConnectionsStorageService connectionsStorageService;
  final CurrentAccountsService currentAccountsService;
  final PresetsConnectionService presetsConnectionService;
  final HttpService httpService;
  final GeneralStorageService storage;
  final ConnectionFactory connectionFactory;
  final TonRepository tonRepository;

  StreamSubscription<TransportStrategy>? _currentTransportSubscription;
  StreamSubscription<KeyAccount?>? _accountsSubscription;
  StreamSubscription<String>? _connectionsSubscription;
  StreamSubscription<void>? _combineSubscription;

  /// Start listening for transport changes and update contracts from manifest
  void init() {
    _currentTransportSubscription =
        nekotonRepository.currentTransportStream.listen(_updateSystemContracts);

    _combineSubscription =
        nekotonRepository.currentTransportStream.flatMap((transport) {
      return Rx.combineLatest2<List<TokenContractAsset>,
          List<TokenContractAsset>, void>(
        storage.systemTokenContractAssetsStream(transport.transport.group),
        storage.customTokenContractAssetsStream(transport.transport.group),
        _contractsUpdateListener,
      );
      // listen needs to enable stream api
      // ignore: no-empty-block
    }).listen((_) {});

    _connectionsSubscription =
        connectionsStorageService.currentConnectionIdStream.listen(
      (_) => updateDefaultAssets(),
    );

    _accountsSubscription =
        currentAccountsService.currentActiveAccountStream.listen(
      (_) => updateDefaultAssets(),
    );
  }

  @disposeMethod
  void dispose() {
    _currentTransportSubscription?.cancel();
    _accountsSubscription?.cancel();
    _connectionsSubscription?.cancel();
    _combineSubscription?.cancel();
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
            storage.customTokenContractAssetsStream(transport.transport.group),
            storage.systemTokenContractAssetsStream(transport.transport.group),
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
                    .nonNulls
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
          ).then((e) => e.nonNulls.toList()),
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
            .getCustomTokenContractAssets(transport.transport.group)
            .firstWhereOrNull((c) => c.address == rootTokenContract) ??
        storage
            .getSystemTokenContractAssets(transport.transport.group)
            .firstWhereOrNull((c) => c.address == rootTokenContract);

    if (asset != null) return asset;

    try {
      if (transport.transport.disposed) return null;

      if (transport.networkType == 'ton') {
        final details = await JettonWallet.getJettonRootDetails(
          transport: transport.transport,
          gqlConnection: connectionFactory.getTonGqlConnection(),
          tokenRoot: rootTokenContract,
        );
        final info = await tonRepository.getTokenInfo(
          address: rootTokenContract,
        );

        asset = TokenContractAsset(
          name: details.content.name ?? info.name ?? 'Unknown token',
          symbol: details.content.symbol ?? info.symbol ?? 'UNKNOWN',
          decimals: details.content.decimals ?? info.decimals ?? 0,
          address: rootTokenContract,
          ownerAddress: details.adminAddress,
          networkType: transport.networkType,
          networkGroup: transport.transport.group,
          logoURI: details.content.uri ?? info.imageUrl,
          isCustom: true,
        );
      } else {
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
          networkGroup: transport.transport.group,
          isCustom: true,
        );
      }

      storage.addCustomTokenContractAsset(asset);

      return asset;
    } catch (e, st) {
      _logger.severe('getTokenContractAsset, $rootTokenContract', e, st);

      return null;
    }
  }

  Future<void> updateDefaultActiveAssets(
    String accountAddress,
    List<String> address,
  ) async {
    return storage.updateDefaultActiveAssets(accountAddress, address);
  }

  List<String> getDefaultActiveAssets(String accountAddress) {
    return storage.getDefaultActiveAssets(accountAddress);
  }

  /// Try getting contract of existed token contract from storage.
  /// This can be helpful when you know, that token exists, but you do not have
  /// direct access to TokenWallet.
  TokenContractAsset? maybeGetTokenContract(
    Address rootTokenContract,
    TransportStrategy transport,
  ) {
    return storage
            .getCustomTokenContractAssets(transport.transport.group)
            .firstWhereOrNull((c) => c.address == rootTokenContract) ??
        storage
            .getSystemTokenContractAssets(transport.transport.group)
            .firstWhereOrNull((c) => c.address == rootTokenContract);
  }

  /// Get list of current possible system contracts for transport
  List<TokenContractAsset> get currentSystemTokenContractAssets =>
      storage.getSystemTokenContractAssets(
        nekotonRepository.currentTransport.transport.group,
      );

  Future<void> updateDefaultAssets() async {
    await Future.delayed(const Duration(seconds: 1), () async {
      final presetsDefaultAssets =
          presetsConnectionService.getDefaultActiveAsset(
        connectionsStorageService.currentConnection.group,
      );

      if (presetsDefaultAssets.isEmpty) {
        return;
      }

      final accountAddress =
          currentAccountsService.currentActiveAccount?.address;

      if (accountAddress == null) {
        return;
      }

      final cachedAccount = nekotonRepository.seedList.findAccountByAddress(
        accountAddress,
      );

      if (cachedAccount == null) {
        return;
      }

      final cachedDefaultAssets =
          getDefaultActiveAssets(accountAddress.address);

      final result = <Address>[];
      final skipped = <String>[];

      for (final preset in presetsDefaultAssets) {
        if (cachedDefaultAssets.contains(preset.address.address)) {
          continue;
        }
        result.add(preset.address);
        skipped.add(preset.address.address);
      }

      if (result.isNotEmpty) {
        await cachedAccount.addTokenWallets(result);
      }
      if (skipped.isNotEmpty) {
        unawaited(
          updateDefaultActiveAssets(
            accountAddress.address,
            skipped,
          ),
        );
      }
    });
  }

  /// Load manifest specified for transport and update system contracts that
  /// user can add to list of its contracts.
  Future<void> _updateSystemContracts(TransportStrategy transport) async {
    if (transport.manifestUrl.isEmpty) return;

    try {
      final encoded = await httpService.getRequest(transport.manifestUrl);
      final decoded = jsonDecode(encoded) as Map<String, dynamic>;

      for (final token in (decoded['tokens'] as List<dynamic>)
          .cast<Map<String, dynamic>>()) {
        token['networkType'] = transport.networkType;
        token['networkGroup'] = transport.transport.group;
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
