import 'package:app/app/service/http_clients.dart';
import 'package:app/app/service/service.dart';
import 'package:app/http/repository/ton_repository.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

sealed class GenericTokenSubscriber {
  Future<GenericTokenWallet> subscribeToken({
    required Address owner,
    required Address rootTokenContract,
    required Transport transport,
  });
}

class Tip3TokenWalletSubscriber extends GenericTokenSubscriber {
  @override
  Future<GenericTokenWallet> subscribeToken({
    required Address owner,
    required Address rootTokenContract,
    required Transport transport,
  }) =>
      Tip3TokenWallet.subscribe(
        transport: transport,
        owner: owner,
        rootTokenContract: rootTokenContract,
      );
}

class JettonTokenWalletSubscriber extends GenericTokenSubscriber {
  JettonTokenWalletSubscriber(
    this._tonRepository,
    this._storage,
  );

  final TonRepository _tonRepository;
  final AppStorageService _storage;
  final Map<Address, Symbol> _symbolCache = {};
  GqlConnection? _connection;

  @override
  Future<GenericTokenWallet> subscribeToken({
    required Address owner,
    required Address rootTokenContract,
    required Transport transport,
  }) async =>
      JettonTokenWallet.subscribe(
        transport: transport,
        gqlConnection: await _getConnection(),
        owner: owner,
        rootTokenContract: rootTokenContract,
        symbol: await _getSymbol(rootTokenContract),
      );

  Future<Symbol> _getSymbol(Address rootTokenContract) async {
    var symbol = _symbolCache[rootTokenContract];

    if (symbol == null) {
      final info = await _tonRepository.getTokenInfo(
        address: rootTokenContract,
      );

      symbol = Symbol(
        name: info.symbol ?? 'UNKNOWN',
        fullName: info.name ?? 'Unknown token',
        decimals: info.decimals ?? 0,
        rootTokenContract: info.address,
      );
      _symbolCache[rootTokenContract] = symbol;
    }

    return symbol;
  }

  Future<GqlConnection> _getConnection() async =>
      _connection ??= await GqlConnection.create(
        name: 'jetton-gql',
        group: 'jetton-gql',
        client: JettonGqlHttpClient(_storage),
        settings: const GqlNetworkSettings(
          endpoints: ['https://dton.io/graphql/graphql'],
          latencyDetectionInterval: 60000,
          maxLatency: 60000,
          endpointSelectionRetryCount: 5,
          local: false,
        ),
      );
}

enum GenericTokenType {
  tip3,
  jetton,
}
