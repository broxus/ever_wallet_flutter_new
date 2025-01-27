import 'package:app/app/service/connection/connection_factory.dart';
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
    this._connectionFactory,
  );

  final TonRepository _tonRepository;
  final ConnectionFactory _connectionFactory;
  final Map<Address, Symbol> _symbolCache = {};

  @override
  Future<GenericTokenWallet> subscribeToken({
    required Address owner,
    required Address rootTokenContract,
    required Transport transport,
  }) async =>
      JettonTokenWallet.subscribe(
        transport: transport,
        gqlConnection: _connectionFactory.getTonGqlConnection(),
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
}

enum GenericTokenType {
  tip3,
  jetton,
}
