import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class AddTip3TokenModel extends ElementaryModel {
  AddTip3TokenModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._assetsService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final AssetsService _assetsService;

  Future<TokenWalletState?> getTokenWallet({
    required Address owner,
    required Address rootTokenContract,
  }) async {
    var wallet = _nekotonRepository.tokenWalletsMap[(owner, rootTokenContract)];

    if (wallet == null) {
      try {
        wallet = await _nekotonRepository.subscribeToken(
          owner: owner,
          rootTokenContract: rootTokenContract,
        );
      } finally {
        _nekotonRepository.unsubscribeToken(owner, rootTokenContract);
      }
    }

    return wallet;
  }

  Stream<(List<TokenContractAsset>, List<TokenContractAsset>)>
      allAvailableContractsForAccount(Address address) =>
          _assetsService.allAvailableContractsForAccount(address);
}
