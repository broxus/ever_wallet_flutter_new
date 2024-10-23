import 'dart:async';

import 'package:app/app/service/assets_service.dart';
import 'package:app/app/service/storage_service/balance_storage_service.dart';
import 'package:app/data/models/token_contract_asset.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

class SelectTokenModel extends ElementaryModel {
  SelectTokenModel(
    ErrorHandler errorHandler,
    this.nekotonRepository,
    this.assetsService,
    this.address,
    this.balanceStorage,
  ) : super(errorHandler: errorHandler) {
    _seedSubscription = nekotonRepository.seedListStream.listen((list) {
      cachedAccount = list.findAccountByAddress(address);
    });
  }

  final NekotonRepository nekotonRepository;
  final AssetsService assetsService;
  final Address address;
  final BalanceStorageService balanceStorage;
  KeyAccount? cachedAccount;
  late StreamSubscription<dynamic> _seedSubscription;

  Stream<(List<TokenContractAsset>, List<TokenContractAsset>)>
      contractsForAccount() {
    return assetsService.allAvailableContractsForAccount(address);
  }

  Future<TokenWalletState> subscribeToken(Address rootTokenContract) {
    return nekotonRepository.subscribeToken(
      owner: address,
      rootTokenContract: rootTokenContract,
    );
  }

  @override
  void dispose() {
    _seedSubscription.cancel();
  }
}
