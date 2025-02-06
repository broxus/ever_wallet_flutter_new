import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'token_wallet_ordinary_transaction_details_screen.dart';

/// [ElementaryModel] for [TokenWalletOrdinaryTransactionDetailsScreen]
class TokenWalletOrdinaryTransactionDetailsScreenModel extends ElementaryModel {
  TokenWalletOrdinaryTransactionDetailsScreenModel(
    ErrorHandler errorHandler,
    this._assetsService,
    this._nekotonRepository,
  ) : super(errorHandler: errorHandler);

  final AssetsService _assetsService;
  final NekotonRepository _nekotonRepository;

  late final nativeTokenTicker =
      _nekotonRepository.currentTransport.nativeTokenTicker;

  late final nativeTokenIcon =
      _nekotonRepository.currentTransport.nativeTokenIcon;

  TokenContractAsset? getMaybeGetTokenContract(Address rootTokenContract) {
    return _assetsService.maybeGetTokenContract(
      rootTokenContract,
      _nekotonRepository.currentTransport,
    );
  }
}
